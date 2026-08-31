# Documento de Alcance — Argüello Infancias Mobile

## 1. Nombre del proyecto

**Arguello Infancias — Aplicación móvil para el acompañamiento diario de NNA en residencias.**

## 2. Contexto

Argüello Infancias Mobile se plantea como una aplicación móvil complementaria al sistema de gestión de residencias. Su objetivo es facilitar al personal que realiza el acompañamiento diario el acceso y registro de información durante la jornada.

La propuesta se enfoca en el proceso de **Acompañamiento Diario de los NNA**, que contempla el inicio de la jornada, revisión de novedades, rutinas y actividades, registro de observaciones y traspaso de información al turno siguiente.

## 3. Problemática

El acompañamiento diario requiere registrar y consultar información relevante sobre los NNA. El uso de registros manuales o información distribuida puede dificultar la disponibilidad, organización y trazabilidad de los datos.

La aplicación busca centralizar las operaciones necesarias para que el educador pueda registrar y consultar información desde un dispositivo móvil.

## 4. Objetivo general

Desarrollar una aplicación móvil que permita a los educadores consultar información de los residentes y registrar acontecimientos y actividades vinculadas con el acompañamiento diario.

## 5. Usuario principal

**Educador / operador convivencial:** usuario que realiza el acompañamiento cotidiano de los NNA y necesita consultar y registrar información durante su turno.

## 6. Alcance funcional

La versión inicial contempla seis Features:

1. **Consultar información de los residentes.**
2. **Registrar novedades del turno.**
3. **Consultar historial de seguimiento.**
4. **Registrar actividades diarias.**
5. **Consultar novedades y tareas del turno.**
6. **Reportar una situación crítica.**

### Feature 1 — Consultar información de los residentes

Permite seleccionar un residente y consultar la información necesaria para el acompañamiento cotidiano.

### Feature 2 — Registrar novedades del turno

Permite registrar una novedad asociada a un residente, indicando como mínimo el tipo, descripción, fecha/hora y usuario responsable.

### Feature 3 — Consultar historial de seguimiento

Permite consultar cronológicamente las novedades y registros anteriores asociados a un residente.

### Feature 4 — Registrar actividades diarias

Permite registrar las actividades realizadas por el residente durante la jornada.

### Feature 5 — Consultar novedades y tareas del turno

Permite consultar la información relevante para comenzar y continuar un turno, incluyendo novedades y actividades pendientes o programadas.

### Feature 6 — Reportar una situación crítica

Permite registrar una situación que requiera atención especial, asociándola a un residente y dejando constancia de la situación informada.

## 7. Fuera de alcance

Para esta primera versión quedan fuera:

- Gestión administrativa completa de la residencia.
- Gestión completa de legajos y expedientes.
- Gestión presupuestaria y rendición de fondos.
- Generación de informes institucionales complejos.
- Automatización real de comunicaciones con organismos externos.
- Integraciones externas que no sean necesarias para demostrar las Features.
- Reemplazo total del sistema web existente.

## 8. Alcance técnico

La aplicación se plantea como un cliente móvil conectado a los servicios y datos del sistema.

Tecnologías previstas:

- React Native / Expo para la aplicación móvil.
- Supabase para autenticación, servicios y acceso a datos.
- PostgreSQL como base de datos.
- Git/GitHub para control de versiones.

## 9. Criterio de terminado

Una Feature se considerará terminada cuando:

- El flujo pueda ejecutarse desde la aplicación.
- Los datos requeridos estén correctamente validados.
- La información pueda persistirse cuando corresponda.
- La información pueda recuperarse cuando corresponda.
- Se hayan realizado pruebas funcionales.
- El flujo sea coherente con el objetivo de la aplicación.

## 10. Desarrollo incremental

El proyecto se desarrollará progresivamente. La prioridad será construir primero la navegación y consulta de residentes, luego incorporar el registro de novedades y actividades, y finalmente completar historial, tareas del turno y situaciones críticas.

## 11. Resultado esperado

Al finalizar esta etapa se espera contar con un MVP mobile que permita demostrar el proceso principal de acompañamiento diario y su integración con una base de datos persistente.

