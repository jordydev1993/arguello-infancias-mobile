# Features — Argüello Infancias Mobile

## 1. Objetivo

Este documento define las funcionalidades principales de Argüello Infancias Mobile. Una Feature representa una capacidad concreta que permite al usuario realizar una acción, consultar información o alcanzar un objetivo.

La versión inicial contempla **6 Features**.

---

## F1 — Consultar información de los residentes

Permite al educador consultar información autorizada de los NNA residentes para facilitar el acompañamiento durante su turno.

**Objetivo:** Acceder rápidamente a datos básicos de los NNA asignados.

**Actores:** Educador, Operador convivencial

**Flujo principal:** 
```
Inicio → Residentes → Seleccionar NNA → Detalle
```

**Datos visualizados:**
- Nombre
- Edad / Fecha de nacimiento
- Foto (si aplica)
- Datos de contacto de emergencia
- Estado actual
- NNA asignado a educador

**Permiso requerido:** Lectura de información de residentes asignados

---

## F2 — Registrar novedades del turno

Permite al educador registrar una novedad asociada a un NNA, indicando tipo, descripción, fecha/hora y responsable.

**Objetivo:** Crear un registro inmediato de eventos o cambios durante el turno.

**Actores:** Educador, Operador convivencial

**Flujo principal:** 
```
Inicio → Residentes → NNA → Nueva novedad → Registrar → Confirmar
```

**Datos requeridos:**
- NNA (seleccionado)
- Tipo de novedad (desplegable)
- Descripción (textarea)
- Fecha/hora (automática del sistema)
- Usuario responsable (automático del usuario logged)

**Validaciones:**
- Tipo obligatorio
- Descripción mínimo 10 caracteres
- NNA válido

**Permiso requerido:** Crear observaciones para NNA asignados

---

## F3 — Consultar historial de seguimiento

Permite consultar cronológicamente los registros anteriores asociados a un NNA.

**Objetivo:** Ver el historial de observaciones, novedades y actividades de un NNA.

**Actores:** Educador, Operador convivencial, Técnico

**Flujo principal:** 
```
Inicio → Residentes → NNA → Historial → Seleccionar registro → Detalle
```

**Datos mostrados:**
- Fecha/hora del registro
- Tipo de registro (novedad, actividad, etc.)
- Descripción
- Usuario que realizó el registro
- Estado relacionado (si aplica)

**Orden:** Cronológico descendente (más recientes primero)

**Permiso requerido:** Lectura de historial del NNA asignado

---

## F4 — Registrar actividades diarias

Permite registrar las actividades realizadas durante la jornada y su estado.

**Objetivo:** Documentar actividades completadas o pendientes durante el turno.

**Actores:** Educador, Operador convivencial

**Flujo principal:** 
```
Inicio → Residentes → NNA → Actividades → Registrar/Actualizar → Confirmar
```

**Tipos de actividades:**
- Asistencia escolar
- Actividad recreativa
- Actividad deportiva
- Comida
- Actividad pedagógica
- Turno médico
- Otra

**Estados:**
- Pendiente
- Realizada
- No realizada

**Datos:**
- Actividad (seleccionada)
- Estado (seleccionado)
- Observaciones (opcional)
- Duración (opcional)
- Participantes (opcional)
- Fecha/hora (automática)

**Permiso requerido:** Crear/actualizar actividades para NNA asignados

---

## F5 — Consultar novedades y tareas del turno

Permite al educador consultar la información relevante para iniciar y continuar su turno, incluyendo novedades, tareas, actividades pendientes y otra información operativa autorizada.

**Objetivo:** Tener visión consolidada del turno: qué pasó antes, qué hay que hacer, qué alertas hay.

**Actores:** Educador, Operador convivencial

**Flujo principal:** 
```
Inicio → Mi turno → Ver novedades/tareas/actividades → Seleccionar → Detalle
```

**Secciones:**

1. **Turno Actual**
   - Horario del turno
   - Educador responsable
   - NNA a cargo

2. **Novedades Relevantes**
   - Últimas 24 horas
   - Alertas
   - Cambios de estado

3. **Tareas Pendientes**
   - Medicación
   - Turnos médicos
   - Actividades programadas

4. **Información del Turno Anterior**
   - Resumen de novedades
   - Situaciones pendientes
   - Recomendaciones

**Permiso requerido:** Lectura de información de su turno y residentes asignados

---

## F6 — Reportar una situación crítica

Permite registrar una situación crítica asociada a un NNA, dejando constancia de la situación, fecha/hora y usuario responsable.

**Objetivo:** Crear un registro inmediato y diferenciado de situaciones que requieren atención especial.

**Actores:** Educador, Operador convivencial

**Flujo principal:** 
```
Inicio → Situación crítica → Advertencia de confirmación → Formulario → Confirmar
```

**Tipos de situaciones críticas:**
- Violencia (entre residentes, auto-lesiones)
- Crisis emocional
- Accidente
- Fuga
- Emergencia sanitaria
- Otra situación que requiera intervención

**Datos requeridos:**
- NNA involucrado(s)
- Tipo de situación
- Descripción detallada
- Acciones tomadas
- Personas notificadas

**Validaciones:**
- Tipo obligatorio
- Descripción mínimo 20 caracteres
- Confirmación previa a guardar

**Advertencia:** Antes de iniciar, mostrar mensaje clarificando que esta funcionalidad debe usarse únicamente cuando corresponda.

**Permiso requerido:** Crear reportes críticos para NNA asignados

---

## 2. Resumen de Features

| ID | Feature | Objetivo | Actor |
|---|---|---|---|
| F1 | Consultar residentes | Ver datos de NNA | Educador |
| F2 | Registrar novedades | Documentar eventos | Educador |
| F3 | Consultar historial | Ver seguimiento cronológico | Educador |
| F4 | Registrar actividades | Documentar actividades | Educador |
| F5 | Consultar turno | Resumen de operaciones | Educador |
| F6 | Situación crítica | Registrar emergencias | Educador |

---

## 3. Principios de Features

### 3.1 Features = Capacidades, no Pantallas

Cada Feature representa una capacidad del usuario:
- NO es una pantalla
- NO es un componente
- SÍ es algo que el usuario puede hacer

### 3.2 Todas las Features son de Lectura/Escritura

| Feature | Lectura | Escritura |
|---------|---------|-----------|
| F1 | ✅ | ❌ |
| F2 | ❌ | ✅ |
| F3 | ✅ | ❌ |
| F4 | ✅ | ✅ |
| F5 | ✅ | ❌ |
| F6 | ❌ | ✅ |

### 3.3 Autenticación Previa

Todas las Features requieren que el usuario esté autenticado y tenga permisos específicos.

### 3.4 Datos Inmutables

Una vez registrada una novedad o situación crítica, no puede editarse (solo consultar). Esto asegura trazabilidad.

---

## 4. Consideraciones de Diseño

### 4.1 Acceso a Situación Crítica

Debe ser claramente diferenciado en la UI:
- Botón destacado
- Icono diferente
- Acceso desde múltiples pantallas (no solo inicio)

### 4.2 Validaciones

Todas las Features con escritura deben validar:
- Campos obligatorios
- Formato de datos
- Longitud mínima de textos
- Usuario autorizado

### 4.3 Confirmación

Cualquier operación de escritura debe:
1. Mostrar resumen de datos
2. Solicitar confirmación explícita
3. Informar éxito/error después

### 4.4 Información Contextual

Cada Feature debe mostrar:
- NNA actual (cuando aplique)
- Usuario logged
- Fecha/hora actual
- Indicador de conexión (si aplica)

---

## 5. Fuera de Estas Features

**NO son Features:**
- Pantalla de login (soporte)
- Menú de navegación (soporte)
- Pantalla de inicio (soporte)
- Confirmaciones (soporte)
- Componentes visuales
- Gestos de UI

**SÍ son Features:**
- Capacidades de negocio real
- Acciones que el usuario puede realizar
- Generan datos persistentes (o consultan)
- Directamente relacionadas con acompañamiento diario

---

## 6. Prioridad de Implementación

Orden recomendado para desarrollo:

1. **F1 - Consultar residentes** (fundacional)
   - Sin esto, no se puede hacer nada más
   - Más simple de implementar

2. **F2 - Registrar novedades** (core)
   - Necesaria para el caso de uso principal

3. **F3 - Consultar historial** (lectura)
   - Complemento natural de F1

4. **F4 - Registrar actividades** (escritura)
   - Similar a F2, menor complejidad de datos

5. **F5 - Consultar turno** (síntesis)
   - Requiere que F2, F4 estén listas
   - Muestra vista consolidada

6. **F6 - Situación crítica** (caso especial)
   - Puede desarrollarse en paralelo a F2
   - Pero después de F2 en prioridad

---

**Cada Feature debe completarse con Criterios de Aceptación y Wireframes antes de empezar implementación.**
