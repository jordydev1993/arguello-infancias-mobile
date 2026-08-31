# Arquitectura — Argüello Infancias Mobile

## 1. Objetivo

Definir la arquitectura técnica de la aplicación móvil Argüello Infancias Mobile y su relación con los servicios y datos del sistema de gestión de residencias.

## 2. Arquitectura general

La aplicación utilizará una arquitectura cliente-servidor:

```text
┌──────────────────────────────┐
│       📱 Arguello MÓVIL         │
│     React Native / Expo      │
└──────────────┬───────────────┘
               │
               │ HTTPS
               ▼
┌──────────────────────────────┐
│           SUPABASE           │
│                              │
│  ┌──────────┐  ┌──────────┐  │
│  │   Auth   │  │ Servicios│  │
│  └──────────┘  └────┬─────┘  │
└─────────────────────┼────────┘
                      │
                      ▼
             ┌────────────────┐
             │   PostgreSQL   │
             │   Base de      │
             │    datos       │
             └────────────────┘
```

## 3. Capa de presentación

### React Native / Expo

Será responsable de:

- Interfaz mobile.
- Navegación.
- Formularios.
- Listados.
- Visualización de información.
- Validaciones básicas de interacción.
- Manejo de estados de la aplicación.

La interfaz estará orientada principalmente al educador.

## 4. Autenticación

Se utilizará **Supabase Auth** para gestionar el acceso de los usuarios.

Flujo:

```text
Usuario
   │
   ▼
Login
   │
   ▼
Supabase Auth
   │
   ├── Credenciales válidas ──► Inicio
   │
   └── Credenciales inválidas ► Error
```

El usuario autenticado deberá acceder únicamente a las operaciones que correspondan a su rol y permisos.

## 5. Persistencia de datos

La persistencia estará basada en PostgreSQL mediante Supabase.

Entidades mínimas consideradas para el MVP:

```text
usuarios
   │
   ├──────────────┐
   │              │
   ▼              ▼
residentes      turnos
   │
   ├───────────────┐
   │               │
   ▼               ▼
novedades      actividades
   │
   ▼
situaciones_críticas
```

> El modelo definitivo de tablas y relaciones deberá validarse con el modelo de datos existente del sistema antes de implementarlo.

## 6. Módulos funcionales mobile

```text
Arguello MÓVIL
│
├── Autenticación
│
├── Inicio
│
├── Residentes
│   └── Detalle del residente
│
├── Novedades
│   ├── Registrar
│   └── Historial
│
├── Actividades
│   └── Registrar
│
├── Turno
│   └── Novedades y tareas
│
└── Situación crítica
    └── Registrar
```

## 7. Flujo principal

```text
LOGIN
  ↓
INICIO
  ↓
RESIDENTES
  ↓
SELECCIONAR NNA
  ↓
┌──────────────────────┐
│ Información          │
│ Novedades            │
│ Historial            │
│ Actividades          │
└──────────────────────┘
```

Desde Inicio también se podrá acceder a:

```text
INICIO
 ├── Novedades del turno
 ├── Tareas
 └── Situación crítica
```

## 8. Seguridad

La aplicación deberá contemplar:

- Autenticación de usuarios.
- Control de acceso según permisos.
- Protección de datos mediante conexión segura.
- Validación de datos antes de persistir.
- Políticas de acceso a datos en Supabase/PostgreSQL.
- No almacenar credenciales directamente en la aplicación.

## 9. Integración con el sistema existente

Argüello Infancias Mobile se plantea como complemento del sistema web de gestión de residencias.

Conceptualmente:

```text
                 SISTEMA DE RESIDENCIAS
                         │
             ┌───────────┴───────────┐
             │                       │
             ▼                       ▼
        🖥️ SISTEMA WEB          📱 Arguello MÓVIL
             │                       │
             └───────────┬───────────┘
                         ▼
                      SUPABASE
                         │
                         ▼
                     POSTGRESQL
```

La aplicación mobile no reemplaza al sistema web. Se concentra en las operaciones que tienen mayor utilidad para el personal que realiza tareas de acompañamiento durante el turno.

## 10. Repositorio y control de versiones

El proyecto deberá mantenerse bajo control de versiones mediante Git/GitHub.

Se recomienda:

```text
main
 │
 ├── develop
 │
 ├── feature/login
 ├── feature/residentes
 ├── feature/novedades
 ├── feature/actividades
 ├── feature/historial
 └── feature/situacion-critica
```

Las Features deberán integrarse progresivamente y probarse antes de considerarlas terminadas.

## 11. Principios de arquitectura

- Separación entre interfaz, lógica y acceso a datos.
- Reutilización de componentes.
- Desarrollo incremental.
- Validación de entradas.
- Mínimo acoplamiento entre componentes.
- Reutilización de la información existente del sistema.
- Trazabilidad de las operaciones relevantes.

## 12. Estado inicial

Esta arquitectura corresponde a la planificación del MVP. Los detalles técnicos podrán ajustarse durante la implementación en función de los contenidos trabajados en la materia y de las decisiones del equipo.
