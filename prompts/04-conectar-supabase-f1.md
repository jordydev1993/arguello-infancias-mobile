# PLAN 04 — Conectar mobile a Supabase (auth real + F1 con datos reales)

**Fecha:** 2026-09-13
**Autor:** Claude (ingeniero principal)
**Estado:** ✅ Implementado 2026-09-13, pendiente de verificación manual (§7)
**Origen:** tarjeta del tablero `#16`. Última pieza de datos: las decisiones #1-#4 y las tarjetas #9/#10 (migración `nnya`, tabla `novedades`) ya están cerradas — esto es lo que faltaba para dejar de correr sobre mock.

---

## 0. Por qué este plan es más grande que "wirear el cliente"

`src/lib/supabase.ts` ya existe y está bien armado — conectar el cliente en sí es trivial. Lo que hace grande esta tarea es que **los mocks actuales no coinciden con la realidad** en 3 frentes distintos, y F1 (la única feature construida) los usa todos:

1. **Roles ficticios.** `src/types/user.ts` tiene `UserRole = 'educador' | 'operador_convivencial' | 'tecnico'` — no son los roles reales (`Admin`, `Administrador`, `Equipo Tecnico`, y las 4 legacy). Ya sabemos el mapeo real (decisión #1).
2. **Asignación individual NNA↔educador.** `Resident.primary_caregiver_id` y el filtro `residentesAsignados(user.id)` asumen exactamente el modelo que la decisión #2 descartó — la guardia atiende a todos los NNA, no hay asignación por chico.
3. **Campos que no existen en `nnya`.** `first_name`/`last_name`/`birthdate`/`status`/`health_insurance`/`emergency_contact` no son columnas reales. `nnya` tiene `nombre`/`apellido`/`fecha_nacimiento`/`estado_actual`/`obra_social`; `emergency_contact` no es un campo — es el tutor marcado `es_principal` en `nnya_tutores`.

Conectar "de verdad" significa corregir estos 3 puntos, no solo cambiar `queryFn`.

## 1. Verificación previa contra la base real

Antes de escribir el plan confirmé, contra el proyecto Supabase real:
- Solo **1 usuario** tiene `auth_user_id` seteado hoy: `admin@arguelloinfancias.com` (rol `Admin`). Los otros 6 (roles legacy: Psicólogo/a, Trabajador Social ×2, Médico/a, Abogado/a, Administrador) no tienen `auth_user_id` — es el "rol rot" ya trackeado en issue #24 (web), **no lo toco acá**.
- Esto significa: **hoy solo se puede probar el login en mobile con la cuenta Admin.** No hay ninguna cuenta `Equipo Tecnico` real todavía (el rol que decisión #1 mapeó a "educador", el uso típico de mobile). Lo señalo como limitación de la verificación manual (§7), no la resuelvo acá — crear cuentas de prueba es distinto de "conectar el cliente".

---

## 2. Alcance

### Dentro
1. **Cliente Supabase**: sesión persistida en `expo-secure-store` (vía el adapter `secure` que ya existe en `src/lib/storage.ts`, sin usar hasta ahora).
2. **Auth real**: `authStore.login` → `supabase.auth.signInWithPassword` + resolver el rol real desde `usuarios`/`roles`. Rechazar roles fuera de `Admin`/`Administrador`/`Equipo Tecnico` con un mensaje claro (en vez de dejarlos entrar y ver pantallas vacías por RLS).
3. **`Resident`/`User` types**: reshape a los campos reales.
4. **F1 con datos reales**: `useResidents`/`useResident` contra `nnya` (+ tutor principal para "contacto de emergencia", CA-04).
5. **UI de F1**: `ResidentCard`, pantalla de detalle, `ResidentStatusBadge` (4 estados reales, no 2).
6. Ajustar los 2 mocks (`data/residentes.ts`, `data/usuarios.ts`) para que seguir compilando bajo los tipos nuevos — **sin borrarlos**: `turno.ts`/`actividades.ts`/`novedades.ts` (F5/F4/F2, todavía mock) dependen de ellos.

### Fuera (a propósito)
- ❌ F2/F3/F4/F5/F6 (`useObservations`, `useActivities`, `useShiftInfo`) — siguen sobre mock, son las tarjetas #11-#15.
- ❌ Backend Express — ya descartado (decisión #4).
- ❌ Arreglar el rol rot (issue #24, web) — solo lo señalo como limitación de testing.
- ❌ Corregir `AGENTS.md` de mobile (7 tablas, roles viejos, arquitectura Express) — es la tarjeta #8 de Sofi, ya sé que está mal, no lo piso.
- ❌ Crear una cuenta de prueba `Equipo Tecnico` — decisión de Jordy si hace falta, no la tomo yo.

---

## 3. Archivos a modificar (ninguno nuevo)

```
src/lib/supabase.ts          storage adapter + persistSession
src/types/user.ts            UserRole real, User real
src/store/authStore.ts       login/logout reales, hydrate vía supabase.auth.getSession()
src/types/resident.ts        Resident real + ContactoEmergencia
src/utils/constants.ts       RESIDENT_STATUSES real (4 valores); quitar MOCK_LOGIN_HINT
src/components/ui/StatusBadge.tsx   ResidentStatusBadge: 4 estados
src/hooks/useResidents.ts    queries reales contra nnya + nnya_tutores/tutores
src/components/ResidentCard.tsx     nombres de campo
src/app/residentes/[id].tsx  InfoTab: nombres de campo
src/app/(tabs)/residentes.tsx  copy del subtítulo (ya no "asignados")
src/app/(auth)/login.tsx     quitar el hint de credenciales demo
src/data/residentes.ts       renombrar campos del mock (sigue usándolo turno.ts)
src/data/usuarios.ts         EDUCADOR_MOCK.role a un valor real; quitar findMockUser/MOCK_CREDENTIALS (huérfanos tras este plan)
```

---

## 4. Diseño

### 4.1 `src/lib/supabase.ts`
```ts
import { secure } from '@/lib/storage';
// ...
client ??= createClient(url!, anonKey!, {
  auth: { storage: secure, persistSession: true, autoRefreshToken: true, detectSessionInUrl: false },
});
```
`secure` ya expone `get/set/remove` — falta adaptarlo a la interfaz `getItem/setItem/removeItem` que espera Supabase (wrapper de 3 líneas).

### 4.2 `src/types/user.ts`
```ts
export type UserRole = 'Admin' | 'Administrador' | 'Equipo Tecnico';

export type User = {
  id: string;            // usuarios.id (no el auth uid)
  auth_user_id: string;
  email: string;
  nombre: string;
  apellido: string;
  role: UserRole;
};
```

### 4.3 `src/store/authStore.ts`
- `login(email, password)`: `signInWithPassword` → si ok, `select id, nombre, apellido, activo, roles(nombre) from usuarios where auth_user_id = <uid>`. Si `!activo` o el rol no está en `ALLOWED_ROLES`, `signOut()` y devolver error explicando por qué (usuario inactivo / rol sin acceso a mobile) — evita el caso confuso de "entré pero no veo nada" que causaría el rol rot de issue #24 si alguna vez se le da `auth_user_id` a un rol legacy.
- `hydrate()`: en vez de leer `cache` (AsyncStorage), llama `supabase.auth.getSession()`. Si hay sesión, repite la resolución de rol de arriba; si no, `user: null`. Se saca la dependencia del `cache`/`STORAGE_KEYS.authSession` — la sesión persistida por Supabase (vía SecureStore) pasa a ser la única fuente de verdad, así que no queda un `User` cacheado desactualizado si cambió el rol o se desactivó la cuenta.
- `logout()`: `supabase.auth.signOut()`.

### 4.4 `src/types/resident.ts`
```ts
export type ResidentStatus = 'En residencia' | 'En proceso de egreso' | 'Egresado' | 'Fallecido';

export type ContactoEmergencia = {
  nombre: string;
  apellido: string;
  parentesco: string;
  telefono: string | null;
};

export type Resident = {
  id: string;
  nombre: string;
  apellido: string;
  fecha_nacimiento: string;
  estado_actual: ResidentStatus;
  foto_url: string | null;
  alertas_importantes: string | null;
  obra_social: string | null;
  turno_escolar: string | null;
  contacto_emergencia: ContactoEmergencia | null;
};
```

### 4.5 `src/hooks/useResidents.ts`
```ts
export function useResidents() {
  const { user } = useAuth();
  return useQuery<Resident[]>({
    queryKey: ['residents'],
    enabled: Boolean(user),
    queryFn: async () => {
      const { data, error } = await getSupabase()
        .from('nnya')
        .select('id, nombre, apellido, fecha_nacimiento, estado_actual, foto_url, obra_social, turno_escolar, alertas_importantes')
        .eq('estado_actual', 'En residencia')
        .order('apellido');
      if (error) throw error;
      return (data ?? []).map((n) => ({ ...n, contacto_emergencia: null }));
    },
  });
}
```
**Decisión de diseño**: el listado muestra solo `estado_actual = 'En residencia'` (no egresados/fallecidos) — es acompañamiento diario, no un histórico. `contacto_emergencia` va `null` en el listado (no hace falta ahí, solo en detalle) para no pagar el join extra por cada fila.

`useResident(id)` hace 2 queries: la fila de `nnya`, y por separado `nnya_tutores` (filtrado por `nnya_id` + `es_principal = true`) con `tutores(nombre, apellido, parentesco, telefono)` embebido — deliberadamente NO uso `!inner` en un solo query, porque eso excluiría el NNA entero si todavía no tiene tutor principal cargado (falso negativo). Sin `user` ya no hay chequeo de `primary_caregiver_id` — si RLS no deja ver la fila, `nnya` viene `null` y se muestra el mismo `ErrorState` de "no tenés autorización" que ya existe.

### 4.6 UI
- `ResidentCard.tsx` / `[id].tsx`: `first_name+last_name` → `nombre+apellido`; `birthdate` → `fecha_nacimiento`; `photo_url` → `foto_url`; `status` → `estado_actual`; `health_insurance` → `obra_social`; `emergency_contact` → `contacto_emergencia` (mismos campos, distinto origen).
- `ResidentStatusBadge`: `En residencia` → success, `En proceso de egreso` → pending, `Egresado` → neutral, `Fallecido` → critical.
- `residentes.tsx`: subtítulo `"NNA asignados a tu acompañamiento"` → `"Residentes de la institución"` (ya no hay asignación individual).
- `login.tsx`: se quita la línea `"Demo — usá usuario@test.com / password123"`.

### 4.7 Mocks que siguen vivos (F2/F4/F5)
`data/residentes.ts` y `data/usuarios.ts` los sigue usando `data/turno.ts` (F5, todavía mock) — no se borran, se les renombran los campos para que compilen contra los tipos nuevos:
- `RESIDENTES_MOCK`: `first_name/last_name/birthdate/status/health_insurance/emergency_contact` → los nombres reales. `primary_caregiver_id` se mueve a un tipo local `MockResident = Resident & { primary_caregiver_id: string }` dentro del mismo archivo (ya no es parte de `Resident`, pero `residentesAsignados()` — que usa solo `turno.ts` — lo sigue necesitando para su propio filtro de mock; no toco esa función, sigue devolviendo lo mismo que antes).
- `EDUCADOR_MOCK.role`: `'educador'` → `'Equipo Tecnico'` (para que siga siendo un `User` válido).
- `findMockUser`/`MOCK_CREDENTIALS`: quedan huérfanos (ya nada los importa tras 4.3) — se borran.

---

## 5. Seguridad / RLS

Nada nuevo que crear — `nnya`/`nnya_tutores`/`tutores` ya tienen RLS `Admin`/`Equipo Tecnico` desde el schema original. El gate de rol en el login (§4.3) es un control de UX en el cliente, no de seguridad — la seguridad real sigue siendo RLS en la base, como corresponde (decisión #4).

---

## 6. Validaciones automáticas

```bash
npx tsc --noEmit
npm run lint
```

---

## 7. Verificación manual (para vos, Jordy)

```bash
cd mobile
cp .env.example .env
# completar con la URL + anon key reales (están en GUIA-CLONAR-PROYECTOS.md)
npx expo start
```

1. Login con `admin@arguelloinfancias.com` (única cuenta real hoy, ver §1) → debería entrar.
2. Pantalla Residentes → debería listar los NNA reales con `estado_actual = 'En residencia'` (nombre, edad, estado).
3. Tocar uno → detalle con datos reales; si ese NNA tiene un tutor marcado `es_principal`, aparece en "Contacto de emergencia"; si no, dice "Sin datos" (no rompe).
4. Cerrar la app y reabrirla → debería seguir logueado (sesión persistida).
5. Logout → vuelve a login; reabrir la app → pide login de nuevo (sesión realmente borrada, no solo la UI).

**Limitación conocida**: no hay forma de probar hoy con una cuenta `Equipo Tecnico` real (§1) — si querés, decime y coordino con vos crear una, pero no lo hago sin que lo pidas explícitamente (es una cuenta con acceso real a datos de NNA).

---

## 8. Criterios de aceptación

| # | Criterio |
|---|---|
| D-01 | Login real contra Supabase Auth; sesión persiste entre reinicios de la app |
| D-02 | Un usuario con rol fuera de `Admin`/`Administrador`/`Equipo Tecnico` (o inactivo) recibe un error claro, no un login silencioso sin datos |
| D-03 | F1 lista `nnya` reales (`estado_actual = 'En residencia'`), sin ninguna asignación individual (decisión #2) |
| D-04 | Detalle de residente muestra datos reales + contacto de emergencia (tutor principal) cuando existe |
| D-05 | `ResidentStatusBadge` cubre los 4 estados reales de `nnya.estado_actual` |
| D-06 | `data/turno.ts` (F5, mock) sigue compilando y funcionando sin cambios de comportamiento |
| D-07 | `npx tsc --noEmit` y `npm run lint` sin errores |

---

## 9. Tiempo estimado
~1h (cliente + auth: 20 min · tipos + hooks F1: 20 min · UI: 15 min · mocks/limpieza: 10 min · validación: 5 min).

---

**Aprobación:** ✓ Aprobado (2026-09-13)

## 10. Resultado

Implementado tal como diseñado en §4, con 2 correcciones que aparecieron durante la implementación (no estaban en el plan original):

- **`User.full_name` se eliminó** (reemplazado por `nombre`+`apellido` separados) y eso rompía 3 pantallas más que no estaban en la lista de archivos del plan: `inicio.tsx`, `perfil.tsx` (incluía además un `ROLE_LABEL` con los roles ficticios viejos — corregido a los 3 roles reales) y los 3 mocks que arman texto con `EDUCADOR_MOCK.full_name` (`actividades.ts`, `novedades.ts`, `turno.ts`). Detectado por `tsc --noEmit`, no por inspección manual — confirma por qué el chequeo automático importa.
- `residentePorId()` en `data/residentes.ts` quedó sin ningún llamador tras el rewrite de `useResidents.ts` — se borró en vez de dejarlo muerto.
- El embed `roles(nombre)` de Supabase necesitó un cast por `unknown` (TS no puede inferir la cardinalidad del embed sin `Database` generado — mismo problema de fondo que documenta `AGENTS-WEB.md` sobre `types/database.types.ts` escrito a mano, del lado mobile).

Validaciones corridas:
- `npx tsc --noEmit` → limpio.
- `npm run lint` → limpio.
- Barrido final (`grep`) confirmando cero referencias colgantes a los campos viejos (`first_name`, `birthdate`, `health_insurance`, `emergency_contact`, `primary_caregiver_id`, `resident.status`) fuera de donde correspondía dejarlas (el mock de F5).
- **Pendiente**: la verificación manual de §7 (login + F1 en el dispositivo/emulador) — no la hice yo, ver mensaje de handoff.
