# PLAN 09 — F2: Registrar novedad (issue #11)

**Fecha:** 2026-09-15
**Estado:** ✅ Implementado y verificado 2026-09-15 (typecheck/lint limpios, expo-doctor 20/21 —
el único fallo es drift de 15 paquetes, pre-existente, no de este cambio — + prueba manual en
navegador contra la base real: creación, validación, confirmación, aparece en Novedades e
Historial, verificado por SQL y limpiado después)
**Repo:** `arguello-infancias-mobile`
**Tarjeta:** [#11](https://github.com/jordydev1993/arguello-infancias-mobile/issues/11) F2 Registrar novedades — pantalla formulario + mutación create (Sin empezar, Alta)

---

## 1. Inspección

- `src/app/residentes/[id].tsx` ya tiene una pestaña **"Novedades"** que renderiza
  `useObservations(minorId)` (hoy mock) con una nota "Registro pendiente (F2)". Ahí es donde entra
  el botón "Nueva novedad" — no hace falta una pantalla nueva de navegación, ya está el punto de
  entrada natural (WF-05 dice "NNA mostrado, no editable": se abre desde el detalle del residente).
- `OBSERVATION_CATEGORIES` (constants.ts) hoy son `conducta/emocional/educativo/sanitario/otro`
  (iguales al wireframe WF-05) — **pero la tabla real `novedades.tipo` tiene un CHECK distinto**:
  `Salud, Educación, Comportamiento, Alimentación, Visita Familiar, Otro` (verificado contra la DB,
  no la doc). A diferencia de `incidentes.tipo` (sin CHECK, tenía margen), acá **no hay opción**:
  insertar cualquier otro valor rompe el `INSERT`. Followed además: esta lista coincide con la del
  `AGENTS.md` original (§6, contrato `tipo_novedad`) — es la única parte de ese doc que ya estaba
  bien.
- `Observation`/`NewObservation` (types) y `ObservationSchema` (validation.ts) son del período
  mock: `minor_id/category/content/observation_date` en vez de las columnas reales
  `nnya_id/tipo/descripcion/fecha_hora`.
- **Efecto dominó (solo renombres, no funcionalidad nueva):** el tipo `Observation` también lo usan
  `src/app/(tabs)/turno.tsx` (F5, #14, sigue mock) y `src/types/history.ts` (F3, #13, sigue sin
  implementar). Cambiar los nombres de campo de `Observation` rompe el `tsc` de esos dos archivos
  si no se les sigue la corriente — son cambios mecánicos de 2-3 líneas cada uno (renombrar
  `o.category`→`o.tipo`, `o.observation_date`→`o.fecha_hora`), **sin tocar su lógica ni su alcance**
  (siguen mock, siguen pendientes como features). Igual en `src/data/turno.ts` (filtro de
  `recent_observations`) y `src/data/novedades.ts` (el mock `NOVEDADES_MOCK`, que `turno.ts` sigue
  usando para el resumen de F5).
- RLS de `novedades`: mismo patrón que `incidentes` — solo `Admin`/`Equipo Tecnico` (el usuario demo
  cumple, ya verificado en el PLAN 08).

## 2. Alcance

**Dentro:** CA-08 a CA-17 completos (formulario, selector de tipo con las 6 categorías reales,
descripción, fecha/hora y usuario automáticos, validación, cancelar, confirmación, guardado real +
"Novedad registrada" + aparece en la pestaña Novedades). `useObservations` pasa de mock a real
(la propia pestaña "Novedades" ya la consume, así que CA-17 ["aparece en el historial"] queda
satisfecho ahí mismo).

**Fuera:** la pestaña **"Historial"** unificada (F3, #13) y "Mi turno" (F5, #14) — solo se les
arregla el nombre de campo para que compilen, no se les cambia nada más.

## 3. Archivos

| Archivo | Cambio |
|---|---|
| `src/utils/constants.ts` | `OBSERVATION_CATEGORIES` → `['Salud','Educación','Comportamiento','Alimentación','Visita Familiar','Otro']` + labels (identidad, son ya legibles) |
| `src/types/observation.ts` | `Observation` real: `id, nnya_id, usuario_id, usuario_nombre, tipo, descripcion, fecha_hora, created_at`. `NewObservation: { nnya_id, tipo, descripcion }` |
| `src/lib/validation.ts` | `ObservationSchema`: `nnya_id` (fijo, no lo edita el usuario pero se valida igual), `tipo` (enum), `descripcion` (10-500, sin cambios de límites) |
| `src/hooks/useObservations.ts` | Query real (`novedades` + join `usuarios(nombre,apellido)`, mismo patrón que `useResidents`) + `useCreateObservation()` mutation, invalida `['observations', nnyaId]` al crear |
| `src/data/novedades.ts` | Renombrar campos de `NOVEDADES_MOCK` (sigue usándose desde `data/turno.ts` para F5 mock); borrar `novedadesDeResidente` (queda sin uso) |
| `src/data/turno.ts` | Renombrar 2 referencias de campo en el filtro de `recent_observations` (`minor_id`→`nnya_id`, `observation_date`→`fecha_hora`) |
| `src/app/(tabs)/turno.tsx` | Renombrar `o.category`→`o.tipo`, `o.content`→`o.descripcion` (misma UI, sin cambios) |
| `src/app/nueva-novedad.tsx` (nuevo) | Formulario (NNA fijo mostrado, `SelectField` tipo, `TextAreaField` descripción) → confirmación (resumen) → éxito, igual patrón que `situacion-critica.tsx`. Param `minorId` por query. Botón "Cancelar" (CA-15) vuelve sin guardar. |
| `src/app/residentes/[id].tsx` | `NovedadesTab`: sacar `PendingFeatureNote`, agregar botón "+ Nueva novedad" (`router.push({ pathname: '/nueva-novedad', params: { minorId } })`), actualizar campos mostrados (`o.tipo`, `o.descripcion`, `o.fecha_hora`, `o.usuario_nombre`) |
| `src/app/_layout.tsx` | `<Stack.Screen name="nueva-novedad" />` |

## 4. Chequeos

```bash
npm run typecheck
npm run lint
npx expo-doctor
```

Prueba manual (`npx expo start --web`, login `admin@arguelloinfancias.com`):
1. Residentes → abrir un NNA → tab Novedades → "+ Nueva novedad".
2. Elegir tipo, escribir descripción <10 chars → error. Cancelar → vuelve sin guardar (CA-15).
3. Completar bien → Continuar → resumen → Confirmar → "Novedad registrada".
4. Volver a la pestaña Novedades del mismo NNA: la nueva novedad aparece arriba.
5. Verificar en Supabase (`select * from novedades order by created_at desc`) y borrar la fila de
   prueba después, igual que en el PLAN 08.

## 5. Riesgos

| Riesgo | Mitigación |
|---|---|
| Insertar un `tipo` que no está en las 6 opciones reales rompe el `INSERT` (CHECK) | `SelectField` solo ofrece las 6 opciones reales, no hay texto libre |
| Romper el `tsc` de F3/F5 al renombrar `Observation` | Se corrigen sus 2-3 referencias mecánicamente en este mismo PLAN (sin tocarles funcionalidad) |
