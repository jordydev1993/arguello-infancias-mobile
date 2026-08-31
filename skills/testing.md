# Criterios de Aceptación — Argüello Infancias Mobile

## Objetivo

Definir los criterios específicos y verificables para cada Feature. Un criterio se considera **cumplido** si puede verificarse mediante una prueba funcional.

Cada criterio se identifica como **CA-XX** (Criterio de Aceptación - número).

---

# F1 — Consultar información de los residentes

## CA-01
**DADO** un usuario autenticado con rol Educador  
**CUANDO** accede a la sección Residentes  
**ENTONCES** el sistema muestra el listado de NNA que tiene autorización para consultar

**Verificación:** El listado no está vacío (si hay residentes asignados)

---

## CA-02
**DADO** un listado de residentes  
**CUANDO** cada residente se muestra en la lista  
**ENTONCES** cada uno incluye como mínimo: nombre, edad, foto (si aplica), estado

**Verificación:** Todos los campos están presentes y legibles

---

## CA-03
**DADO** un listado de residentes  
**CUANDO** el usuario toca/selecciona un residente  
**ENTONCES** el sistema navega al detalle de ese residente

**Verificación:** Se abre la pantalla de detalle con información del residente

---

## CA-04
**DADO** la pantalla de detalle de un residente  
**CUANDO** se carga la información  
**ENTONCES** se muestra toda la información autorizada: datos personales, contacto emergencia, obra social, etc.

**Verificación:** Todos los campos permitidos son visibles

---

## CA-05
**DADO** el detalle de un residente  
**CUANDO** el usuario tiene permisos para consultar actividades/novedades  
**ENTONCES** existen secciones claramente diferenciadas para acceder a: novedades, historial, actividades

**Verificación:** Las secciones son accesibles desde el detalle

---

## CA-06
**DADO** la sección de residentes  
**CUANDO** no existen residentes disponibles para consultar  
**ENTONCES** el sistema muestra un mensaje indicando "No hay residentes para mostrar"

**Verificación:** Mensaje claro en lugar de lista vacía

---

## CA-07
**DADO** la pantalla de detalle de residente  
**CUANDO** el usuario hace clic en "Atrás" o botón de retroceso  
**ENTONCES** regresa al listado de residentes sin perder el contexto

**Verificación:** Se vuelve al listado; si había scroll, se mantiene posición (si es apropiado)

---

# F2 — Registrar novedades del turno

## CA-08
**DADO** un usuario en la pantalla de un residente  
**CUANDO** selecciona la opción "Nueva novedad" o similar  
**ENTONCES** se abre un formulario para registrar la novedad

**Verificación:** El formulario aparece con campos visibles

---

## CA-09
**DADO** el formulario de nueva novedad  
**CUANDO** el usuario interactúa con el campo "Tipo"  
**ENTONCES** se muestra un selector (desplegable, botones, etc.) con opciones de tipos de novedad

**Verificación:** Las opciones son accesibles y seleccionables

---

## CA-10
**DADO** el formulario de nueva novedad  
**CUANDO** el usuario interactúa con el campo "Descripción"  
**ENTONCES** puede ingresar texto en un campo de textarea

**Verificación:** El campo acepta múltiples líneas de texto

---

## CA-11
**DADO** que el usuario está registrando una novedad  
**CUANDO** completa los datos obligatorios  
**ENTONCES** el sistema registra automáticamente la fecha y hora actual del sistema

**Verificación:** Al ver el registro guardado, muestra fecha/hora correcta

---

## CA-12
**DADO** una novedad registrada  
**CUANDO** se guarda en el sistema  
**ENTONCES** el usuario autenticado queda identificado como responsable automáticamente

**Verificación:** El registro muestra el email/nombre del usuario que lo creó

---

## CA-13
**DADO** un formulario de novedad con campos obligatorios  
**CUANDO** el usuario intenta guardar sin completar los campos requeridos  
**ENTONCES** el sistema valida y evita guardar

**Verificación:** No se guarda si faltan campos; se muestra indicación de error

---

## CA-14
**DADO** que faltan campos obligatorios  
**CUANDO** el usuario intenta guardar  
**ENTONCES** se muestra un mensaje de error indicando qué campo es obligatorio

**Verificación:** El mensaje es claro y específico

---

## CA-15
**DADO** el formulario de nueva novedad  
**CUANDO** el usuario hace clic en "Cancelar" o retroceso  
**ENTONCES** se cancela la operación y se regresa sin guardar

**Verificación:** No se crea registro; se vuelve a pantalla anterior

---

## CA-16
**DADO** un formulario completo de novedad  
**CUANDO** el usuario selecciona "Guardar" o "Confirmar"  
**ENTONCES** se muestra una pantalla de confirmación con un resumen de los datos

**Verificación:** El resumen es legible y preciso

---

## CA-17
**DADO** la pantalla de confirmación  
**CUANDO** el usuario confirma el registro de la novedad  
**ENTONCES** el sistema guarda la novedad y muestra un mensaje de éxito

**Verificación:** Se ve confirmación ("Novedad registrada"); la novedad aparece en historial

---

# F3 — Consultar historial de seguimiento

## CA-18
**DADO** un usuario en la pantalla de detalle de un residente  
**CUANDO** selecciona la sección "Historial" o similar  
**ENTONCES** se muestra el historial de seguimiento del residente

**Verificación:** Se carga la lista de registros históricos

---

## CA-19
**DADO** el historial de un residente  
**CUANDO** se muestra la lista de registros  
**ENTONCES** los registros están ordenados cronológicamente, mostrando primero los más recientes

**Verificación:** La fecha/hora de cada registro es correcta y decreciente

---

## CA-20
**DADO** el historial con registros  
**CUANDO** se muestra cada registro en la lista  
**ENTONCES** cada uno incluye al menos: fecha/hora, tipo de registro, usuario responsable

**Verificación:** Todos los campos están presentes y legibles

---

## CA-21
**DADO** el historial con registros de múltiples días  
**CUANDO** se visualiza la lista  
**ENTONCES** hay diferenciación visual entre registros de distintos días (ej: separadores, colores)

**Verificación:** Se pueden distinguir claramente registros de diferentes días

---

## CA-22
**DADO** un registro en el historial  
**CUANDO** el usuario lo selecciona/toca  
**ENTONCES** se abre una pantalla con el detalle completo del registro

**Verificación:** Se muestra toda la información del registro

---

## CA-23
**DADO** la sección de historial de un residente  
**CUANDO** no existen registros históricos  
**ENTONCES** se muestra un mensaje indicando "No hay registros para mostrar"

**Verificación:** Mensaje claro en lugar de lista vacía

---

## CA-24
**DADO** que un usuario intenta consultar el historial  
**CUANDO** accede a la información  
**ENTONCES** solo ve registros de residentes que tiene autorización para consultar

**Verificación:** No aparecen registros de otros residentes; respetar RBAC

---

# F4 — Registrar actividades diarias

## CA-25
**DADO** un usuario en la pantalla de detalle de un residente  
**CUANDO** selecciona la sección "Actividades"  
**ENTONCES** se muestra la interfaz para registrar o actualizar actividades

**Verificación:** Se abre la pantalla de actividades

---

## CA-26
**DADO** la pantalla de registrar actividad  
**CUANDO** el usuario selecciona el campo de actividad  
**ENTONCES** se muestra un selector con tipos de actividades predefinidas

**Verificación:** Las opciones son: escuela, recreativa, deportiva, comida, pedagógica, médico, otra

---

## CA-27
**DADO** el formulario de actividad  
**CUANDO** el usuario selecciona el estado de la actividad  
**ENTONCES** puede elegir entre: pendiente, realizada, no realizada

**Verificación:** Las tres opciones están disponibles

---

## CA-28
**DADO** el formulario de actividad  
**CUANDO** el usuario lo completa  
**ENTONCES** existe un campo opcional para registrar observaciones relacionadas

**Verificación:** El campo de observaciones es accesible

---

## CA-29
**DADO** una actividad registrada  
**CUANDO** se guarda en el sistema  
**ENTONCES** se registra automáticamente: fecha, hora, usuario responsable

**Verificación:** El registro guardado contiene estos datos

---

## CA-30
**DADO** un formulario de actividad  
**CUANDO** el usuario intenta guardar sin completar campos obligatorios  
**ENTONCES** el sistema valida e impide guardar

**Verificación:** Se muestra error; no se guarda

---

## CA-31
**DADO** el formulario de actividad  
**CUANDO** el usuario hace clic en "Cancelar"  
**ENTONCES** se cancela la operación y se regresa sin guardar

**Verificación:** No se crea registro; se vuelve atrás

---

## CA-32
**DADO** una actividad guardada correctamente  
**CUANDO** se completa la operación  
**ENTONCES** se muestra un mensaje de confirmación

**Verificación:** Aparece confirmación visual

---

# F5 — Consultar novedades y tareas del turno

## CA-33
**DADO** un usuario autenticado  
**CUANDO** accede a "Mi turno" o similar desde Inicio  
**ENTONCES** se muestra información consolidada de su turno

**Verificación:** Se carga información del turno

---

## CA-34
**DADO** la pantalla de "Mi turno"  
**CUANDO** se carga la información  
**ENTONCES** se muestra el horario o período del turno del usuario

**Verificación:** El horario es correcto y visible

---

## CA-35
**DADO** la pantalla de "Mi turno"  
**CUANDO** se carga  
**ENTONCES** existe una sección con las novedades relevantes para el turno

**Verificación:** Se muestra sección de novedades

---

## CA-36
**DADO** la pantalla de "Mi turno"  
**CUANDO** se carga  
**ENTONCES** existe una sección con tareas y actividades pendientes

**Verificación:** Se muestra sección de tareas/actividades

---

## CA-37
**DADO** una novedad o tarea en "Mi turno"  
**CUANDO** el usuario la selecciona  
**ENTONCES** se navega a una pantalla con el detalle completo

**Verificación:** Se abre pantalla de detalle

---

## CA-38
**DADO** "Mi turno" con múltiples elementos  
**CUANDO** se visualiza la lista  
**ENTONCES** existe diferenciación visual entre elementos atendidos y pendientes (ej: colores, checkmarks)

**Verificación:** Se pueden distinguir estados visualmente

---

## CA-39
**DADO** "Mi turno" cuando no hay novedades ni tareas  
**CUANDO** se carga  
**ENTONCES** se muestra un mensaje indicando "No hay novedades ni tareas pendientes"

**Verificación:** Mensaje claro y apropiado

---

## CA-40
**DADO** que un usuario consulta "Mi turno"  
**CUANDO** accede a la información  
**ENTONCES** solo ve información de sus residentes asignados y de su turno

**Verificación:** No aparece información de otros educadores o residentes no asignados

---

# F6 — Reportar una situación crítica

## CA-41
**DADO** un usuario en la aplicación  
**CUANDO** busca la funcionalidad de situación crítica  
**ENTONCES** existe un acceso claramente diferenciado (ej: botón rojo, icono diferente, ubicación especial)

**Verificación:** El acceso es fácil de encontrar y diferente a otras opciones

---

## CA-42
**DADO** que el usuario selecciona iniciar un reporte de situación crítica  
**CUANDO** accede a esta funcionalidad  
**ENTONCES** se muestra una pantalla de advertencia antes de continuar

**Verificación:** Aparece advertencia con mensaje sobre uso apropiado

---

## CA-43
**DADO** el formulario de situación crítica  
**CUANDO** el usuario interactúa con el campo de NNA  
**ENTONCES** puede seleccionar el o los NNA involucrados

**Verificación:** Es posible seleccionar residentes

---

## CA-44
**DADO** el formulario de situación crítica  
**CUANDO** el usuario selecciona el tipo de situación  
**ENTONCES** se muestra un selector con tipos: violencia, crisis emocional, accidente, fuga, emergencia sanitaria, otra

**Verificación:** Las opciones están disponibles

---

## CA-45
**DADO** el formulario de situación crítica  
**CUANDO** el usuario ingresa información  
**ENTONCES** existe un campo para describir la situación con detalle

**Verificación:** El campo acepta texto descriptivo

---

## CA-46
**DADO** que se registra una situación crítica  
**CUANDO** el usuario guarda el reporte  
**ENTONCES** se registran automáticamente: fecha, hora exacta, usuario responsable

**Verificación:** El registro contiene estos datos

---

## CA-47
**DADO** un formulario de situación crítica  
**CUANDO** el usuario intenta guardar sin completar campos obligatorios  
**ENTONCES** el sistema valida e impide guardar

**Verificación:** Se muestra error; no se guarda

---

## CA-48
**DADO** un formulario de situación crítica completo  
**CUANDO** el usuario selecciona "Guardar" o "Reportar"  
**ENTONCES** se muestra una pantalla de confirmación con resumen de datos

**Verificación:** El resumen es preciso y completo

---

## CA-49
**DADO** la pantalla de confirmación  
**CUANDO** el usuario confirma el reporte  
**ENTONCES** el sistema guarda la situación crítica y muestra confirmación

**Verificación:** Aparece mensaje "Situación reportada"; los datos se guardan

---

## CA-50
**DADO** una situación crítica registrada  
**CUANDO** se consulta el historial del residente  
**ENTONCES** la situación crítica está asociada al NNA y es visible con diferenciación

**Verificación:** El reporte aparece en el historial; está diferenciado visualmente

---

## CA-51
**DADO** la funcionalidad de situación crítica  
**CUANDO** se visualiza en la interfaz  
**ENTONCES** está diferenciada claramente del resto (color, iconografía, posición especial)

**Verificación:** Es visualmente distinta; evita confusión con otras opciones

---

# Resumen de Criterios

| Feature | Criterios | Total |
|---------|-----------|-------|
| F1 — Residentes | CA-01 a CA-07 | 7 |
| F2 — Novedades | CA-08 a CA-17 | 10 |
| F3 — Historial | CA-18 a CA-24 | 7 |
| F4 — Actividades | CA-25 a CA-32 | 8 |
| F5 — Turno | CA-33 a CA-40 | 8 |
| F6 — Situación crítica | CA-41 a CA-51 | 11 |
| **TOTAL** | | **51 criterios** |

---

# Patrón de Validación

Todos los criterios siguen el patrón **DADO-CUANDO-ENTONCES**:

```
DADO <precondición>
CUANDO <acción>
ENTONCES <resultado esperado>

Verificación: <cómo comprobar que se cumple>
```

Este patrón facilita:
- Comunicación clara
- Pruebas funcionales objetivas
- Automatización (si aplica)
- Verificación sin ambigüedad

---

# Cómo Usar Este Documento

## Para Developers

1. Lee el criterio completo (DADO-CUANDO-ENTONCES)
2. Implementa la funcionalidad según lo descrito
3. Verifica usando la "Verificación" (prueba manual)
4. El criterio está "hecho" cuando la verificación pasa

## Para QA / Testing

1. Lee cada criterio
2. Ejecuta la prueba descrita en "Verificación"
3. Documenta si pasa o falla
4. Si falla, describe el comportamiento real vs esperado

## Para Product Owner

1. Usa estos criterios como definición clara de qué es cada Feature
2. Verifica que el MVP cumple todos los criterios de sus Features
3. Usa como base para feedback

---

**51 criterios = MVP completo cuando todos se cumplen. ✅**
