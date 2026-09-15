# PLAN 08 — F6: Reportar situación crítica (issue #15)

**Fecha:** 2026-09-15
**Estado:** ✅ Implementado y verificado 2026-09-15 (typecheck/lint/doctor + prueba manual en
navegador contra la base real, insert confirmado y limpiado)
**Repo:** `arguello-infancias-mobile` (único repo activo, ver `prompts/03-...` y decisión del 2026-09-15)
**Tarjeta:** [#15](https://github.com/jordydev1993/arguello-infancias-mobile/issues/15) F6 Situación crítica — form WF-14/15, multi-select NNA, selector tipo, confirmación, submit (En curso, Alta)

---

## 0. Por qué este orden

De las 7 tarjetas mobile pendientes de Jordy, #15 ya está "En curso" y es Alta prioridad — la sigo
en vez de arrancar algo nuevo. Después de esta sigo con #11/#12 (F2/F4, Alta), que quedan
desbloqueadas para Cami (#21) y Meli (#19).

---

## 1. Inspección — lo que ya existe

- `src/app/(tabs)/critica.tsx`: pantalla de advertencia (WF-13) ✅ terminada — cubre CA-41
  (acceso diferenciado, tab roja) y CA-42 (advertencia antes de continuar). El botón "Continuar"
  hoy solo dispara un `Alert.alert` placeholder.
- `src/types/critical.ts` + `CriticalIncidentSchema` (`src/lib/validation.ts`): ya existen pero
  **desalineados con el schema real** (ver §2) — son del período mock, antes de conectar Supabase.
- `src/utils/constants.ts`: `CRITICAL_INCIDENT_TYPES`/`_LABELS` ya coinciden exactamente con
  CA-44/WF-14 (violencia, crisis_emocional, accidente, fuga, emergencia_sanitaria, otra). Reusar
  tal cual.
- No hay ningún hook de mutación (`create`) en toda la app todavía — F1 es solo lectura. Este es
  el primer `insert` real del proyecto.
- Componentes reusables ya cubren todo lo que hace falta: `SelectField` (single-select),
  `TextAreaField`, `CriticalButton`, `PrimaryButton`, `SecondaryButton`, `ScreenHeader` (tiene
  `tone="critical"`, ya pensado para esto). **No hay multi-select** — no hay `situaciones_criticas`
  wireframe que lo use en otro lado, así que lo resuelvo inline en la pantalla (checklist simple
  sobre `useResidents()`), sin crear un componente genérico nuevo — si Cami en #20/#21 quiere
  extraerlo a `MultiSelectField` reusable, es su call de diseño.

## 2. Inspección — schema real (consultado en vivo vía Supabase MCP, no la doc vieja)

Tabla real `incidentes` (no `situaciones_criticas` — decisión ya resuelta, ver
`CORRECCIONES-Y-DUDAS-PARA-MELI-SOFI.md` §2):

```
id uuid PK · nnya_id uuid NOT NULL FK→nnya(id) ON DELETE CASCADE  (una fila = un NNA, no array)
legajo_id uuid NULL FK→legajos(id)      -- mobile no maneja legajo, se deja NULL
tipo varchar NOT NULL                    -- SIN check en DB (ver hallazgo abajo)
descripcion text NOT NULL
fecha_hora timestamptz NOT NULL default now()
gravedad varchar NOT NULL default 'media'  CHECK IN (leve, media, grave, critico)
reportado_por uuid NULL FK→usuarios(id) ON DELETE SET NULL
acciones_tomadas text NULL
estado varchar NOT NULL default 'abierto'  CHECK IN (abierto, en_seguimiento, cerrado)
gravedad_sugerida varchar NULL           -- feature de IA del lado web, no lo toca mobile
sugerencia_aceptada boolean NOT NULL default false
created_at / updated_at timestamptz
```

RLS: `incidentes_admin_tecnico_all` — solo roles `Admin`/`Equipo Tecnico` (vía `get_my_role()`)
pueden leer/escribir. El usuario demo mobile (`admin@arguelloinfancias.com`, rol `Admin`) cumple —
verificado contra la tabla `usuarios` real. `reportado_por` = `usuarios.id` del usuario logueado,
que ya resuelve `useAuth().user.id` (no `auth.users.id` directo — `authStore.ts` ya hace ese join).

**3 hallazgos que cambian el plan original:**

1. **`nnya_id` es singular, no array.** El wireframe pide selector múltiple (CA-43) pero la tabla
   real vincula un incidente a **un solo NNA**. Selección múltiple en la UI → un `insert` por cada
   NNA seleccionado (mismo tipo/descripción/acciones, `Promise.all`). Satisface CA-43 sin tocar el
   schema compartido con la web.
2. **`people_notified` (WF-14 "Personas notificadas") no existe como columna.** No hay dónde
   persistirlo. Lo saco del formulario — no voy a construir un campo que no se guarda. Si el equipo
   lo quiere de verdad, es una migración de DB a coordinar con Sofi/Meli (issue nuevo, no este).
3. **`gravedad` es NOT NULL pero no está en el wireframe ni en los CA.** Dejo que la DB use su
   default (`'media'`) — no se pide en el form. Si más adelante hace falta, es un campo fácil de
   agregar.
4. **`tipo` no tiene CHECK constraint** — hoy conviene valores de la web sin acentos/minúscula
   (`salud`, `fuga`, `conductual`) que no coinciden con CA-44. Uso los valores de CA-44/constants.ts
   igual (es el contrato de mobile), documentado acá para que quien reescriba
   `CORRECCIONES-MODELO-DATOS-ARGUELLO.md` (issue #7 de Sofi) lo tenga en cuenta.

## 3. Alcance de esta tarea

**Dentro:** CA-43 a CA-49 (selección NNA, tipo, descripción, acciones tomadas, fecha/hora+usuario
automáticos, validación, confirmación, guardado real + mensaje de éxito). CA-41/42/51 ya están.

**Fuera (se coordina con #13, F3 Historial):** CA-50 (que el incidente aparezca diferenciado en el
historial del NNA). Dejo lista `useCriticalIncidents(nnyaId)` (lectura) para que #13 la consuma
directo al construir el timeline — no construyo acá la UI del historial, sería pisar el alcance de
esa tarjeta.

## 4. Archivos

| Archivo | Cambio |
|---|---|
| `src/types/critical.ts` | Reescribir para matchear columnas reales: `CriticalIncident` (una fila de `incidentes`) y `NewCriticalIncident` (`nnya_ids: string[]`, `tipo`, `descripcion`, `acciones_tomadas?`). Saco `minor_ids`/`people_notified`/`reported_by_name`. |
| `src/lib/validation.ts` | `CriticalIncidentSchema`: `nnya_ids` (min 1), `tipo` (enum `CRITICAL_INCIDENT_TYPES`), `descripcion` (20-1000, sin cambios), `acciones_tomadas` (opcional, max 1000). Saco `minor_ids`/`people_notified`. |
| `src/hooks/useCriticalIncidents.ts` (nuevo) | `useCreateCriticalIncident()` (mutation: 1 insert por `nnya_id`, `reportado_por` = `useAuth().user.id`) + `useCriticalIncidents(nnyaId)` (query de lectura, para #13). |
| `src/app/situacion-critica.tsx` (nuevo) | Pantalla con 2 pasos locales (`'form' | 'confirm' | 'success'`): form (checklist NNA sobre `useResidents()`, `SelectField` tipo, `TextAreaField` descripción + acciones) → confirmación (resumen, `SecondaryButton` "Volver a editar" + `CriticalButton` "Confirmar reporte") → éxito ("Situación reportada" + botón volver a Inicio). `ScreenHeader tone="critical"`. |
| `src/app/(tabs)/critica.tsx` | El botón "Continuar" pasa de `Alert.alert` a `router.push('/situacion-critica')`. |
| `src/app/_layout.tsx` | Agregar `<Stack.Screen name="situacion-critica" />` (mismo patrón que `residentes/[id]`). |

Sin cambios en `constants.ts` (los tipos ya están bien) ni en tablas/RLS de Supabase (no hace
falta ninguna migración para esto).

## 5. Validación (Zod) y guardado

- Igual que F1, patrón directo a Supabase (`getSupabase().from('incidentes').insert(...)`), sin
  API Express intermedia (decisión #4 ya resuelta a favor de cliente directo).
- Error de guardado (RLS/red): mensaje de error inline en la pantalla de confirmación, sin perder
  los datos ingresados (el usuario puede reintentar sin volver a tipear).

## 6. Chequeos (AGENTS.md §7)

```bash
npm run typecheck
npm run lint
npx expo-doctor
```

Prueba manual (`npx expo start`, login `admin@arguelloinfancias.com`):
1. Tab Crítica → advertencia → Continuar.
2. Seleccionar 1+ NNA, tipo, descripción (<20 chars → error), acciones tomadas opcional.
3. Confirmar → pantalla de resumen → Confirmar reporte.
4. Ver "Situación reportada" → volver a Inicio.
5. Verificar en Supabase (`select * from incidentes order by created_at desc`) que se creó una
   fila por cada NNA seleccionado, con `reportado_por` = usuario logueado y `fecha_hora` ≈ ahora.

## 7. Riesgos

| Riesgo | Mitigación |
|---|---|
| Insert falla por RLS si el usuario de prueba no es Admin/Equipo Tecnico | Ya verificado: el usuario demo es `Admin` |
| Selección múltiple crea N filas — un fallo parcial (2 de 3 inserts OK) deja estado inconsistente | `Promise.all` + si falla alguno, mensaje de error claro; no hay transacción multi-fila vía REST, es una limitación conocida a documentar, no a resolver acá |
| Historial (#13) espera una forma distinta de `useCriticalIncidents` | Hook simple y genérico (por `nnya_id`, orden por fecha) — bajo riesgo de tener que rehacerlo |
