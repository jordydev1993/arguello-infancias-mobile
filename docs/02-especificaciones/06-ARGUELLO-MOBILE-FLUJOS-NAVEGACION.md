# Flujos de Navegación — Argüello Infancias Mobile

## Objetivo

Definir cómo se desplaza el usuario entre las diferentes partes de Argüello Infancias Mobile. Los flujos muestran cómo cada Feature se transforma en una secuencia de interacciones.

**Las pantallas son elementos de implementación. El producto mantiene 6 Features, independientemente de la cantidad de pantallas utilizadas.**

---

# 1. Flujo General de la Aplicación

```
                    ┌─────────┐
                    │  LOGIN  │
                    │ (WF-01) │
                    └────┬────┘
                         │
                         ▼
                ┌────────────────┐
                │     INICIO     │
                │     (WF-02)    │
                └───────┬────────┘
                        │
        ┌───────────────┼────────────────┐
        │               │                │
        ▼               ▼                ▼
   RESIDENTES        MI TURNO      SITUACIÓN CRÍTICA
   (WF-03)           (WF-11)          (WF-13)
        │               │                │
        ▼               │                ▼
   SELECCIONAR          │          ADVERTENCIA
       NNA              │            (confirmación)
   (WF-04)              │                │
        │               │                ▼
   ┌────┼────┐          │           FORMULARIO
   │    │    │          │           (WF-14)
   ▼    ▼    ▼          │                │
 INFO NOVEDADES          │                ▼
 (WF-04)│ (WF-05)       │            CONFIRMAR
        │    │          │           (WF-15)
        │    ▼          │
        │ CONFIRMAR      │
        │ (WF-06)        │
        │    │           │
        │    ▼           │
        │ GUARDADO ✓     │
        │                │
   ┌────┴─────┐          │
   │    │     │          │
   ▼    ▼     ▼          │
ACTIVIDADES HISTORIAL    │
(WF-09)     (WF-07)      │
   │          │          │
   ▼          ▼          ▼
 REG. ACT  DET. REG   GUARDADO ✓
(WF-10)   (WF-08)
   │          │          │
   └──────┬───┴──────────┘
          │
          ▼
        INICIO
```

---

# 2. Flujos por Feature

## F1 — Consultar Información de Residentes

### Flujo Principal

```
INICIO (WF-02)
  │
  ├─ Click "Residentes"
  ▼
LISTADO RESIDENTES (WF-03)
  │
  ├─ Click residente
  ▼
DETALLE RESIDENTE (WF-04)
  │
  ├─ Puedo ver:
  │  ├─ Información básica
  │  ├─ Contacto emergencia
  │  ├─ Obra social
  │  └─ Estado
  │
  ├─ Puedo acceder a:
  │  ├─ Historial (F3) → WF-07
  │  ├─ Novedades (F2) → WF-05
  │  └─ Actividades (F4) → WF-09
  │
  └─ Click "Atrás"
     ▼
  LISTADO RESIDENTES (WF-03)
```

### Variantes

**Cuando no hay residentes:**
```
RESIDENTES (WF-03)
  │
  ├─ Empty state
  │ "No hay residentes para mostrar"
  │
  └─ Click "Atrás"
     ▼
  INICIO
```

---

## F2 — Registrar Novedades del Turno

### Flujo Principal

```
DETALLE RESIDENTE (WF-04)
  │
  ├─ Click "Nueva novedad"
  ▼
REGISTRAR NOVEDAD (WF-05)
  │
  ├─ Ingreso datos:
  │  ├─ Tipo
  │  ├─ Descripción
  │  └─ (Automático: fecha/hora, usuario)
  │
  ├─ Click "Continuar" o "Guardar"
  │ (valida campos obligatorios)
  │ │
  │ ├─ SI hay errores:
  │ │  → Muestra error en campo
  │ │  → Vuelve a WF-05
  │ │
  │ └─ SI datos válidos:
  ▼
CONFIRMAR NOVEDAD (WF-06)
  │
  ├─ Veo resumen:
  │  ├─ NNA
  │  ├─ Tipo
  │  ├─ Descripción
  │  ├─ Fecha/hora
  │  └─ Usuario
  │
  ├─ Click "Volver a editar"
  │ ├─ Vuelve a WF-05
  │ │
  ├─ Click "Confirmar"
  │ ▼
  │ GUARDAR EN BD
  │ │
  ▼ ├─ Click "Aceptar" o auto-cierre
  │ │
  └─ Vuelve a DETALLE RESIDENTE (WF-04)
     o LISTADO RESIDENTES (WF-03)
```

### Variantes

**Desde Inicio:**
```
INICIO (WF-02)
  │
  ├─ Click "Registrar novedad"
  ▼
LISTADO RESIDENTES (WF-03)
  │
  ├─ Click residente
  ▼
DETALLE RESIDENTE (WF-04)
  │
  └─ [continúa flujo principal F2]
```

---

## F3 — Consultar Historial de Seguimiento

### Flujo Principal

```
DETALLE RESIDENTE (WF-04)
  │
  ├─ Click tab "Historial"
  ▼
HISTORIAL (WF-07)
  │
  ├─ Veo lista cronológica:
  │  ├─ Fecha/hora
  │  ├─ Tipo
  │  ├─ Descripción resumida
  │  └─ Usuario
  │
  ├─ Si hay muchos registros:
  │  └─ Scroll/paginación
  │
  ├─ Click en un registro
  ▼
DETALLE REGISTRO (WF-08)
  │
  ├─ Veo información completa
  │
  ├─ Click "Atrás"
  │ ▼
  └─ HISTORIAL (WF-07)
     │
     └─ Click "Atrás"
        ▼
     DETALLE RESIDENTE (WF-04)
```

### Variantes

**Historial vacío:**
```
HISTORIAL (WF-07)
  │
  ├─ Empty state
  │ "No hay registros para mostrar"
  │
  └─ Click "Atrás"
     ▼
  DETALLE RESIDENTE (WF-04)
```

---

## F4 — Registrar Actividades Diarias

### Flujo Principal

```
DETALLE RESIDENTE (WF-04)
  │
  ├─ Click tab "Actividades"
  ▼
ACTIVIDADES (WF-09)
  │
  ├─ Veo lista de actividades
  │
  ├─ Click "Nueva actividad"
  │ o Click en actividad existente
  ▼
REG./ACTUALIZAR ACTIVIDAD (WF-10)
  │
  ├─ Ingreso datos:
  │  ├─ Actividad (tipo)
  │  ├─ Estado
  │  ├─ Observaciones (opcional)
  │  └─ (Automático: fecha/hora, usuario)
  │
  ├─ Click "Guardar"
  │ (valida campos obligatorios)
  │ │
  │ ├─ SI errores:
  │ │  → Muestra error
  │ │  → Vuelve a WF-10
  │ │
  │ └─ SI válido:
  ▼
  GUARDAR EN BD
  │
  ├─ Confirmación
  │ "Actividad guardada"
  │
  └─ Vuelve a ACTIVIDADES (WF-09)
     │
     └─ Lista se actualiza
```

### Variantes

**Actividades vacías:**
```
ACTIVIDADES (WF-09)
  │
  ├─ Empty state
  │ "No hay actividades"
  │
  ├─ Click "Nueva actividad"
  │ ▼
  └─ [continúa flujo principal F4]
```

---

## F5 — Consultar Novedades y Tareas del Turno

### Flujo Principal

```
INICIO (WF-02)
  │
  ├─ Click "Mi turno"
  ▼
MI TURNO (WF-11)
  │
  ├─ Veo:
  │  ├─ Horario del turno
  │  ├─ Cantidad NNA a cargo
  │  ├─ Novedades relevantes
  │  ├─ Tareas pendientes
  │  └─ Actividades pendientes
  │
  ├─ Click en novedad/tarea
  ▼
DETALLE NOVEDAD/TAREA (WF-12)
  │
  ├─ Veo información completa
  │
  ├─ Click "Atrás"
  │ ▼
  └─ MI TURNO (WF-11)
     │
     └─ Click "Atrás" o ir a Inicio
        ▼
     INICIO (WF-02)
```

### Información Mostrada en MI TURNO

**Sección 1: Turno Actual**
```
┌─────────────────────────┐
│ Turno: 08:00 - 16:00   │
│ NNA a cargo: 5         │
│ Estado: ACTIVO          │
└─────────────────────────┘
```

**Sección 2: Novedades Relevantes**
```
- Último 24h
- Alertas
- Cambios de estado

Click en novedad → WF-12
```

**Sección 3: Tareas Pendientes**
```
- Medicación
- Turnos médicos
- Actividades programadas

Click en tarea → WF-12
```

**Sección 4: Información Turno Anterior**
```
- Resumen de novedades
- Situaciones pendientes
(expandible)
```

---

## F6 — Reportar Situación Crítica

### Flujo Principal

```
INICIO (WF-02)
  │
  ├─ Click "⚠️ SITUACIÓN CRÍTICA"
  │ (botón diferenciado, rojo/naranja)
  ▼
ADVERTENCIA (WF-13)
  │
  ├─ Mensaje de confirmación:
  │ "Esta funcionalidad debe utilizarse únicamente
  │  cuando exista una situación crítica"
  │
  ├─ Click "Cancelar"
  │ ├─ Vuelve a INICIO (WF-02)
  │ │
  ├─ Click "Continuar"
  ▼
REGISTRAR CRÍTICA (WF-14)
  │
  ├─ Ingreso datos:
  │  ├─ NNA involucrado(s)
  │  ├─ Tipo de situación
  │  ├─ Descripción (detallada)
  │  ├─ Acciones tomadas (opcional)
  │  ├─ Personas notificadas (opcional)
  │  └─ (Automático: fecha/hora precisa, usuario)
  │
  ├─ Click "Cancelar"
  │ ├─ Vuelve a INICIO (WF-02)
  │ │
  ├─ Click "Continuar"
  │ (valida: tipo, descripción mínimo 20 caracteres)
  │ │
  │ ├─ SI errores:
  │ │  → Muestra error
  │ │  → Vuelve a WF-14
  │ │
  │ └─ SI válido:
  ▼
CONFIRMAR CRÍTICA (WF-15)
  │
  ├─ Resumen detallado:
  │  ├─ NNA
  │  ├─ Tipo
  │  ├─ Descripción
  │  ├─ Acciones
  │  ├─ Personas notificadas
  │  ├─ Fecha/hora precisa
  │  └─ Usuario
  │
  ├─ Click "Volver a editar"
  │ ├─ Vuelve a WF-14
  │ │
  ├─ Click "CONFIRMAR REPORTE"
  │ (botón rojo, confirmación final)
  │ ▼
  │ GUARDAR EN BD (registra como CRÍTICA)
  │ │
  ▼ ├─ Confirmación prominente:
    │ "✅ Situación reportada"
    │ "[Posibilidad de notificar via sistema]"
    │
    └─ Vuelve a INICIO (WF-02)
       o [Pantalla especial de seguimiento]
```

### Diferenciación Visual

- Color: **Rojo** (#DC3545)
- Ícono: **⚠️** o **🔴**
- Acceso prominente desde Inicio
- Advertencia previa (WF-13) obligatoria
- Botón de confirmación final debe ser explícito

### Casos de Uso

**Tipos de situaciones críticas:**
- Violencia (entre residentes)
- Auto-lesiones
- Crisis emocional severa
- Accidente
- Fuga
- Emergencia sanitaria
- Otra situación que requiera intervención inmediata

---

# 3. Flujos de Error

## Error de Conexión

```
CUALQUIER PANTALLA
  │
  ├─ Falla conexión
  ▼
MOSTRAR ERROR
  │
  ├─ "⚠️ No se pudo cargar la información"
  ├─ Botón "Reintentar"
  │ │
  │ └─ Vuelve a intentar
  │
  └─ Botón "Ir a Inicio"
     ▼
     INICIO
```

## Error de Validación

```
FORMULARIO (cualquier WF con forms)
  │
  ├─ Usuario hace click "Guardar"
  ▼
VALIDAR CAMPOS
  │
  ├─ Falta campo obligatorio
  │ o datos inválidos
  ▼
MOSTRAR ERROR
  │
  ├─ Borde rojo en campo
  ├─ Mensaje debajo: "Este campo es obligatorio"
  │
  └─ Usuario corrige
     ▼
  [Vuelve a validar cuando click "Guardar"]
```

## Error de Autenticación

```
LOGIN (WF-01)
  │
  ├─ Usuario/password incorrectos
  ▼
MOSTRAR ERROR
  │
  ├─ "❌ Credenciales inválidas"
  │ "Verifica usuario y contraseña"
  │
  └─ Usuario intenta nuevamente
```

---

# 4. Navegación por Gesto

### iOS/Android Común

```
Botón "Atrás" o Gesto de retroceso
  ├─ Retrocede una pantalla
  └─ Preserva estado (si aplica)

Swipe derecha
  ├─ En algunas apps = retroceso
  └─ Opcional (si se implementa)
```

### En Argüello Infancias Mobile

```
- Botón "Atrás" SIEMPRE presente (excepto Inicio)
- Gesto retroceso automático si OS lo soporta
- Atrás desde formularios = cancelar sin guardar
- Atrás desde confirmación = volver a editar
```

---

# 5. Estados de Navegación

### Estado 1: Autenticado

```
Puede acceder a:
- INICIO (WF-02)
- Todas las Features (F1-F6)
- Todos los flujos

No puede:
- Volver a LOGIN
- Acceder sin datos
```

### Estado 2: Sin autenticación

```
Puede acceder a:
- LOGIN (WF-01)

No puede:
- Ninguna otra pantalla
- Si intenta: redirect a LOGIN
```

### Estado 3: Sesión expirada

```
Usuario en cualquier pantalla
  │
  ├─ Sesión expira
  ▼
MOSTRAR MODAL
  │
  ├─ "Tu sesión expiró"
  ├─ Botón "Volver a iniciar sesión"
  │ ▼
  └─ LOGIN (WF-01)
```

---

# 6. Rutas de Navegación

## Ruta Principal (Educador nuevo)

```
LOGIN → INICIO → RESIDENTES → DETALLE NNA
```

## Ruta Diaria (Educador turno)

```
LOGIN → INICIO → MI TURNO [revisar novedades]
            ↓
        RESIDENTES [revisar NNA]
            ↓
        REGISTRAR NOVEDADES [documentar]
            ↓
        REGISTRAR ACTIVIDADES [documentar]
```

## Ruta de Emergencia

```
INICIO → SITUACIÓN CRÍTICA → ADVERTENCIA → REPORTE
```

## Ruta de Consulta

```
RESIDENTES → DETALLE → HISTORIAL → DETALLE REGISTRO
```

---

# 7. Consideraciones Técnicas

### Mantener Estado

- [ ] Formularios: si usuario retrocede, vuelve con datos ingresados
- [ ] Listas: si usuario va a detalle y vuelve, mantiene scroll/filtros
- [ ] Sesión: si usuario navega, mantiene autenticación

### Transiciones

- [ ] Transiciones smooth entre pantallas
- [ ] Animaciones rápidas (no ralentizar)
- [ ] Feedback de carga mientras se cargan datos

### Back Button (Android)

- [ ] Implementar manejador para back button nativo
- [ ] Igual comportamiento que botón "Atrás" UI
- [ ] Nunca cerrar app inesperadamente

---

# 8. Mapa de Navegación Completo

```
                    ┌─────────────┐
                    │   LOGIN     │
                    │   (WF-01)   │
                    └──────┬──────┘
                           │
                           ▼
                    ┌─────────────────────┐
                    │  INICIO/DASHBOARD   │
                    │  (WF-02)            │
                    └───────┬───────┬───┬─┘
                            │       │   │
        ┌───────────────────┘   ┌───┴───┐
        │                       │       │
        ▼                       ▼       ▼
   ┌─────────────┐   ┌─────────────┐  ┌─────────────┐
   │ RESIDENTES  │   │  MI TURNO   │  │   CRÍTICA   │
   │ (WF-03)     │   │  (WF-11)    │  │  (WF-13)    │
   └────┬────────┘   └──────┬──────┘  └──────┬──────┘
        │                   │                 │
        ▼                   ▼                 ▼
   ┌─────────────┐   ┌─────────────┐  ┌─────────────┐
   │  DETALLE    │   │DETALLE NV/  │  │ REGISTRAR   │
   │  RESIDENTE  │   │    TAREA    │  │  (WF-14)    │
   │  (WF-04)    │   │  (WF-12)    │  └─────┬───────┘
   └────┬────────┘   └──────┬──────┘        │
        │                   │               ▼
    ┌───┼───┬───┐      (vuelve a         ┌──────────┐
    │   │   │   │       WF-11)           │ CONFIRMAR│
    ▼   ▼   ▼   ▼                        │ (WF-15)  │
   NV  ACT  HIS INFO                     └──────────┘
  WF05 WF09 WF07 WF04
    │   │   │   │
    ▼   ▼   ▼   ▼
  CNF  CNF  DET  (leaf)
  WF06 WF10 WF08

Legend:
NV = Novedades (F2)
ACT = Actividades (F4)
HIS = Historial (F3)
INFO = Información (F1)
CNF = Confirmar (guardado)
DET = Detalle
```

---

# 9. Resumen: De Features a Flujos

| Feature | Flujo Principal | Wireframes | Acción |
|---------|---|---|---|
| F1 | Residentes → Detalle | WF-03, WF-04 | Lectura |
| F2 | Novedad → Confirmar | WF-05, WF-06 | Escritura |
| F3 | Historial → Detalle | WF-07, WF-08 | Lectura |
| F4 | Actividad → Guardar | WF-09, WF-10 | Escritura |
| F5 | Mi Turno → Detalle | WF-11, WF-12 | Lectura |
| F6 | Crítica → Confirmar | WF-13, WF-14, WF-15 | Escritura crítica |

---

**Los flujos garantizan que cada Feature sea accesible, clara y lógica para el educador durante su turno.**
