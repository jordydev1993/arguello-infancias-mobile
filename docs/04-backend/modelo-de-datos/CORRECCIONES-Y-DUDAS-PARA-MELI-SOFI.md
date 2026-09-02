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
| `perfiles_usuarios` (id = auth.users, `rol` CHECK educador/coordinador) | `usuarios` + `roles` (rol normalizado vía `rol_id` FK, `auth_user_id` nullable — **no** `id = auth.users(id)` directo) | **No crear `perfiles_usuarios`.** Reusar `usuarios`/`roles`. Los roles reales hoy son: `Admin`, `Administrador`, `Equipo Tecnico`, `Trabajador Social`, `Psicólogo/a`, `Médico/a`, `Abogado/a`. Ninguno es "educador" ni "coordinador" — ver duda #1. |
| `residentes` (nombre, foto_url, fecha_nacimiento, escuela, turno_escolar, alertas_importantes) | `nnya` (18 columnas: dni, nacionalidad, domicilio, escolaridad, obra_social, numero_expediente, estado_actual, fecha_egreso...) | **No crear `residentes`.** Reusar `nnya`. Agregar como columnas nuevas (migración, no tabla nueva): `foto_url`, `alertas_importantes`, `turno_escolar`. |
| `turnos_trabajo` + `residentes_turnos` | `turnos_personal` (usuario_id, fecha, turno, hora_inicio/cierre, y **traspaso de guardia**: entregado_por/at, recibido_por/at) | **No crear `turnos_trabajo`.** `turnos_personal` ya cubre el concepto y es más completo (maneja el handover entre guardias, que el docx no contempla). `residentes_turnos` (qué NNA está bajo qué guardia) no tiene equivalente — ver duda #2 antes de crearla. |
| `novedades` | No hay equivalente exacto | **Es genuinamente nueva.** `intervenciones`/`informes` son registros formales de legajo; `novedades` es un diario liviano en tiempo real, un caso de uso distinto. Sí crearla, pero con la columna `nnya_id` (no `residente_id`) para no romper la convención de nombres del resto de la base. |
| `actividades_diarias` | `actividades` (soporta grupo vía `nnya_ids` array, `hora_inicio`/`hora_fin`, `lugar`, `estado` en vez de booleano) | **No crear `actividades_diarias`.** Reusar `actividades`, filtrando por un `nnya_id` al leer. La propuesta original es un downgrade de lo que ya existe. |
| `situaciones_criticas` | `incidentes` (gravedad, reportado_por, acciones_tomadas, y **`gravedad_sugerida`/`sugerencia_aceptada`** — el modelo de predicción con IA que ya está en producción vía `/api/incidentes/prediccion`) | **No crear `situaciones_criticas`. Este es el hallazgo más serio.** Si mobile tiene su propia tabla de emergencias, quedan invisibles para el sistema de predicción y para los legajos del lado web. Reusar `incidentes`. |
| `audit_log` (el docx la proponía como "falta agregar") | `audit_log` **ya existe**, con casi el mismo shape que se iba a crear (tabla, operacion, registro_id, usuario_id, datos_antes, datos_despues, created_at) | El script en `CORRECCIONES-MODELO-DATOS-ARGUELLO.md` iba a crear una tabla que ya existe con ese nombre — hubiera chocado o generado una segunda fuente de auditoría paralela. No ejecutar esa parte del script. |

**Conclusión de esta sección:** de las 7 tablas del docx, solo `novedades` (y posiblemente `residentes_turnos`, ver duda #2) son tablas nuevas de verdad. El resto son duplicados de algo que ya existe.

---

## 3. Dudas que necesitamos que resuelvan ustedes

Estas son decisiones de negocio / análisis funcional, no las resolvimos del lado técnico:

1. **Roles para mobile.** ¿"Educador" y "Coordinador" se agregan como roles nuevos en la tabla `roles` existente, o se mapean a roles que ya están (`Equipo Tecnico` ≈ educador, `Admin`/`Administrador` ≈ coordinador)? Afecta directo a las políticas RLS que hay que escribir.

2. **`residentes_turnos` (¿hace falta?).** El docx asume que hay que saber explícitamente qué NNA está asignado a qué turno de guardia. Pero ¿en la operación real de la residencia, el personal de guardia ve/atiende a **todos** los residentes de la residencia, o hay asignación específica por chico? Si es lo primero, esa tabla sobra para el MVP.

3. **Un solo Supabase o dos.** ¿Mobile va a pegarle al **mismo proyecto Supabase** que usa la web (mismo `nnya`, `usuarios`, `incidentes`, etc.), o a un proyecto separado? Todo este documento asume que es el mismo proyecto — si no lo es, la razón entera de "reusar en vez de duplicar" no aplica y habría que decirlo explícitamente.

4. **Arquitectura de acceso a datos.** El `AGENTS.md` de mobile describe una API intermedia en Express.js entre la app y Supabase. `mobile/src/lib/supabase.ts` está armado para pegarle directo a Supabase desde el cliente (patrón típico de apps Supabase, con RLS haciendo de guardia). Son dos arquitecturas distintas — ¿cuál va?

---

## 4. Qué documentos quedan desactualizados

Si confirman el enfoque de reusar la base web, estos tres archivos de esta misma carpeta van a necesitar reescritura (no los tocamos todavía, quedan a la espera de que resuelvan las dudas de arriba):

- `RESUMEN-SESION-MODELO-DATOS.md`
- `RECOMENDACIONES-MODELO-DATOS.md`
- `CORRECCIONES-MODELO-DATOS-ARGUELLO.md`

Y el `AGENTS.md` de mobile (sección "[5] MODELO DE DATOS") también da por sentadas las 7 tablas originales.
