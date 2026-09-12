# Correcciones y dudas — Modelo de datos Mobile vs. base Web

**Para:** Meli y Sofi (base de datos + análisis funcional)
**Sobre:** `modelo-datos.docx` ("Arquitectura de Datos y Diseño Físico — Arguello Móvil")
**Fecha:** 2026-09-01

---

## 1. Resumen del problema

El modelo que armamos en `modelo-datos.docx` (y que quedó "aprobado" en `RESUMEN-SESION-MODELO-DATOS.md` / `RECOMENDACIONES-MODELO-DATOS.md` / `CORRECCIONES-MODELO-DATOS-ARGUELLO.md`) se validó **sin compararlo contra la base que ya está viva en Supabase para el proyecto web** (Argüello Infancias / ex-Cielo Abierto). Ese proyecto web ya tiene 27 tablas en producción, y varias de las que propusimos para mobile son la **misma entidad del mundo real con otro nombre**, no una tabla nueva.

Esto importa porque mobile y web son sobre la **misma residencia, mismos NNA, mismo personal**. Si mobile escribe en tablas propias (`residentes`, `situaciones_criticas`, `actividades_diarias`, etc.) en vez de reusar las de la web, un evento cargado desde el celular de un educador —por ejemplo una situación crítica— **no aparece** en el legajo judicial, el dashboard de alertas ni el sistema de predicción de gravedad del lado web. Quedan dos registros de la misma realidad, desincronizados.

Verifiqué el schema real corriendo `list_tables` / consultas directas contra el proyecto Supabase (no leyendo documentación vieja), así que las columnas de abajo son las que están hoy en producción.

**Punto a favor:** en `mobile/src/` todavía no hay nada conectado a Supabase (`src/lib/supabase.ts` está sin usar, todo corre con mock data en inglés que ni siquiera coincide con el docx). No hay migración que deshacer — estamos a tiempo de corregir el modelo antes de escribir una sola línea de integración real.

---

## 2. Correcciones — tabla por tabla

| Propuesto en el docx | Ya existe en la web | Corrección |
|---|---|---|
| `perfiles_usuarios` (id = auth.users, `rol` CHECK educador/coordinador) | `usuarios` + `roles` (rol normalizado vía `rol_id` FK, `auth_user_id` nullable — **no** `id = auth.users(id)` directo) | **No crear `perfiles_usuarios`.** Reusar `usuarios`/`roles`. Decisión #1 (§3): `Equipo Tecnico` ≈ educador, `Admin`/`Administrador` ≈ coordinador — no se agregan roles nuevos. |
| `residentes` (nombre, foto_url, fecha_nacimiento, escuela, turno_escolar, alertas_importantes) | `nnya` (18 columnas: dni, nacionalidad, domicilio, escolaridad, obra_social, numero_expediente, estado_actual, fecha_egreso...) | **No crear `residentes`.** Reusar `nnya`. Agregar como columnas nuevas (migración, no tabla nueva): `foto_url`, `alertas_importantes`, `turno_escolar`. |
| `turnos_trabajo` + `residentes_turnos` | `turnos_personal` (usuario_id, fecha, turno, hora_inicio/cierre, y **traspaso de guardia**: entregado_por/at, recibido_por/at) | **No crear `turnos_trabajo`.** `turnos_personal` ya cubre el concepto y es más completo (maneja el handover entre guardias, que el docx no contempla). `residentes_turnos` **no se crea** — decisión #2 (§3): la guardia atiende a todos los residentes, no hay asignación individual. |
| `novedades` | No hay equivalente exacto | **Es genuinamente nueva.** `intervenciones`/`informes` son registros formales de legajo; `novedades` es un diario liviano en tiempo real, un caso de uso distinto. Sí crearla, pero con la columna `nnya_id` (no `residente_id`) para no romper la convención de nombres del resto de la base. |
| `actividades_diarias` | `actividades` (soporta grupo vía `nnya_ids` array, `hora_inicio`/`hora_fin`, `lugar`, `estado` en vez de booleano) | **No crear `actividades_diarias`.** Reusar `actividades`, filtrando por un `nnya_id` al leer. La propuesta original es un downgrade de lo que ya existe. |
| `situaciones_criticas` | `incidentes` (gravedad, reportado_por, acciones_tomadas, y **`gravedad_sugerida`/`sugerencia_aceptada`** — el modelo de predicción con IA que ya está en producción vía `/api/incidentes/prediccion`) | **No crear `situaciones_criticas`. Este es el hallazgo más serio.** Si mobile tiene su propia tabla de emergencias, quedan invisibles para el sistema de predicción y para los legajos del lado web. Reusar `incidentes`. |
| `audit_log` (el docx la proponía como "falta agregar") | `audit_log` **ya existe**, con casi el mismo shape que se iba a crear (tabla, operacion, registro_id, usuario_id, datos_antes, datos_despues, created_at) | El script en `CORRECCIONES-MODELO-DATOS-ARGUELLO.md` iba a crear una tabla que ya existe con ese nombre — hubiera chocado o generado una segunda fuente de auditoría paralela. No ejecutar esa parte del script. |

**Conclusión de esta sección:** de las 7 tablas del docx, solo `novedades` (y posiblemente `residentes_turnos`, ver duda #2) son tablas nuevas de verdad. El resto son duplicados de algo que ya existe.

---

## 3. Dudas — resueltas (2026-09-12)

Decisión de Jordy. Quedan cerradas; el resto de este documento y `RECOMENDACIONES-MODELO-DATOS.md`/`RESUMEN-SESION-MODELO-DATOS.md`/`CORRECCIONES-MODELO-DATOS-ARGUELLO.md` deben reescribirse con estas 4 respuestas como base (issues #5–#8 del tablero).

1. **Roles para mobile → se mapean a los roles que ya existen.** `Equipo Tecnico` ≈ educador, `Admin`/`Administrador` ≈ coordinador. **No se agregan roles nuevos.**
   Evidencia que respalda esto: la web **ya hizo este mismo mapeo**. La migración `supabase/migrations/20260522000027_remove_educador_role.sql` eliminó el rol "Educador" y reasignó a esos usuarios a "Equipo Tecnico", con el comentario *"Los casos de uso del sistema definen Actor: todos"*. Mobile sigue el mismo criterio ya aplicado en producción.

2. **`residentes_turnos` → no hace falta.** El personal de guardia atiende a **todos** los residentes de la residencia durante su turno, no hay asignación específica por chico.
   Evidencia: `documentacion/procesos-del-negocio.md` y `procesosRelevados.md` describen la jornada con los educadores actuando sobre "los NNA" en plural ("despiertan a los NNA y acompañan en higiene personal"), sin ninguna asignación individual documentada. `turnos_personal` (ya construida en web) modela el traspaso de guardia entre personal — no una relación NNA↔educador. Se descarta esta tabla.

3. **Un solo Supabase → sí, el mismo que usa la web.** Mobile pega contra el mismo proyecto (`nnya`, `usuarios`, `incidentes`, etc.), no uno separado. Esto confirma la premisa central de la sección 2: reusar en vez de duplicar aplica tal cual.

4. **Arquitectura de acceso a datos → cliente directo a Supabase.** Sin API intermedia en Express. `mobile/src/lib/supabase.ts` (ya armado, sin usar todavía) es el camino correcto; RLS hace de guardia en la base, igual que en la web. La descripción de una capa Express en `AGENTS.md` § Arquitectura queda descartada — hay que corregir ese archivo (issue #8).

---

## 4. Qué documentos quedan desactualizados

Con las 4 decisiones de §3 ya tomadas, estos archivos de esta misma carpeta quedan pendientes de reescritura (issues #5–#7 del tablero):

- `RESUMEN-SESION-MODELO-DATOS.md`
- `RECOMENDACIONES-MODELO-DATOS.md`
- `CORRECCIONES-MODELO-DATOS-ARGUELLO.md`

Y `AGENTS.md` de mobile (sección "[5] MODELO DE DATOS" — 7 tablas viejas, y sección "[3] ARQUITECTURA" — describe una capa Express que la decisión #4 descarta) — issue #8.

Con esto resuelto, quedan destrabadas: la migración de columnas nuevas en `nnya` (issue #9), la creación de `novedades` (issue #10), y conectar mobile a Supabase (issue #16).
