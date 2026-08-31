# Wireframes — Argüello Infancias Mobile

## Objetivo

Definir las pantallas necesarias para representar visualmente las seis Features de Argüello Infancias Mobile.

Los wireframes son elementos de **soporte y diseño**. **No representan Features adicionales.**

Se recomienda construirlos en **Figma** bajo el nombre:

**Argüello Infancias Mobile — Acompañamiento Diario**

---

## 1. Inventario de Wireframes

| ID | Wireframe | Feature relacionada | Propósito |
|---|---|---|---|
| WF-01 | Login | Soporte | Autenticación de usuario |
| WF-02 | Inicio / Dashboard | F5 + acceso general | Punto de entrada post-login |
| WF-03 | Listado de residentes | F1 | Seleccionar residente |
| WF-04 | Detalle del residente | F1 | Ver información de NNA |
| WF-05 | Registrar novedad | F2 | Formulario de novedad |
| WF-06 | Confirmar novedad | F2 | Revisar antes de guardar |
| WF-07 | Historial de seguimiento | F3 | Lista cronológica de registros |
| WF-08 | Detalle del historial | F3 | Ver registro completo |
| WF-09 | Actividades del residente | F4 | Lista de actividades |
| WF-10 | Registrar/actualizar actividad | F4 | Formulario de actividad |
| WF-11 | Mi turno | F5 | Resumen operativo del turno |
| WF-12 | Detalle de novedad/tarea | F5 | Información completa del elemento |
| WF-13 | Advertencia de situación crítica | F6 | Confirmación previa |
| WF-14 | Registrar situación crítica | F6 | Formulario de reporte |
| WF-15 | Confirmar situación crítica | F6 | Revisar reporte antes de guardar |

**Total: 15 wireframes**

---

# 2. Descripción Detallada de Wireframes

## WF-01 — Login

**Feature relacionada:** Soporte (pre-Feature)

**Propósito:** Permitir el acceso seguro a usuarios autenticados.

**Elementos:**

- [ ] Logo/identidad de Argüello Infancias Mobile (header)
- [ ] Título "Iniciar sesión" o similar
- [ ] Campo de usuario/correo (con placeholder)
- [ ] Campo de contraseña (con toggle mostrar/ocultar)
- [ ] Botón "Ingresar" (primario, full-width)
- [ ] Espacio para mensaje de error
- [ ] Indicador de carga (mientras valida)
- [ ] Link "¿Olvidaste tu contraseña?" (si aplica)
- [ ] Opcionales: versión/número de app

**Estados:**
- Normal (vacío)
- Con datos ingresados
- Cargando
- Error (credenciales inválidas)

**Validaciones:**
- Email válido
- Contraseña no vacía
- Mensajes de error claros

---

## WF-02 — Inicio / Dashboard

**Feature relacionada:** F5 (acceso general)

**Propósito:** Funcionar como punto de entrada después del login. Debe permitir acceso a todas las funcionalidades principales.

**Elementos:**

- [ ] Header con saludo personalizado ("Hola, [nombre]")
- [ ] Resumen rápido del turno:
  - Hora inicio/fin
  - Cantidad de NNA a cargo
  - Estado del turno (activo, próximo, finalizado)
- [ ] Tarjetas/botones de acceso rápido:
  - [ ] Residentes (F1)
  - [ ] Mi turno (F5)
  - [ ] Registrar novedad (F2)
  - [ ] Registrar actividad (F4)
- [ ] **Botón destacado "Situación Crítica" (F6)** — diferenciado visualmente (rojo/naranja)
- [ ] Footer/navegación inferior con opciones
- [ ] Indicador de usuario logueado (con opción logout)

**Comportamiento:**
- Cada tarjeta es navegable a su funcionalidad
- El botón de Situación Crítica debe ser prominente
- Debe cargar información del turno actual

---

## WF-03 — Listado de Residentes

**Feature relacionada:** F1 (Consultar residentes)

**Propósito:** Permitir seleccionar un residente para consultar su información.

**Elementos:**

- [ ] Header con título "Residentes"
- [ ] (Opcional) Buscador/filtro
- [ ] Lista de residentes con:
  - [ ] Foto/avatar
  - [ ] Nombre completo
  - [ ] Edad o fecha de nacimiento
  - [ ] Indicador de estado (activo, etc.)
  - [ ] Separador entre items

**Estados:**
- Lista con residentes
- Lista vacía ("No hay residentes para mostrar")
- Cargando
- Error de conexión

**Interacción:**
- Cada item es seleccionable (tap)
- Lleva a WF-04 (Detalle)

**Navegación:**
- Atrás (a Inicio)

---

## WF-04 — Detalle del Residente

**Feature relacionada:** F1 (Consultar residentes)

**Propósito:** Mostrar información autorizada del residente y acceso a sus registros.

**Elementos:**

- [ ] Header con nombre y foto del NNA
- [ ] Información del residente:
  - [ ] Edad
  - [ ] Fecha de nacimiento
  - [ ] DNI (si autorizado)
  - [ ] Contacto de emergencia
  - [ ] Obra social
  - [ ] Estado
  - [ ] Educador asignado

- [ ] Secciones de acceso (tabs o acordeones):
  - [ ] Información (actual)
  - [ ] Novedades (acceso a F2)
  - [ ] Historial (acceso a F3)
  - [ ] Actividades (acceso a F4)

**Botones:**
- [ ] "Nueva novedad" (si tiene permisos)
- [ ] "Registrar actividad" (si tiene permisos)

**Navegación:**
- Atrás (a Listado de residentes)

---

## WF-05 — Registrar Novedad

**Feature relacionada:** F2 (Registrar novedades)

**Propósito:** Formulario para crear una nueva novedad.

**Elementos:**

- [ ] Header "Nueva novedad"
- [ ] NNA (mostrado, no editable o con selector)
- [ ] Campo "Tipo de novedad" (dropdown/selector):
  - Opciones: conducta, emocional, educativo, sanitario, otro
- [ ] Campo "Descripción" (textarea, multiline)
- [ ] Indicadores:
  - [ ] Fecha/hora del sistema (info, no editable)
  - [ ] Usuario responsable (info, no editable)
- [ ] Botones:
  - [ ] Cancelar (secundario)
  - [ ] Continuar/Guardar (primario)

**Validaciones:**
- Tipo obligatorio
- Descripción mínimo 10 caracteres
- Mostrar errores bajo campo afectado

**Estados:**
- Vacío
- Parcialmente completo (validar mientras escribe)
- Completo
- Error (validación fallida)

---

## WF-06 — Confirmar Novedad

**Feature relacionada:** F2 (Registrar novedades)

**Propósito:** Mostrar resumen antes de guardar.

**Elementos:**

- [ ] Header "Confirmar novedad"
- [ ] Resumen en tarjeta:
  - [ ] NNA
  - [ ] Tipo
  - [ ] Descripción (limitado a 2-3 líneas con scroll si es largo)
  - [ ] Fecha/hora
  - [ ] Usuario

- [ ] Botones:
  - [ ] Volver a editar (secundario)
  - [ ] Confirmar y guardar (primario, rojo/verde)

**Información importante:**
- El resumen debe ser legible y preciso
- No permitir edición desde esta pantalla

---

## WF-07 — Historial de Seguimiento

**Feature relacionada:** F3 (Consultar historial)

**Propósito:** Mostrar registros cronológicos del residente.

**Elementos:**

- [ ] Header "Historial de [nombre NNA]"
- [ ] Filtros (opcional):
  - [ ] Por tipo
  - [ ] Por fecha
- [ ] Lista de registros con:
  - [ ] Fecha/hora
  - [ ] Tipo de registro (badge/etiqueta)
  - [ ] Descripción resumida (1-2 líneas)
  - [ ] Usuario responsable
  - [ ] Indicador visual de día (separador entre días diferentes)

**Estados:**
- Lista con registros
- Lista vacía ("No hay registros")
- Cargando

**Ordenamiento:**
- Descendente (más recientes primero)

**Interacción:**
- Cada registro es seleccionable (tap) → WF-08

---

## WF-08 — Detalle del Historial

**Feature relacionada:** F3 (Consultar historial)

**Propósito:** Mostrar registro completo.

**Elementos:**

- [ ] Header con fecha/hora del registro
- [ ] Información completa:
  - [ ] Tipo
  - [ ] NNA
  - [ ] Descripción completa
  - [ ] Usuario responsable
  - [ ] Fecha y hora exacta
- [ ] (Opcional) Editar si tiene permisos (solo visualizar por ahora)

**Navegación:**
- Atrás (a Historial)

---

## WF-09 — Actividades del Residente

**Feature relacionada:** F4 (Registrar actividades)

**Propósito:** Mostrar actividades del residente y permitir registrar/actualizar.

**Elementos:**

- [ ] Header "Actividades de [nombre NNA]"
- [ ] Vista de actividades con:
  - [ ] Actividad (nombre)
  - [ ] Estado actual (badge: Pendiente, Realizada, No realizada)
  - [ ] Fecha/hora
  - [ ] Cada item es seleccionable

- [ ] Botón "Nueva actividad" (primario)

**Estados:**
- Lista con actividades
- Lista vacía ("No hay actividades para hoy")
- Cargando

---

## WF-10 — Registrar/Actualizar Actividad

**Feature relacionada:** F4 (Registrar actividades)

**Propósito:** Formulario para registrar o actualizar actividad.

**Elementos:**

- [ ] Header "Nueva actividad" o "Actualizar actividad"
- [ ] Campo "Actividad" (dropdown):
  - Opciones: Escuela, Recreativa, Deportiva, Comida, Pedagógica, Médico, Otra
- [ ] Campo "Estado" (radio buttons o selector):
  - Pendiente
  - Realizada
  - No realizada
- [ ] Campo "Observaciones" (textarea, opcional)
- [ ] Información:
  - [ ] Fecha/hora (no editable)
  - [ ] Usuario (no editable)
- [ ] Botones:
  - [ ] Cancelar
  - [ ] Guardar

**Validaciones:**
- Actividad obligatoria
- Estado obligatorio

---

## WF-11 — Mi Turno

**Feature relacionada:** F5 (Consultar turno)

**Propósito:** Resumen consolidado del turno.

**Elementos:**

- [ ] Header "Mi turno"
- [ ] Tarjeta de turno:
  - [ ] Horario (inicio - fin)
  - [ ] Cantidad de NNA a cargo
  - [ ] Estado (Activo, Por iniciar, Finalizado)

- [ ] Secciones (accordeones o tabs):
  - [ ] **Novedades relevantes:**
    - Últimas 24h
    - Alertas
    - Cambios de estado
    - Click accede a detalle (WF-12)

  - [ ] **Tareas pendientes:**
    - Medicación
    - Turnos médicos
    - Actividades programadas
    - Click accede a detalle (WF-12)

  - [ ] **Actividades pendientes:**
    - Lista de actividades sin completar
    - Click accede a detalle (WF-12)

- [ ] Información del turno anterior (expandible)

**Estados:**
- Activo
- Sin novedades ("No hay novedades pendientes")
- Cargando

---

## WF-12 — Detalle de Novedad/Tarea

**Feature relacionada:** F5 (Consultar turno)

**Propósito:** Ver detalle completo desde "Mi turno".

**Elementos:**

- [ ] Header con tipo de elemento
- [ ] Información completa:
  - [ ] NNA involucrado
  - [ ] Descripción
  - [ ] Fecha/hora
  - [ ] Usuario responsable
  - [ ] Estado (si aplica)

**Navegación:**
- Atrás (a Mi turno)

---

## WF-13 — Advertencia de Situación Crítica

**Feature relacionada:** F6 (Reportar crítica)

**Propósito:** Confirmación previa antes de iniciar reporte crítico.

**Elementos:**

- [ ] Ícono/badge diferenciado (⚠️ o 🔴)
- [ ] Título "Atención"
- [ ] Mensaje claro:
  ```
  Esta funcionalidad debe utilizarse únicamente cuando 
  exista una situación que requiera ser reportada como crítica.
  ```
- [ ] Botones:
  - [ ] Cancelar (secundario)
  - [ ] Continuar (primario, rojo)

**Diferenciación visual:**
- Fondo rojo o naranja
- Texto contrastante
- Ícono prominente

---

## WF-14 — Registrar Situación Crítica

**Feature relacionada:** F6 (Reportar crítica)

**Propósito:** Formulario para reportar situación crítica.

**Elementos:**

- [ ] Header "Reportar situación crítica" (rojo/naranja)
- [ ] Campo "NNA involucrado(s)" (selector múltiple)
- [ ] Campo "Tipo de situación" (dropdown):
  - Violencia
  - Crisis emocional
  - Accidente
  - Fuga
  - Emergencia sanitaria
  - Otra

- [ ] Campo "Descripción" (textarea, obligatorio)
  - Placeholder: "Describe la situación detalladamente"

- [ ] Campo "Acciones tomadas" (textarea, opcional)
- [ ] Campo "Personas notificadas" (checkboxes, opcional)

- [ ] Información:
  - [ ] Fecha/hora actual (no editable)
  - [ ] Usuario responsable (no editable)

- [ ] Botones:
  - [ ] Cancelar
  - [ ] Continuar (primario)

**Validaciones:**
- Tipo obligatorio
- Descripción mínimo 20 caracteres

---

## WF-15 — Confirmar Situación Crítica

**Feature relacionada:** F6 (Reportar crítica)

**Propósito:** Revisión final antes de guardar reporte crítico.

**Elementos:**

- [ ] Header "Confirmar reporte crítico" (rojo/naranja)
- [ ] Resumen en tarjeta:
  - [ ] NNA involucrado(s)
  - [ ] Tipo
  - [ ] Descripción (limitado con scroll)
  - [ ] Acciones tomadas (si aplica)
  - [ ] Personas notificadas (si aplica)
  - [ ] Fecha/hora
  - [ ] Usuario

- [ ] Botones:
  - [ ] Volver a editar (secundario)
  - [ ] **Confirmar reporte (primario, rojo/naranja)**

**Información importante:**
- El resumen debe ser legible
- La diferenciación visual debe ser clara
- No permitir edición desde esta pantalla

---

# 3. Estados Comunes en Todos los Wireframes

### 3.1 Estado de Carga

Mostrar en cualquier pantalla que depende de datos:

```
[Spinner/Loading animation]
Cargando información...
```

### 3.2 Estado de Error

Mostrar cuando falla la conexión:

```
⚠️ No se pudo cargar la información
   [Botón "Reintentar"]
```

### 3.3 Estado Vacío

Mostrar cuando no hay datos:

```
📭 No hay [elemento] para mostrar

[Descripción útil de por qué está vacío]
```

### 3.4 Validación de Formulario

Mostrar errores bajo cada campo:

```
[Campo con borde rojo]
❌ Este campo es obligatorio
```

### 3.5 Confirmación de Éxito

Mostrar después de guardar:

```
✅ [Elemento] guardado correctamente
   [Auto-cerrar o botón para continuar]
```

---

# 4. Componentes Reutilizables

### 4.1 Header Estándar

- Título
- Botón atrás (cuando aplique)
- Icono de menú/usuario (si aplica)

### 4.2 Tarjeta de Residente

- Foto/avatar
- Nombre
- Edad
- Estado
- Información adicional (según contexto)

### 4.3 Tarjeta de Registro

- Icono de tipo
- Descripción resumida
- Fecha/hora
- Usuario
- Estado (badge)

### 4.4 Botones

- **Primario:** Acción principal (guardar, continuar, confirmar)
- **Secundario:** Acciones alternativas (cancelar, volver)
- **Peligro/Crítica:** Rojo/naranja para situaciones críticas

### 4.5 Campos de Formulario

- Label claro
- Placeholder descriptivo
- Indicador de obligatorio (*)
- Mensaje de error (si aplica)
- Mensaje de ayuda (si necesario)

---

# 5. Guía de Diseño Visual

### 5.1 Diferenciación de Situación Crítica

- Color: Rojo (RGB: 220, 53, 69) o naranja (RGB: 255, 127, 39)
- Ícono: ⚠️ o 🔴
- Posición: Acceso desde Inicio, botón prominente
- Confirmación: Advertencia previa en WF-13

### 5.2 Colores por Elemento

- **Primario (Acciones):** Verde o azul (#007AFF)
- **Secundario (Alternativas):** Gris
- **Crítica (Situaciones):** Rojo (#DC3545)
- **Éxito:** Verde (#28A745)
- **Advertencia:** Naranja (#FFC107)
- **Error:** Rojo (#DC3545)

### 5.3 Tipografía

- **Headers:** Bold, tamaño grande
- **Cuerpo:** Regular, tamaño estándar
- **Etiquetas/Badges:** Small, Bold
- **Placeholder:** Gris claro, Regular

---

# 6. Regla de Diseño

No crear un wireframe únicamente para aumentar cantidad.

Cada wireframe debe:

- ✅ Implementar una parte de un flujo real
- ✅ Tener una acción o información útil
- ✅ Estar directamente relacionado con una Feature (F1-F6)
- ✅ Mantener consistencia visual y de navegación
- ✅ Ser necesario para el flujo del usuario

**Total de wireframes: 15 (no más, no menos)**

---

# 7. Próximos Pasos

1. Crear archivo en Figma con nombre: **"Argüello Infancias Mobile — Acompañamiento Diario"**
2. Crear 15 frames (uno por wireframe)
3. Seguir estructura y elementos descritos arriba
4. Aplicar guía de diseño visual
5. Compartir link con el equipo
6. Recopilar feedback y iterar

---

**Los wireframes son soporte para implementar las 6 Features. No son Features adicionales.**
