# PLAN 11 — F3: Consultar historial de seguimiento (issue #13)

**Fecha:** 2026-09-15
**Estado:** ✅ Implementado y verificado 2026-09-15 (typecheck/lint limpios, expo-doctor 20/21 —
drift pre-existente — + prueba manual end-to-end contra la base real, con las 3 fuentes a la vez
para un mismo NNA).

**Hallazgo adicional durante la prueba (no es bug de este PLAN, pero lo tocaba en vivo):**
`actividades.tipo` tampoco tiene CHECK — hay actividades reales con valores libres
(`educativa`, `terapeutica`) que no están en `ACTIVITY_TYPES`, mismo patrón que ya se había visto
en `incidentes.tipo` (PLAN 08). Sin fallback, esas entradas se mostraban con la etiqueta vacía.
Se agregó `labelOrRaw()` en `HistorialTab`/`historial-detalle.tsx` (este PLAN) y, para no dejar la
misma falla visible en otras pantallas que ya rendereizaban esos mismos datos,
también en `ActivityCard.tsx` y `NovedadesTab` (2 líneas cada uno).
**Repo:** `arguello-infancias-mobile`
**Tarjeta:** [#13](https://github.com/jordydev1993/arguello-infancias-mobile/issues/13) F3 Historial — detalle por registro + separadores de día (En curso, Media)

---

## 1. Inspección

- `HistorialTab` (en `residentes/[id].tsx`) ya existe y ya lee datos **reales** (hereda
  `useObservations`/`useActivities` de F2/F4), pero es un merge ad-hoc de solo 2 fuentes, sin
  agrupar por día, sin tap-to-detail, y con el aviso "pendiente F3" todavía puesto.
- Ya existen, sin usar, exactamente las piezas que hacen falta:
  - `src/types/history.ts` → `HistoryEntry` (unión novedad/actividad/critica) — el merge actual no
    lo usa, arma su propio objeto suelto.
  - `src/utils/formatters.ts` → `agruparPorDia`, `formatDiaSeparador`, `claveDia` — escritas para
    CA-21 (separadores de día) y sin conectar todavía a ninguna pantalla.
  - `useCriticalIncidents(nnyaId)` (`src/hooks/useCriticalIncidents.ts`, del PLAN 08) — lectura de
    `incidentes` lista y sin usar, pensada exactamente para este momento.
- **Falta el nombre del usuario en `CriticalIncident`** — a diferencia de `Observation`/`Activity`
  (ya tienen `usuario_nombre`/`created_by_nombre`), `useCriticalIncidents` no hace join con
  `usuarios`. Para cumplir CA-20 ("cada registro incluye... usuario responsable") en los registros
  de tipo crítica, hay que agregarlo — mismo patrón que en F2/F4 (`incidentes` solo tiene **una**
  FK a `usuarios`, a diferencia de `actividades`, no hace falta desambiguar `usuarios!fk`).
- WF-08 (detalle) pide una pantalla aparte por registro (tipo, NNA, descripción completa, usuario,
  fecha/hora exacta), con navegación "Atrás". No hace falta una query nueva: el registro tocado ya
  está en la lista que devolvió `useObservations`/`useActivities`/`useCriticalIncidents` — la
  pantalla de detalle busca por `id` dentro de esos mismos hooks (que ya están en caché de React
  Query), sin pegarle de nuevo a Supabase.
- CA-24 (RBAC) ya está cubierto por lo que existe: las 3 tablas tienen RLS `Admin`/`Equipo Tecnico`
  y las consultas ya filtran por `nnya_id` del residente que se está viendo — no hace falta nada
  nuevo acá.

## 2. Alcance

**Dentro:** CA-18 a CA-24 completos — timeline unificado (novedad + actividad + crítica),
separadores de día, tap → detalle completo, vacío, RBAC (ya cubierto).

**Fuera:** no se tocan las pantallas de F2/F4/F6 en sí (solo se lee de sus hooks). No se agrega
edición desde el detalle (WF-08 lo marca "solo visualizar por ahora").

## 3. Archivos

| Archivo | Cambio |
|---|---|
| `src/types/critical.ts` | Agregar `reportado_por_nombre: string \| null` a `CriticalIncident` |
| `src/hooks/useCriticalIncidents.ts` | `useCriticalIncidents`: join `usuarios(nombre, apellido)` (una sola FK, sin ambigüedad) + mapper a `reportado_por_nombre`, mismo patrón que `useObservations`/`useActivities` |
| `src/app/residentes/[id].tsx` | `HistorialTab`: reescribir con `HistoryEntry[]` real, sumar `useCriticalIncidents`, ordenar todo junto, `agruparPorDia` + header `formatDiaSeparador` por grupo, cada entrada es `Pressable` → `router.push('/historial-detalle', { kind, id, minorId })`. Icono/acento por `kind` (crítica en rojo, diferenciada — CA-50/51). Sacar `PendingFeatureNote` de acá; como ya no la usa nadie más (F2/F4 ya la sacaron), se borra la función entera |
| `src/app/historial-detalle.tsx` (nuevo) | Header con fecha/hora (WF-08), busca el registro por `kind`+`id` dentro de `useObservations`/`useActivities`/`useCriticalIncidents(minorId)` (ya cacheados, sin query nueva) y muestra tipo, NNA, descripción completa, usuario, fecha/hora. Solo lectura |
| `src/app/_layout.tsx` | `<Stack.Screen name="historial-detalle" />` |

## 4. Chequeos

```bash
npm run typecheck
npm run lint
npx expo-doctor
```

Prueba manual (`npx expo start --web`, login `admin@arguelloinfancias.com`):
1. Abrir un NNA con novedades/actividades ya cargadas (de las pruebas de F2/F4 no borradas, o
   cargar una nueva de cada tipo) → tab Historial.
2. Ver entradas ordenadas de más reciente a más antigua (CA-19), agrupadas con separador de día
   (CA-21), cada una con fecha/hora + tipo + usuario (CA-20).
3. Reportar una situación crítica de prueba para el mismo NNA (F6) y confirmar que aparece en el
   historial diferenciada visualmente (CA-50, hoy pendiente).
4. Tocar un registro → se abre el detalle completo (CA-22) → Atrás vuelve al historial.
5. Abrir un NNA sin registros → "No hay registros para mostrar" (CA-23).
6. Borrar los datos de prueba que se hayan generado en el paso 3.

## 5. Riesgos

| Riesgo | Mitigación |
|---|---|
| Mismo bug de FK ambigua que en F4 si `incidentes` tuviera más de una FK a `usuarios` | Ya verificado: `incidentes` solo tiene `reportado_por` como FK a `usuarios`, no hace falta desambiguar |
| Timeline pesado si un NNA tiene muchos registros | Fuera de alcance para este PLAN (no hay paginación en F1 tampoco); se anota como mejora futura si hace falta |
