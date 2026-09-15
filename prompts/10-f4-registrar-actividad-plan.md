# PLAN 10 — F4: Registrar actividad (issue #12)

**Fecha:** 2026-09-15
**Estado:** ✅ Implementado y verificado 2026-09-15 (typecheck/lint limpios, expo-doctor 20/21 —
drift de paquetes pre-existente, no de este cambio — + prueba manual end-to-end contra la base
real). Bug real encontrado y corregido durante la prueba: **`actividades` tiene dos FK a
`usuarios` (`responsable_id` y `created_by`)** — el embed `usuarios(nombre, apellido)` sin
desambiguar rompía tanto la lectura como la creación con
`Could not embed because more than one relationship was found for 'actividades' and 'usuarios'`.
Se corrigió a `usuarios!created_by(nombre, apellido)` en `useActivities.ts`. De paso esto reveló
que había actividades reales preexistentes en la DB para los NNA de prueba que antes no cargaban
por este mismo error.
**Repo:** `arguello-infancias-mobile`
**Tarjeta:** [#12](https://github.com/jordydev1993/arguello-infancias-mobile/issues/12) F4 Registrar actividades diarias — pantalla formulario + mutación (Sin empezar, Alta)

---

## 1. Inspección

- Punto de entrada: pestaña **"Actividades"** en `residentes/[id].tsx` (ya existe, hoy solo lee
  mock con nota "pendiente F4") — mismo patrón de entrada que usó F2.
- Tabla real `actividades` (verificado contra la DB):
  ```
  id · titulo (NOT NULL, sin default) · descripcion (nullable) · tipo (NOT NULL, sin CHECK)
  fecha (NOT NULL, sin default) · hora_inicio/hora_fin (nullable) · lugar (nullable)
  responsable_id (nullable, FK usuarios) · nnya_ids (uuid[] NOT NULL, default '{}')
  estado (NOT NULL default 'programada', CHECK: programada/en_curso/realizada/cancelada)
  observaciones (nullable) · created_by (nullable, FK usuarios) · created_at/updated_at
  ```
  RLS: mismo patrón que `novedades`/`incidentes` (`Admin`/`Equipo Tecnico`, el usuario demo cumple).
- `ACTIVITY_TYPES` (constants.ts) — **coincide exacto** con CA-26/WF-10 (escuela, recreativa,
  deportiva, comida, pedagógica, médico, otra) y la DB no tiene CHECK que lo restrinja. Sin
  cambios acá, a diferencia de F2/F6.
- **`ACTIVITY_STATUSES` (pendiente/realizada/no_realizada, CA-27/WF-10) no coincide con el CHECK
  real de `estado`** (programada/en_curso/realizada/cancelada) — mismo tipo de hallazgo que en F2,
  pero acá **no hace falta tocar la UI ni los labels existentes** (`ActivityCard`, `StatusBadge`
  ya usan `pendiente/realizada/no_realizada` en toda la app): alcanza con traducir en el límite del
  hook, sin tocar tipos que ya están bien:
  ```
  pendiente ←→ programada   realizada ←→ realizada   no_realizada ←→ cancelada
  ```
  (`en_curso` no tiene equivalente en el wireframe — si se lee una actividad real en ese estado,
  se muestra como "pendiente", la lectura más cercana).
- `titulo` y `fecha` son NOT NULL sin default, pero **WF-10 no pide esos campos** (solo pide
  Actividad/tipo, Estado, Observaciones opcional). Se completan automático: `fecha` = hoy,
  `titulo` = la etiqueta del tipo elegido (`ACTIVITY_TYPE_LABELS[tipo]`) — igual que F6 dejó
  `gravedad` en su default sin pedirlo en el form.
- `nnya_ids` es array, pero como WF-09/WF-10 registran la actividad **desde el detalle de un NNA
  puntual** (no hay selector de NNA en el wireframe, a diferencia de F6), se manda `[minorId]` —
  no hace falta multi-select acá.
- **CA-25 a CA-32 no piden pantalla de confirmación con resumen** (a diferencia de CA-16/CA-48 en
  F2/F6) — CA-32 solo pide "se muestra un mensaje de confirmación" al guardar, y WF-10 va directo
  Guardar → mensaje, sin paso de revisión. **Decisión (corrección de este PLAN):** el wireframe es
  referencia, no algo a calcar literal — se mantiene el mismo formato de proceso que F2/F6 (form →
  confirmación con resumen → guardado → éxito) para que las 3 features de alta de datos se sientan
  la misma app, no tres flujos distintos. Igual cumple CA-32 (el mensaje de éxito sigue estando) y
  de paso deja lugar para mostrar el resumen antes de escribir en la DB, más prolijo para datos que
  no se pueden editar después.
- `data/actividades.ts`/`actividadesDeResidente` solo los usa `useActivities.ts` (a diferencia de
  `novedades`, acá no hay dependencia de F5) — queda sin uso una vez que el hook sea real, se borra.

## 2. Alcance

**Dentro:** CA-25 a CA-32 completos.

**Fuera:** F3 (Historial) solo recibe el renombre mecánico de campos para seguir compilando.

## 3. Archivos

| Archivo | Cambio |
|---|---|
| `src/types/activity.ts` | `Activity`: `id, nnya_ids, tipo, status, observaciones, fecha, created_by, created_by_nombre, created_at, updated_at`. `NewActivity: { nnya_id, tipo, status, observaciones? }` |
| `src/lib/validation.ts` | `ActivitySchema`: `nnya_id`, `tipo` (enum sin cambios), `status` (enum sin cambios), `observaciones` (opcional, max 500). Se sacan `duration_minutes`/`participants` (no existen en la DB real ni en WF-10) |
| `src/hooks/useActivities.ts` | Query real (join `usuarios`) + `useCreateActivity()` mutation. Acá vive la traducción `status` (friendly) ↔ `estado` (DB real) — el resto de la app no se entera del mapeo |
| `src/data/actividades.ts` | **Se borra** (sin uso tras conectar el hook) |
| `src/components/ActivityCard.tsx` | Renombrar `activity.activity_type`→`activity.tipo`, `activity.observations`→`activity.observaciones` |
| `src/app/residentes/[id].tsx` | `ActividadesTab`: sacar `PendingFeatureNote`, agregar "+ Nueva actividad". `HistorialTab`: renombrar 2 referencias (`a.observations`→`a.observaciones`, `a.created_by_name`→`a.created_by_nombre`) |
| `src/app/nueva-actividad.tsx` (nuevo) | Formulario (tipo, estado, observaciones) → confirmación con resumen (NNA, tipo, estado, observaciones, fecha, usuario) → Guardar → mensaje de éxito, mismo patrón de 3 pasos que `nueva-novedad.tsx`/`situacion-critica.tsx`. Incluye Cancelar (CA-31) en el paso de formulario y "Volver a editar" en el de confirmación |
| `src/app/_layout.tsx` | `<Stack.Screen name="nueva-actividad" />` |

## 4. Chequeos

```bash
npm run typecheck
npm run lint
npx expo-doctor
```

Prueba manual (`npx expo start --web`, login `admin@arguelloinfancias.com`):
1. Residentes → abrir un NNA → tab Actividades → "+ Nueva actividad".
2. Guardar sin completar → error (CA-30). Cancelar → vuelve sin guardar (CA-31).
3. Completar tipo + estado (+ observaciones opcional) → Continuar → pantalla de resumen → Guardar
   → mensaje de confirmación (CA-32).
4. Volver a la pestaña Actividades: aparece la nueva actividad con el estado correcto.
5. Verificar en Supabase (`select * from actividades order by created_at desc`) que `estado` quedó
   con el valor real de la DB (no el friendly) y borrar la fila de prueba después.

## 5. Riesgos

| Riesgo | Mitigación |
|---|---|
| Mezclar el `status` friendly con el `estado` real en algún lugar fuera del hook | Toda la traducción vive en `useActivities.ts`; el resto de la app (incluido `ActivityCard`) sigue usando solo `pendiente/realizada/no_realizada` |
| Dejar `titulo`/`fecha` vacíos rompe el insert (NOT NULL) | Se completan automático (`fecha` = hoy, `titulo` = label del tipo) antes de mandar el insert |
