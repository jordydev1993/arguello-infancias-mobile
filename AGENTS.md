# AGENTS.md — Argüello Infancias Mobile

**El archivo de reglas de la app móvil. Leerlo antes de cada tarea.**

> Alineado con `../AGENTS.md` (raíz), `../arguello-infancias/AGENTS-WEB.md` y el código de este repo (verificado por inspección directa). Ante cualquier contradicción, **el código y las migraciones del repo web son la fuente de verdad**. Lo que no está implementado se marca como *pendiente*.

---

## [1] ROL + FLUJO DE TRABAJO

Actuás como ingeniero principal de este proyecto. **El líder del equipo decide producto, arquitectura y seguridad; vos hacés el trabajo técnico.**

**Para cada funcionalidad, sin excepción:**

1. **Leé las reglas:** este archivo + la skill relevante en `skills/` (`design.md`, `testing.md`, `database.md`) + `docs/00-INDICE.md`. Las skills pueden tener contenido previo a la alineación con la web: ante discrepancia, mandan el código y este archivo.
2. **Inspeccioná** el código actual en `src/`. No asumas: confirmá en el repo.
3. **Escribí un PLAN** en `prompts/NN-nombre-plan.md`:
   - Qué archivos modificás o creás
   - Qué tablas consultás (y con qué política RLS)
   - Cómo cumplís los criterios de aceptación
   - Qué chequeos corrés después
4. **Esperá aprobación** ("✓ Aprobado" / "✕ Cambiar X").
5. **Implementá** el plan.
6. **Chequeá** (ver [7]).
7. **Reportá** los pasos exactos para probarlo.

**No saltees el PLAN. Nunca.**

---

## [2] PRODUCTO: DENTRO / FUERA DE ALCANCE

**Qué es:** app móvil de acompañamiento diario de NNyA en la residencia. Es el complemento del sistema web y **comparte con él la base de datos, las cuentas y los roles**.

**Funcionalidades core y estado:**

| # | Funcionalidad | Datos | Estado |
|---|---------------|-------|--------|
| F1 | Consultar residentes (ficha y tutores) | `nnya`, `nnya_tutores` | Conectada a Supabase |
| F2 | Registrar novedades | `novedades` | Conectada a Supabase |
| F3 | Consultar historial de seguimiento | `novedades`, `incidentes` | Conectada a Supabase |
| F4 | Registrar actividades | `actividades` | Conectada a Supabase |
| F5 | Mi turno: novedades y actividades recientes | `novedades`, `actividades` | Parcial: el **horario del turno y las notas del turno anterior son datos de demostración** (`src/data/turno.ts`); `turnos_personal` está vacía |
| F6 | Reportar situación crítica | `incidentes`, `legajos` | Conectada a Supabase. Resuelve el **legajo activo** de cada NNyA (`incidentes.legajo_id` es NOT NULL) y avisa si no lo tiene |

**Fuera de alcance (no sobreconstruir):**
- Comentarios o réplicas en novedades
- Multimedia (video, audio); solo foto estática
- Notificaciones push (v2)
- Modo offline con sincronización (v2)
- Redes sociales, gamificación, videollamadas
- Reportes PDF/Excel (v2)
- Funcionalidad administrativa: usuarios, roles, auditoría (viven en la web)

---

## [3] ARQUITECTURA

```
┌──────────────────────────────────────────────────┐
│  EXPO / REACT NATIVE (cliente móvil)             │
│  - Pantallas en src/app/ ((auth), (tabs), ...)   │
│  - Estado de cliente: Zustand                    │
│  - Estado de servidor: TanStack Query            │
│  - Cliente Supabase (sesión en SecureStore)      │
└───────────────────────┬──────────────────────────┘
                        │ supabase-js (HTTPS + JWT)
                        ▼
┌──────────────────────────────────────────────────┐
│  SUPABASE: Auth + PostgreSQL con RLS             │
│  - Mismo proyecto y misma base que la web        │
│  - Audit log por triggers                        │
└──────────────────────────────────────────────────┘
```

**No hay backend Express ni API REST propia.** La app consulta y escribe directo en Supabase con `supabase-js`; la autorización la garantiza RLS.

**Reglas de arquitectura:**
- Secretos NUNCA en el cliente. Solo se usan `EXPO_PUBLIC_SUPABASE_URL` y `EXPO_PUBLIC_SUPABASE_ANON_KEY` (la anon key; jamás la `service_role`), que quedan embebidas en el bundle.
- La sesión (JWT) se persiste en **Expo SecureStore** (`src/lib/supabase.ts`, `src/lib/storage.ts`). `AsyncStorage` (`cache`) es solo para datos NO sensibles: nunca datos de NNyA ni credenciales.
- La autorización real está en **RLS en la base**; la UI solo oculta.
- La validación crítica vive en la base (`CHECK`, `UNIQUE`, `NOT NULL`); en el cliente se valida el formato con zod (`src/lib/validation.ts`).
- Audit log: el trigger `fn_audit_trigger()` registra INSERT/UPDATE/DELETE en las tablas de negocio.

---

## [4] STACK TÉCNICO + PROHIBICIONES

**Usar siempre:**
- `Expo ~57` (managed) + `React Native 0.86` + TypeScript strict
- `Expo Router` para navegación
- `NativeWind 4` + `Tailwind CSS 3.4` (no StyleSheet suelto)
- `Zustand` para estado de cliente (sesión, selección, UI)
- `TanStack Query 5` para datos del servidor (un hook por operación en `src/hooks/`)
- `@supabase/supabase-js` para auth + datos
- `zod 4` para validación de formato
- Fuente `Poppins` (en `assets/fonts/`)

**Autenticación:** Supabase Auth con email y contraseña, sesión persistente y `autoRefreshToken`. MFA/TOTP **no está implementado** (pendiente, igual que en la web).

**No usar nunca:**
- Redux ni Context API para estado global (usar Zustand)
- Clerk o Firebase Auth (solo Supabase)
- Axios (solo `fetch` o `supabase-js`)
- GraphQL
- `react-hook-form` (formularios simples sin librería)
- Tailwind UI (usar los tokens propios de `src/theme/` y `design-tokens.json`)
- Agregar dependencias sin justificar la necesidad primero

---

## [5] MODELO DE DATOS

**La app móvil no tiene tablas propias salvo `novedades`.** Reutiliza el modelo de la web (28 tablas). La fuente de verdad es `../arguello-infancias/supabase/migrations/` y `../arguello-infancias/AGENTS-WEB.md`.

### Tablas que consume la app

| Tabla | Uso en mobile | Origen |
|-------|---------------|--------|
| `nnya` | "Residentes": lista y detalle (F1) | Web. **Mobile reusa `nnya`**; no existe tabla `residentes` |
| `nnya_tutores` (+ `tutores`) | Tutores del residente (F1) | Web |
| `novedades` | Registro y consulta de novedades (F2, F3, F5) | **Nueva, de mobile** |
| `actividades` | Registro y consulta de actividades (F4, F5). Es grupal: `nnya_ids` (array) | Web |
| `incidentes` | Situación crítica (F6) y timeline (F3) | Web |
| `usuarios` + `roles` | Resolver usuario y rol al iniciar sesión | Web |
| `turnos_personal` | Turno (F5). **Vacía**, no se consulta todavía | Web |

### Cambios de mobile sobre el schema compartido

Migración `20260912000035_add_columnas_mobile_nnya.sql` (columnas nuevas de `nnya`):

```
foto_url             TEXT NULL
alertas_importantes  TEXT NULL
turno_escolar        VARCHAR(50) NULL  CHECK (NULL o 'Mañana','Tarde','Noche','Doble Jornada')
```

Migración `20260912000036_create_novedades.sql`:

```
novedades
  id           UUID PK
  nnya_id      UUID NOT NULL → nnya(id)
  usuario_id   UUID NULL → usuarios(id) ON DELETE SET NULL
  tipo         VARCHAR(50) NOT NULL CHECK IN ('Salud','Educación','Comportamiento',
               'Alimentación','Visita Familiar','Otro')
  descripcion  TEXT NOT NULL
  fecha_hora   TIMESTAMPTZ NOT NULL DEFAULT NOW()
  created_at, updated_at
Índice: idx_novedades_nnya_fecha (nnya_id, fecha_hora DESC)
RLS: solo Admin y Equipo Tecnico (get_my_role())
```

### Reglas del modelo

- **Baja lógica de NNyA:** campo `activo`; nunca se borra físicamente un NNyA.
- **`audit_log`** (compartido con la web): columnas `tabla`, `operacion` (INSERT/UPDATE/DELETE), `id_registro`, `datos_antes`, `datos_despues`, `auth_uid`, `fecha`. Solo el rol `Admin` puede leerlo; nadie puede editarlo ni borrarlo.
- Los nombres de tablas y columnas de versiones anteriores de este documento (`perfiles_usuarios`, `residentes`, `turnos_trabajo`, `residentes_turnos`, `actividades_diarias`, `situaciones_criticas`, `residente_id`, `tipo_novedad`, `deleted_at`) **no existen**. No usarlos.

---

## [6] ACCESO A DATOS (reemplaza al antiguo contrato REST)

No hay endpoints propios. Cada operación es un hook en `src/hooks/` que llama a Supabase:

| Hook | Tabla(s) | Operación |
|------|----------|-----------|
| `useResidents` | `nnya`, `nnya_tutores` | Lectura (lista, detalle, tutores) |
| `useObservations` | `novedades` | Lectura y alta |
| `useActivities` | `actividades` | Lectura (filtra por `nnya_ids`) y alta |
| `useCriticalIncidents` | `incidentes`, `legajos` | Lectura y alta (una fila por NNyA seleccionado, con su legajo activo) |
| `useShiftInfo` | `novedades`, `actividades` | Lectura. El horario del turno es mock (`src/data/turno.ts`) |
| `useAuth` / `authStore` | `usuarios`, `roles` | Resolver usuario y rol |

Reglas:
- Cada mutación invalida las query keys afectadas (`queryClient.invalidateQueries`).
- Los campos NOT NULL de la base que la UI no pide se completan en el hook (ej.: `actividades.fecha` y `titulo`).
- Un hook por operación; no llamar a `getSupabase()` desde las pantallas.

---

## [7] CHEQUEOS OBLIGATORIOS (después de CADA implementación)

```bash
npm run typecheck     # tsc --noEmit: sin errores
npm run lint          # expo lint: sin warnings
```

En Expo Go (`npm start`):
- Abre la app e inicia sesión con un usuario Admin o Equipo Técnico.
- Navega entre tabs; los datos llegan de la base.
- Se guarda algo y se ve reflejado.

En la base (SQL editor de Supabase, con rol Admin):

```sql
SELECT COUNT(*) FROM novedades;
SELECT * FROM audit_log WHERE tabla = 'novedades' ORDER BY fecha DESC LIMIT 5;
```

Verifica que la auditoría registró el cambio. **No reportes "listo" hasta que todo pase.** (No hay suite de tests automatizados todavía: los criterios de `skills/testing.md` se verifican a mano.)

---

## [8] DISEÑO + COMPONENTES

Leer `skills/design.md` y `design-tokens.json` para colores, tipografía Poppins, escala de espaciado, componentes reutilizables (`src/components/`) y accesibilidad (WCAG AA).

---

## [9] CRITERIOS DE ACEPTACIÓN

Leer `skills/testing.md`. Cada funcionalidad pasa todos sus criterios antes de darse por terminada:
- F1: CA-01 a CA-07 · F2: CA-08 a CA-17 · F3: CA-18 a CA-24
- F4: CA-25 a CA-32 · F5: CA-33 a CA-40 · F6: CA-41 a CA-51

---

## [10] REGLAS DE NEGOCIO Y SEGURIDAD

- **Roles:** solo **Admin** y **Equipo Técnico**. `authStore` resuelve el rol real desde `usuarios`/`roles` y rechaza el login si el usuario está inactivo o su rol no está permitido.
- **Alcance de datos:** hoy ambos roles ven **todos** los NNyA (RLS por rol, no por asignación). No existe una restricción "solo los residentes asignados"; no asumirla.
- **Auditoría:** todos los cambios quedan en `audit_log` por trigger. Nunca borrar registros de novedades ni de incidentes.
- **Timestamps:** `fecha_hora` se completa automáticamente en la base.
- **Validación:** la base es la fuente de verdad; el cliente valida el formato.
- **Datos sensibles:** el DNI está en texto plano en la base (decisión documentada en el repo web). No afirmar cifrado. No guardar datos de NNyA en `AsyncStorage`.
- **Offline:** v1 no lo soporta; se asume conectividad.
- **Secretos:** solo la anon key en el cliente; el resto, jamás en Expo.

### Pendiente y deuda conocida

- MFA (TOTP), rate limiting y timeout de sesión por inactividad.
- Horario de turno y notas del turno anterior con datos reales (depende de poblar `turnos_personal`).
- Tests automatizados.
- `skills/*.md` y `docs/` pueden conservar el modelo anterior (tablas `residentes`, Express, roles educador/coordinador); no fueron revisados en esta alineación.

---

## RESUMEN ULTRA-CORTO (para el prompt diario)

```
Sos ingeniero principal. Para cada funcionalidad:

1. Leé AGENTS.md (este archivo) y ../AGENTS.md
2. Leé las skills relevantes e inspeccioná src/
3. Escribí el PLAN en prompts/NN-nombre-plan.md
4. Esperá aprobación (✓)
5. Implementá
6. Corré typecheck y lint
7. Reportá los pasos exactos para probar

Sin backend propio: supabase-js + RLS. Dos roles: Admin y Equipo Tecnico.
No saltees el PLAN. Nunca.
```

---

**Versión:** 2.0 (alineada con la web y el código)
**Metodología:** Vibe Engineering + SDD
