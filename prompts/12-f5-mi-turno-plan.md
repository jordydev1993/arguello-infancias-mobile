# PLAN 12 — F5: Consultar turno y tareas de hoy (issue #14)

**Fecha:** 2026-09-15
**Estado:** ✅ Implementado y verificado 2026-09-15 (typecheck/lint limpios, expo-doctor 20/21 —
drift pre-existente — + prueba manual end-to-end contra la base real, con novedad y 2 actividades
en distinto estado para el mismo turno). Efecto dominó no anticipado en el plan original:
`src/app/(tabs)/inicio.tsx` también usaba el `useShiftInfo` viejo (tarjeta de "Turno de hoy" en
Inicio) — se actualizó al mismo patrón nuevo (conteo real de NNA + actividades de hoy).
**Repo:** `arguello-infancias-mobile`
**Tarjeta:** [#14](https://github.com/jordydev1993/arguello-infancias-mobile/issues/14) F5 Turno — navegación a detalle + diferenciar atendida/pendiente (En curso, Media)

---

## 1. Inspección

- `turno.tsx` (tab "Mi turno") ya tiene la estructura de WF-11 (tarjeta de horario, sección
  Novedades 24h, sección Tareas pendientes, turno anterior) pero **todo sale de un solo mock**
  (`shiftSummaryMock()` en `data/turno.ts`), sin tap-to-detail ni diferenciación de estado.
- **Hallazgo: la tabla real `turnos_personal` está vacía** (0 filas en toda la base) — no hay
  ninguna feature en alcance para crear turnos, ni datos cargados del lado web todavía. Conectarla
  hoy mostraría "sin turno" siempre, peor que el mock actual. **Se deja la tarjeta de horario como
  está** (mock, ya documentado como tal) — es un hallazgo para una tarjeta aparte si el equipo
  quiere resolverlo, no algo que bloquee esta.
- El mock de "Tareas pendientes" (`TAREAS_MOCK`/`Task`, tipo `medicacion`/`turno_medico`/
  `actividad_programada`) **no corresponde a ninguna tabla real** — nunca se conectó, y
  `TaskStatusBadge`/`TaskUpdateSchema` (pensados para esto) **no los usa ninguna pantalla**
  (confirmado por grep, código muerto desde que se armó el scaffold). Lo que WF-11 describe ahí
  (medicación, turnos médicos, actividades programadas) es exactamente lo que ya cubre la tabla
  real `actividades` (ya conectada en F4) — se unifica en una sola fuente real en vez de mantener
  un mock paralelo sin sentido.
- `assigned_minor_ids` (en `Shift`, calculado con `residentesAsignados()` sobre ids `r-1/r-2/r-3`
  que ya ni existen en la DB real) tampoco tiene sentido desde la decisión #2 (la guardia atiende
  a todos los NNA, no hay asignación) — se reemplaza por el conteo real de `useResidents()`.
- CA-40 (RBAC) ya está cubierto sin trabajo extra: no hay asignación por educador (decisión #2) y
  las tablas reales tienen RLS `Admin`/`Equipo Tecnico` — mismo caso que CA-24 en F3.
- `AlertCard` ya soporta `onPress` (se usó para reintentar errores) — sirve tal cual para el
  tap-to-detail de novedades (CA-37), sin componente nuevo.
- `ActivityStatusBadge` ya existe y ya diferencia pendiente/realizada/no_realizada visualmente —
  sirve tal cual para CA-38 en la sección de actividades.
- `labelOrRaw()` (agregado en el PLAN 11 para el mismo problema de `tipo` sin CHECK) está
  duplicado en dos archivos — como esta pantalla también necesita mostrar `tipo` de actividades de
  NNA que pueden traer valores libres, se aprovecha para sacarlo a un solo lugar compartido
  (`utils/constants.ts`) en vez de duplicarlo una tercera vez.

## 2. Alcance

**Dentro:** CA-33 a CA-40. "Novedades relevantes (24h)" y "Actividades de hoy" (renombre de
"Tareas pendientes", mismo concepto real) pasan a datos reales de **todos** los NNA, con tap a
detalle (reusa `historial-detalle.tsx` de F3, sin pantalla nueva) y diferenciación visual de
estado.

**Fuera:** conectar `turnos_personal` (no hay datos ni feature para poblarla — se documenta como
hallazgo). Marcar una actividad como "atendida" desde esta pantalla (no lo pide ningún CA de F5).
"Turno anterior" sigue con su texto mock (WF-11 lo marca opcional/expandible, ningún CA lo exige).

## 3. Archivos

| Archivo | Cambio |
|---|---|
| `src/utils/constants.ts` | Agregar `labelOrRaw(labels, value)` exportado (compartido, saca la duplicación de F3) |
| `src/app/residentes/[id].tsx`, `src/app/historial-detalle.tsx` | Usar el `labelOrRaw` importado en vez de la definición local |
| `src/hooks/useActivities.ts` | Exportar el mapeo `estado`→`status` (hoy privado) para reusarlo sin duplicar en el nuevo hook |
| `src/hooks/useShiftInfo.ts` | Reescribir: `useNovedadesRecientes(horas)` (real, todas las NNA, últimas 24h) + `useActividadesDeHoy()` (real, todas las NNA, `fecha = hoy`, mapea `status` friendly). Se mantiene una función local `turnoDeHoy()` para la tarjeta de horario (mock documentado) |
| `src/types/shift.ts` | Sacar `Task`/`pending_tasks`/`assigned_minor_ids` (obsoletos) |
| `src/data/turno.ts` | Sacar `TAREAS_MOCK`, `shiftSummaryMock`, `residentesAsignados`; queda solo `turnoDeHoy()` |
| `src/types/task.ts` | **Se borra** (sin uso real, confirmado por grep) |
| `src/lib/validation.ts` | Sacar `TaskUpdateSchema` (código muerto) |
| `src/utils/constants.ts` | Sacar `TASK_TYPES`/`TaskType`/`TASK_STATUSES`/`TaskStatus` |
| `src/components/ui/StatusBadge.tsx`, `src/components/index.ts` | Sacar `TaskStatusBadge` (sin uso real) |
| `src/app/(tabs)/turno.tsx` | Usa `useResidents()` (nombres + conteo real de NNA a cargo), `useNovedadesRecientes`, `useActividadesDeHoy`. Cada novedad/actividad es tocable → `router.push('/historial-detalle', { kind, id, minorId })`. Actividades muestran `ActivityStatusBadge`. Vacío combinado (CA-39) |

## 4. Chequeos

```bash
npm run typecheck
npm run lint
npx expo-doctor
```

Prueba manual (`npx expo start --web`, login `admin@arguelloinfancias.com`):
1. Tab "Mi turno" → ver tarjeta de horario (mock) + "NNA a cargo" con el conteo real.
2. Ver "Novedades relevantes (24h)" con datos reales de cualquier NNA (cargar una de prueba si no
   hay ninguna reciente) → tocarla → abre el detalle (CA-37) → Atrás vuelve a Mi turno.
3. Ver "Actividades de hoy" con al menos una pendiente y una realizada (cargar de prueba si hace
   falta) → confirmar que el badge las diferencia visualmente (CA-38) → tocar una → detalle.
4. Si no hay nada de ningún tipo, ver el mensaje "No hay novedades ni tareas pendientes" (CA-39).
5. Borrar los datos de prueba que se hayan generado.

## 5. Riesgos

| Riesgo | Mitigación |
|---|---|
| `turnos_personal` vacía deja la tarjeta de horario sin datos reales | Documentado como hallazgo separado, fuera de alcance de esta tarjeta — se mantiene el mock actual, no se rompe nada existente |
| Mismo problema de `tipo` sin label (visto en F3/F4) puede aparecer acá también | Se usa el `labelOrRaw` ya compartido |
