# Resumen de Avance — Argüello Infancias Mobile

**Fecha:** 16 de septiembre de 2026
**Autor:** Jordy García
**Repositorio:** `arguello-infancias-mobile` (repo único de trabajo desde el 2026-09-15;
`arguello-infancias-mobile-app` quedó congelado)

---

## 1. Qué es el proyecto

Aplicación móvil para el acompañamiento diario de niños, niñas y adolescentes (NNA) en
residencias bajo protección judicial. Permite a educadores y coordinadores consultar
información de residentes, registrar novedades y actividades, ver el turno del día y
reportar situaciones críticas.

**Las 6 funcionalidades del MVP están completas y conectadas a datos reales:**

| # | Funcionalidad | Estado | PR |
|---|---|---|---|
| F1 | Consultar información de residentes asignados | ✅ Conectado a Supabase real | #30 |
| F2 | Registrar novedades (incidencias diarias) | ✅ Conectado a Supabase real | [#33](https://github.com/jordydev1993/arguello-infancias-mobile/pull/33) |
| F3 | Consultar historial de seguimiento | ✅ Conectado a Supabase real (timeline unificado) | [#35](https://github.com/jordydev1993/arguello-infancias-mobile/pull/35) |
| F4 | Registrar actividades diarias | ✅ Conectado a Supabase real | [#34](https://github.com/jordydev1993/arguello-infancias-mobile/pull/34) |
| F5 | Consultar turno y tareas de hoy | ✅ Conectado a Supabase real (horario sigue mock, ver §6) | [#36](https://github.com/jordydev1993/arguello-infancias-mobile/pull/36) |
| F6 | Reportar situación crítica (emergencias) | ✅ Conectado a Supabase real | [#32](https://github.com/jordydev1993/arguello-infancias-mobile/pull/32) |

Cada feature siguió el flujo de `AGENTS.md` (PLAN aprobado → implementación → typecheck/lint →
prueba manual en navegador → PR) y su plan vive en `prompts/08` a `prompts/12`.

---

## 2. Arquitectura y stack técnico

```
App móvil (Expo SDK 57 + React Native 0.86 + TypeScript estricto)
        │  @supabase/supabase-js (sin API intermedia)
        ▼
Supabase PostgreSQL — RLS por rol, auth real, sesión en SecureStore
```

- **Decisión clave (#4, PR #29):** se descartó la API Express intermedia de la arquitectura
  original — el cliente llama directo a Supabase y las políticas RLS hacen el control de
  acceso por rol. Mismo patrón que usa la web (`cielo-abierto`).
- **Frontend:** Expo Router (typed routes), NativeWind v4 + Tailwind, Zustand (estado
  global mínimo, sin middleware por el bug de `import.meta.env` en Metro web), React Query
  (una query/mutación por entidad), Zod (validación de formularios).
- **Seguridad:** JWT en `expo-secure-store`, RLS en la base como fuente real de
  autorización, validación de servidor vía `CHECK`/`NOT NULL` en las tablas.
- Justificación completa de cada decisión: `JUSTIFICACION-DECISIONES-Y-PLAN-MEJORA.md`.

---

## 3. Modelo de datos

El modelo real en producción difiere del diseño original de 7 tablas documentado en
`AGENTS.md` §[5] (ese documento quedó desactualizado — ver §6, tarjetas de Sofi). En la
práctica cada feature se validó contra el **schema real de Supabase**, no contra el
wireframe, y en los 5 casos (F2 a F6) se encontró y resolvió al menos una diferencia real:

- `novedades.tipo`: valores reales distintos a los del wireframe original (corregido en
  `OBSERVATION_CATEGORIES`).
- `actividades.tipo` / `incidentes.tipo`: sin `CHECK` en la base — conviven valores fijos de
  mobile con valores libres cargados desde la web. Mitigado con `labelOrRaw()`
  (`src/utils/constants.ts`).
- `actividades`: dos FKs a `usuarios` (`responsable_id`, `created_by`) — requirió
  desambiguar el embed de PostgREST (`usuarios!created_by(...)`).
- `turnos_personal`: tabla vacía en producción — sin feature que la pueble todavía, F5
  mantiene el horario como mock documentado.

---

## 4. Trabajo realizado hasta ahora

1. **Scaffold + sistema de diseño** (Expo SDK 57, NativeWind v4, Zustand, React Query, Zod):
   estructura de carpetas, navegación, componentes base, `design-tokens.json` como fuente
   única de colores/tipografía/espaciado.
2. **F1 (residentes)** y **autenticación real** conectados a Supabase.
3. **F6 — Situación crítica** (#15, PR #32): formulario de 3 pasos, tabla `incidentes`,
   auditoría automática.
4. **F2 — Registrar novedad** (#11, PR #33): formulario conectado a `novedades`.
5. **F4 — Registrar actividad** (#12, PR #34): formulario conectado a `actividades`,
   corrigió el bug de embed ambiguo de PostgREST.
6. **F3 — Historial unificado** (#13, PR #35): timeline que combina novedad + actividad +
   crítica por día, con diferenciación visual para lo crítico.
7. **F5 — Mi turno** (#14, PR #36): novedades recientes y actividades de hoy reales,
   horario todavía mock (`turnos_personal` vacía).
8. **Limpieza de código muerto:** eliminados `src/data/actividades.ts`, `src/types/task.ts`,
   `src/data/residentes.ts`, `TaskUpdateSchema`, `TaskStatusBadge` — ya sin uso tras conectar
   todo a datos reales.
9. **Revisión de tarjetas de documentación** (#17, #18): cerradas — #17 era redundante
   (ya resuelta por F1–F6), #18 citaba un documento obsoleto; el hallazgo real vigente se
   movió a [cielo-abierto#16](https://github.com/jordydev1993/cielo-abierto/issues/16).

---

## 5. Verificaciones corridas

Cada feature pasó, antes de mergear:

| Chequeo | Resultado |
|---|---|
| `npm run typecheck` | ✅ Sin errores en cada PR |
| `npm run lint` | ✅ Sin warnings en cada PR |
| `npx expo-doctor` | ✅ |
| Prueba manual en navegador (Chrome, sesión real) | ✅ Flujo completo por feature, incluyendo guardar y verificar el dato reflejado |
| Verificación en Supabase (`SELECT` + `audit_log`) | ✅ Cada inserción confirmada en la tabla real y, donde aplica, en `audit_log` |

---

## 6. Pendientes (ninguno es de Jordy)

Detalle completo con entregables esperados en `TAREAS-MOBILE.md`. Resumen:

| # | Persona | Qué falta |
|---|---|---|
| [#19](https://github.com/jordydev1993/arguello-infancias-mobile/issues/19) | Meli | Tests automatizados de los 51 criterios de aceptación (CA-01…CA-51) |
| [#20](https://github.com/jordydev1993/arguello-infancias-mobile/issues/20) | Cami | Revisión UI/UX de F2–F6 contra `skills/design.md` y wireframes |
| [#21](https://github.com/jordydev1993/arguello-infancias-mobile/issues/21) | Cami | Solo falta cerrarla — `SelectField`/`TextAreaField` ya están integrados en F2/F4 |
| [#5–#8](https://github.com/jordydev1993/arguello-infancias-mobile/issues/5) | Sofi | Reescribir la documentación del modelo de datos y `AGENTS.md` §[5] para reflejar el schema real — bloqueado hasta mergear el [PR #29](https://github.com/jordydev1993/arguello-infancias-mobile/pull/29) |

**Mediano plazo (sin tarjeta abierta todavía):** conectar `turnos_personal` real,
resiliencia mínima sin conexión, paginación en listas largas, auditoría de accesibilidad
real — detalle en `JUSTIFICACION-DECISIONES-Y-PLAN-MEJORA.md` §4.

---

**Nota:** este resumen refleja el estado del repositorio al 16 de septiembre de 2026.
Reemplaza la versión anterior del 3 de septiembre (pre-conexión a Supabase). Para el detalle
de cada decisión técnica ver `JUSTIFICACION-DECISIONES-Y-PLAN-MEJORA.md`; para pendientes
con entregables, `TAREAS-MOBILE.md`.
