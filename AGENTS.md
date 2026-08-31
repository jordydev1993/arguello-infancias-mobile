# AGENTS.md — Argüello Infancias Mobile

**El único archivo de reglas que necesitas. Leeré esto antes de cada tarea.**

---

## [1] ROL + FLUJO DE TRABAJO

Eres ingeniero principal con 10+ años en arquitectura de apps.

**Para cada funcionalidad que te pida, hazlo así (sin excepción):**

1. **Lee las reglas:** Este archivo (AGENTS.md) + la skill relevante en `skills/` (`design.md`, `testing.md`, `database.md`). Documentación del proyecto: `docs/00-INDICE.md`.
2. **Inspecciona:** El código actual en `src/`
3. **Escribe un PLAN:** Guárdalo en `prompts/XX-nombre-plan.md`
   - Qué archivos modificas/creas
   - Qué APIs llamas
   - Qué datos trae la BD
   - Cómo cumples los criterios
   - Qué chequeos corres después
4. **Espera aprobación:** Yo digo "✓ Aprobado" o "✕ Cambiar X"
5. **Implementa:** Escribe el código del plan
6. **Chequea:** Corre TODOS los chequeos (typecheck, lint, tests)
7. **Reporta:** "Pasos exactos para probar esto"

**No saltees el PLAN. Nunca.**

---

## [2] PRODUCTO: DENTRO / FUERA DE ALCANCE

**Qué es:**  
Sistema móvil para acompañamiento diario de NNA en residencias bajo protección judicial. 6 funcionalidades core, MVP en 2-3 semanas.

**Dentro de alcance:**
- ✅ F1: Consultar información de residentes asignados
- ✅ F2: Registrar novedades (incidencias diarias)
- ✅ F3: Consultar historial de seguimiento
- ✅ F4: Registrar actividades diarias
- ✅ F5: Consultar turno y tareas de hoy
- ✅ F6: Reportar situación crítica (emergencias)

**Fuera de alcance (NO sobreconstruir):**
- ❌ Comentarios o réplicas en novedades
- ❌ Multimedia (video, audio) — solo foto estática
- ❌ Notificaciones push (v2)
- ❌ Modo offline con sync automático (v2)
- ❌ Compartir en redes sociales
- ❌ Gamificación o puntos
- ❌ Video llamadas (v2)
- ❌ Generación de reportes PDF/Excel (v2)

---

## [3] ARQUITECTURA

```
┌─────────────────────────────────────────────────┐
│                                                 │
│  EXPO / REACT NATIVE (Cliente móvil)           │
│  - Pantallas (app/(tabs)/, app/(auth)/)        │
│  - Componentes reutilizables                    │
│  - Estado Zustand                               │
│  - Supabase Client (JWT automático)            │
│                                                 │
└────────────────────┬────────────────────────────┘
                     │ HTTP fetch
                     ↓
┌─────────────────────────────────────────────────┐
│                                                 │
│  EXPRESS.JS SERVERLESS (API)                   │
│  - Routes: POST/GET /api/*                     │
│  - Valida JWT (Supabase)                       │
│  - RBAC: educador vs coordinador               │
│  - Queries preparadas (sin inyección SQL)      │
│                                                 │
└────────────────────┬────────────────────────────┘
                     │ SQL prepared
                     ↓
┌─────────────────────────────────────────────────┐
│                                                 │
│  SUPABASE POSTGRESQL (Datos)                   │
│  - 7 tablas (residentes, novedades, ...)       │
│  - RLS policies por rol                         │
│  - Audit log centralizado                      │
│  - Triggers automáticos                        │
│                                                 │
└─────────────────────────────────────────────────┘
```

**Reglas arquitectura:**
- 🔒 Secretos NUNCA en cliente (Expo)
- 🔒 Tokens JWT en Expo SecureStore
- 🔒 Validación de entrada en servidor, no en cliente
- 🔒 RBAC: RLS policies en BD, no en API
- 🔒 Audit log: TODOS los cambios en novedades/criticas

---

## [4] STACK TÉCNICO + PROHIBICIONES

**USAR SIEMPRE:**

Frontend Mobile:
- `Expo 50+` (managed service, no bare workflow)
- `React Native` con TypeScript (modo strict)
- `Expo Router` para navegación (no React Navigation)
- `NativeWind 2.x` + Tailwind CSS 3.x (no StyleSheet)
- `Zustand` para estado global (no Redux, no Context)
- `@supabase/supabase-js` para auth + DB
- `Poppins` font (descargada en assets/)

Backend Compartido:
- `Node.js 20+` runtime
- `Express.js` (no Next.js, no Fastify)
- `TypeScript` (modo strict)
- `Supabase PostgreSQL 15+` (no otra DB)
- `JWT + TOTP` para auth (Supabase auth)
- `zod` para validación
- `winston` para logs

**NO USAR NUNCA:**
- ❌ Redux (usar Zustand)
- ❌ Context API (usar Zustand)
- ❌ Clerk, Firebase Auth (solo Supabase)
- ❌ Axios (solo fetch)
- ❌ GraphQL (solo REST)
- ❌ React Query (estado local → Zustand)
- ❌ react-hook-form (formularios simples, no lib)
- ❌ Tailwind UI (usar design tokens propios)

---

## [5] MODELO DE DATOS

**7 tablas. Todas son obligatorias para MVP.**

**Lee: `skills/database.md`** para la validación completa: restricciones `CHECK`, índices, RLS por rol y audit log. Material de trabajo del modelado en `docs/04-backend/modelo-de-datos/`.

### Tabla: perfiles_usuarios

```
id          UUID (PK → auth.users.id) ON DELETE RESTRICT
nombre      VARCHAR(255) NOT NULL
rol         VARCHAR(50) CHECK (rol IN ('educador', 'coordinador'))
created_at  TIMESTAMPTZ DEFAULT NOW()
```

Regla: Un educador solo ve residentes asignados via residentes_turnos.

---

### Tabla: residentes

```
id                      UUID (PK)
nombre                  VARCHAR(255) NOT NULL
foto_url                TEXT NULL (almacenado en Supabase Storage)
fecha_nacimiento        DATE NOT NULL
escuela                 VARCHAR(255) NULL
turno_escolar           VARCHAR(50) CHECK (turno_escolar IN ('Mañana', 'Tarde', 'Noche', 'Doble Jornada'))
observaciones_autorizadas TEXT NULL
alertas_importantes     TEXT NULL (ej: alergias, medicación)
created_at              TIMESTAMPTZ DEFAULT NOW()
deleted_at              TIMESTAMPTZ NULL (soft delete)
```

Regla: Nunca eliminar residente físicamente (soft delete via deleted_at).

---

### Tabla: turnos_trabajo

```
id          UUID (PK)
nombre      VARCHAR(100) CHECK (nombre IN ('Mañana', 'Tarde', 'Noche'))
hora_inicio TIME NOT NULL
hora_fin    TIME NOT NULL
created_at  TIMESTAMPTZ DEFAULT NOW()
```

Regla: Solo 3 turnos. Inmutable después de MVP.

---

### Tabla: residentes_turnos

```
residente_id UUID (FK → residentes.id) ON DELETE CASCADE
turno_id     UUID (FK → turnos_trabajo.id) ON DELETE CASCADE
PK: (residente_id, turno_id)
```

Regla: Un residente puede estar en 1+ turnos. Un turno tiene N residentes.

---

### Tabla: novedades

```
id              UUID (PK)
residente_id    UUID (FK → residentes.id) NOT NULL ON DELETE CASCADE
usuario_id      UUID (FK → perfiles_usuarios.id) NOT NULL ON DELETE RESTRICT
tipo_novedad    VARCHAR(100) CHECK (tipo_novedad IN ('Salud', 'Educación', 'Comportamiento', 'Alimentación', 'Visita Familiar', 'Otro'))
descripcion     TEXT NOT NULL (nunca vacío)
fecha_hora      TIMESTAMPTZ DEFAULT NOW()
deleted_at      TIMESTAMPTZ NULL (soft delete)
created_at      TIMESTAMPTZ DEFAULT NOW()
```

**Índices:**
- `idx_novedades_residente_fecha (residente_id, fecha_hora DESC)`
- `idx_novedades_usuario (usuario_id)`

Regla crítica: Nunca guardar novedad sin descripcion. SEMPRE with timestamp.

---

### Tabla: actividades_diarias

```
id              UUID (PK)
residente_id    UUID (FK → residentes.id) NOT NULL ON DELETE CASCADE
tipo_actividad  VARCHAR(100) CHECK (tipo_actividad IN ('Colegio', 'Recreativa', 'Deportiva', 'Taller', 'Turno Médico', 'Otra'))
descripcion     TEXT NULL
realizada       BOOLEAN DEFAULT FALSE
fecha           DATE DEFAULT CURRENT_DATE
usuario_id      UUID (FK → perfiles_usuarios.id) NULL ON DELETE SET NULL
deleted_at      TIMESTAMPTZ NULL (soft delete)
created_at      TIMESTAMPTZ DEFAULT NOW()
```

**Índices:**
- `idx_actividades_residente_fecha (residente_id, fecha DESC)`

Regla: Una actividad está pendiente o realizada. Sin estados intermedios.

---

### Tabla: situaciones_criticas

```
id              UUID (PK)
residente_id    UUID (FK → residentes.id) NOT NULL ON DELETE RESTRICT
usuario_id      UUID (FK → perfiles_usuarios.id) NOT NULL ON DELETE RESTRICT
tipo_situacion  VARCHAR(100) CHECK (tipo_situacion IN ('Violencia', 'Crisis Emocional', 'Accidente', 'Fuga', 'Emergencia Sanitaria'))
descripcion     TEXT NOT NULL
fecha_hora      TIMESTAMPTZ DEFAULT NOW()
created_at      TIMESTAMPTZ DEFAULT NOW()
```

**Índices:**
- `idx_criticas_residente_fecha (residente_id, fecha_hora DESC)`

Regla crítica: Auditoría obligatoria (nunca borrar). Timestamp automático.

---

### Tabla: audit_log

```
id              UUID (PK)
tabla_nombre    VARCHAR(100) NOT NULL
registro_id     UUID NOT NULL
operacion       VARCHAR(20) CHECK (operacion IN ('CREATE', 'UPDATE', 'DELETE'))
usuario_id      UUID (FK → perfiles_usuarios.id) ON DELETE RESTRICT
datos_antes     JSONB NULL
datos_despues   JSONB NULL
fecha_hora      TIMESTAMPTZ DEFAULT NOW()
```

**Índices:**
- `idx_audit_tabla_fecha (tabla_nombre, fecha_hora DESC)`
- `idx_audit_usuario (usuario_id)`

Regla: Triggers automáticos en novedades, criticas, actividades, residentes.

---

## [6] CONTRATOS DE API

**Base URL:** `https://[supabase-project].functions.supabase.co/api` (serverless)

---

### GET /api/residentes

**Input:**
```json
{
  "assigned_to_me": true,      // opcional: true = solo asignados al educador
  "limit": 50,                  // opcional: default 20
  "offset": 0                   // opcional: para paginación
}
```

**Output (200):**
```json
{
  "residentes": [
    {
      "id": "uuid",
      "nombre": "María García",
      "edad": 12,                        // calculado de fecha_nacimiento
      "foto_url": "https://...",
      "alertas_importantes": "Alérgica a..."
    }
  ],
  "total": 42
}
```

**Errors:**
- `401 Unauthorized` - sin JWT
- `403 Forbidden` - educador pide residentes no asignados

---

### POST /api/novedades

**Input:**
```json
{
  "residente_id": "uuid",
  "tipo_novedad": "Salud",       // uno de: Salud, Educación, Comportamiento, Alimentación, Visita Familiar, Otro
  "descripcion": "Se cayó en el patio"
}
```

**Output (201):**
```json
{
  "id": "uuid",
  "fecha_hora": "2026-08-31T14:30:00Z",
  "usuario_id": "uuid"           // el del JWT
}
```

**Errors:**
- `400 Bad Request` - descripcion vacía
- `401 Unauthorized` - sin JWT
- `403 Forbidden` - no tiene permiso registrar para ese residente

---

### GET /api/residentes/:id/timeline

**Input:**
```
?days=30     // últimos 30 días (default)
```

**Output (200):**
```json
{
  "residentes_id": "uuid",
  "timeline": [
    {
      "id": "uuid",
      "tipo": "Salud",
      "descripcion": "Se cayó",
      "fecha_hora": "2026-08-31T14:30:00Z",
      "registrado_por": "Jordy García"
    }
  ]
}
```

---

### POST /api/actividades

**Input:**
```json
{
  "residente_id": "uuid",
  "tipo_actividad": "Colegio",   // uno de: Colegio, Recreativa, Deportiva, Taller, Turno Médico, Otra
  "descripcion": "Matemáticas"   // opcional
}
```

**Output (201):**
```json
{
  "id": "uuid",
  "realizada": false,
  "fecha": "2026-08-31"
}
```

---

### PATCH /api/actividades/:id

**Input:**
```json
{
  "realizada": true             // marcar como hecha
}
```

**Output (200):** La actividad actualizada

---

### GET /api/my-shift

**Output (200):**
```json
{
  "turno": {
    "nombre": "Mañana",
    "hora_inicio": "06:00",
    "hora_fin": "14:00"
  },
  "residentes_asignados": [...],
  "novedades_24h": [...],
  "actividades_pendientes": [...]
}
```

---

### POST /api/situaciones-criticas

**Input:**
```json
{
  "residente_id": "uuid",
  "tipo_situacion": "Violencia",  // uno de: Violencia, Crisis Emocional, Accidente, Fuga, Emergencia Sanitaria
  "descripcion": "Peleó con otro residente"
}
```

**Output (201):**
```json
{
  "id": "uuid",
  "fecha_hora": "2026-08-31T14:30:00Z",
  "usuario_id": "uuid"
}
```

**Importante:** Se registra en audit_log automáticamente.

---

## [7] CHEQUEOS OBLIGATORIOS (Después de CADA implementación)

Antes de reportar "listo", corre TODOS estos:

```bash
# Typecheck
npm run typecheck           # ✓ sin errores

# Linting
npm run lint                # ✓ sin warnings

# Compilación
npx expo build              # ✓ sin errores

# En Expo Go:
expo start
  ✓ Abre la app
  ✓ Navego entre tabs
  ✓ Datos llegan de BD
  ✓ Guardé algo, lo veo reflejado

# BD:
SELECT COUNT(*) FROM [tabla];     # ✓ datos insertados
SELECT * FROM audit_log WHERE tabla_nombre = '[tabla]' ORDER BY fecha_hora DESC LIMIT 5;
                                  # ✓ auditoría registra cambios
```

**No reportes "listo" hasta que TODO pase.**

---

## [8] DISEÑO + COMPONENTES

**Lee: `skills/design.md` para:**
- Colores (Argüello theme: azul + púrpura)
- Tipografía Poppins (11px a 32px)
- Espaciado scale (4px a 48px)
- Componentes reutilizables (PrimaryButton, ResidentCard, etc)
- WCAG AA compliance

---

## [9] CRITERIOS DE ACEPTACIÓN

**Lee: `skills/testing.md` para:**
- F1: 7 criterios de aceptación (CA-01 a CA-07)
- F2: 10 criterios (CA-08 a CA-17)
- F3: 7 criterios (CA-18 a CA-24)
- F4: 8 criterios (CA-25 a CA-32)
- F5: 8 criterios (CA-33 a CA-40)
- F6: 11 criterios (CA-41 a CA-51)

Cada Feature pasa TODOS sus criterios antes de dar por finalizado.

---

## [10] HISTORIAS DE USUARIO

**Las reglas que gobiernan el comportamiento:**

- **RBAC:** Educador solo ve residentes asignados. Coordinador ve todo.
- **Auditoría:** Todos los cambios en novedades/criticas quedan registrados. Nunca borrar.
- **Timestamps:** Cada novedad/crítica lleva timestamp automático (cuando la IA lo registró).
- **Soft deletes:** Residentes/novedades nunca se borran, se marcan como deleted_at.
- **Validación:** servidor es la fuente de verdad (no confiar en el cliente).
- **Offline:** v1 no soporta. Siempre hay conectividad.
- **Seguridad:** Secrets en .env del servidor. Jamás en Expo.

---

## RESUMEN ULTRA-CORTO (Pegalo en tu prompt diario)

```
Eres ingeniero principal. Para cada Feature:

1. Lee AGENTS.md (este archivo)
2. Lee skills/ relevantes
3. Escribe PLAN en prompts/XX-nombre-plan.md
4. Espera aprobación (yo digo ✓)
5. Implementa
6. Corre chequeos (typecheck, lint, expo start)
7. Reporta: "Pasos exactos para probar"

No saltees el PLAN. Nunca.
```

---

**Fecha:** 31 de Agosto 2026  
**Versión:** 1.0  
**Alineado con:** Vibe Engineering + SDD

