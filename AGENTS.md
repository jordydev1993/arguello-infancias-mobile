# AGENTS-MOBILE.md — Argüello Infancias Mobile (Unificado)

**Aplicación móvil para el acompañamiento diario de NNA en residencias bajo protección judicial.**

> Lee primero **AGENTS.md** para entender el contexto general, principios de seguridad y procesos compartidos.

---

## 📌 PROYECTO GENERAL

**Argüello Infancias Mobile** es parte del **Sistema de Gestión para Residencia de NNA "Argüello Infancias"**, desarrollado como Trabajo Final/Tesis en el marco de **Aplicación Móvil mediante Aprendizaje Basado en Proyectos (ABP)**.

La aplicación móvil es **complemento** del sistema web institucional, NO reemplaza.

---

## 🎯 OBJETIVO GENERAL

Construir una **aplicación móvil funcional e incremental** que digitalice el **acompañamiento diario de NNA en la residencia**.

La aplicación debe permitir que educadores y operadores convivenciales:

✅ Consultar información de residentes  
✅ Registrar novedades durante el turno  
✅ Consultar historial de seguimiento  
✅ Registrar actividades diarias  
✅ Consultar novedades y tareas del turno  
✅ Reportar situaciones críticas  

**Priorizando:** Simplicidad, Usabilidad, Trazabilidad, Seguridad, Claridad, Integración, Desarrollo Incremental

---

## 📱 PROPÓSITO MÓVIL vs WEB

### Argüello Infancias Web (Sistema Principal)

```
Usuarios: Dirección, Técnicos, Psicología, Trabajo Social, Admin
Responsabilidades: Gestión completa, legajos, informes, auditoría, decisiones institucionales
```

### Argüello Infancias Mobile (Complemento)

```
Usuarios: Educadores, Operadores convivenciales
Responsabilidades: Acompañamiento diario, registro de actividades, novedades, turno
```

### Arquitectura General

```
                 SISTEMA DE RESIDENCIA
                         │
              ┌──────────┴──────────┐
              │                     │
         SISTEMA WEB           ARGÜELLO INFANCIAS MOBILE
              │                     │
       Gestión institucional    Trabajo diario
              │                     │
              └──────────┬──────────┘
                         │
            SUPABASE (PostgreSQL)
           - Datos compartidos
           - Auditoría única
           - RLS policies
```

---

## 🛠️ STACK TÉCNICO MÓVIL

### Frontend Mobile

```
- Expo (managed service)
- React Native + TypeScript (strict mode)
- Expo Router (file-based routing)
- NativeWind (Tailwind CSS en React Native)
- Zustand (estado global)
- React Query (data fetching + cache)
- AsyncStorage (persistencia local)
- Supabase Client (auth + realtime)
```

### Shared Backend (Común con Web)

```
- Node.js 20+ + Express.js + TypeScript
- PostgreSQL 15+ (Supabase managed)
- Passport.js + JWT + TOTP (MFA)
- crypto-js (AES-256 encryption)
- zod (validación lado servidor)
- winston (logging)
```

### Seguridad Mobile-Specific

```
- Expo SecureStore (almacenar JWT)
- No guardar datos sensibles en AsyncStorage
- Descartar tokens al logout
- Timeout sesión: 30 min inactividad
- Certificate pinning (si aplica)
```

---

## 🏗️ ARQUITECTURA MOBILE

```
┌─────────────────────────────────────┐
│    DISPOSITIVO MÓVIL (Cliente)      │
│  React Native + Expo + TypeScript    │
│  - UI nativa (iOS + Android)        │
│  - Datos temporales en memoria      │
│  - AsyncStorage para cache local    │
│  - NO datos sensibles en disco      │
└──────────────┬──────────────────────┘
               │ HTTPS + JWT + MFA
               ▼
         (Mismo Backend que Web)
     ┌──────────────────────────────┐
     │  NODE.JS + EXPRESS           │
     │  - Validación (Zod)          │
     │  - Auditoría                 │
     │  - Cifrado/Descifrado        │
     │  - RBAC middleware           │
     └──────────────────────────────┘
               │
               ▼
     ┌──────────────────────────────┐
     │  PostgreSQL (Supabase)       │
     │  - Datos compartidos          │
     │  - Audit log inmutable        │
     │  - RLS policies              │
     └──────────────────────────────┘
```

---

## 📊 DATOS DISPONIBLES EN MOBILE

Mobile accede a **lectura/escritura limitada** de:

```
✅ Información de residentes (lectura)
   - Nombres, edad, foto, datos básicos
   - NO: DNI, salud complejos (web)

✅ Tareas diarias (lectura/escritura)
   - Ver tareas → Completar tarea

✅ Observaciones/Novedades (lectura/escritura)
   - Registrar novedad
   - Ver historial (últimos 30 días)

✅ Actividades diarias (lectura/escritura)
   - Registrar tipo, estado, observaciones

✅ Medicación (lectura/escritura limitada)
   - Ver medicamentos activos
   - Registrar administración
   - NO: modificar medicamentos

✅ Información del turno (lectura)
   - Tareas pendientes, novedades 24h, alertas

✅ Situaciones críticas (lectura/escritura)
   - Reportar situación
   - Ver estado de reportes

❌ Auditoría (no acceso en mobile)
❌ Reportes institucionales (web only)
❌ Crear/modificar usuarios (web/admin)
```

---

# 6️⃣ LAS 6 FEATURES

## Feature 1 — Consultar información de residentes

**Objetivo:** Acceder rápidamente a datos básicos de NNA asignados.

**Flujo:**
```
Inicio → Residentes → Seleccionar NNA → Detalle
```

**Datos visualizados:**
- Nombre, edad, foto
- Datos de contacto emergencia
- Estado actual
- Obra social

**Validación:** Solo NNA asignados al educador (RBAC)

**Wireframes:** WF-03 (listado), WF-04 (detalle)  
**Criterios:** CA-01 a CA-07 (7 criterios)

---

## Feature 2 — Registrar novedades del turno

**Objetivo:** Crear registro inmediato de eventos/cambios durante turno.

**Flujo:**
```
Residentes → NNA → Nueva novedad → Registrar → Confirmar
```

**Datos requeridos:**
- NNA (seleccionado)
- Tipo (desplegable: conducta, emocional, educativo, sanitario, otro)
- Descripción (textarea, min 10 caracteres)
- Fecha/hora (automática)
- Usuario responsable (automático)

**Validación:**
- Tipo obligatorio
- Descripción mínimo 10 caracteres
- NNA válido

**Importante:** Una vez registrada, NO se puede editar (trazabilidad)

**Wireframes:** WF-05 (registro), WF-06 (confirmación)  
**Criterios:** CA-08 a CA-17 (10 criterios)

---

## Feature 3 — Consultar historial de seguimiento

**Objetivo:** Ver registros cronológicos de un NNA.

**Flujo:**
```
Residentes → NNA → Historial → Lista ordenada
```

**Datos mostrados:**
- Fecha/hora
- Tipo de registro
- Descripción
- Usuario responsable
- Estado

**Orden:** Descendente (más recientes primero)  
**Diferenciación:** Separadores entre días diferentes

**Wireframes:** WF-07 (lista), WF-08 (detalle)  
**Criterios:** CA-18 a CA-24 (7 criterios)

---

## Feature 4 — Registrar actividades diarias

**Objetivo:** Documentar actividades completadas/pendientes durante turno.

**Flujo:**
```
Residentes → NNA → Actividades → Registrar/Actualizar → Guardar
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
- Actividad (tipo)
- Estado
- Observaciones (opcional)
- Duración (opcional)
- Participantes (opcional)
- Fecha/hora (automática)

**Wireframes:** WF-09 (lista), WF-10 (registro)  
**Criterios:** CA-25 a CA-32 (8 criterios)

---

## Feature 5 — Consultar novedades y tareas del turno

**Objetivo:** Visión consolidada del turno (qué pasó, qué hay que hacer, qué alertas).

**Flujo:**
```
Inicio → Mi turno → Ver secciones consolidadas
```

**Secciones:**

1. **Turno Actual**
   - Horario inicio/fin
   - Educador responsable
   - NNA a cargo

2. **Novedades Relevantes**
   - Últimas 24h
   - Alertas
   - Cambios de estado

3. **Tareas Pendientes**
   - Medicación
   - Turnos médicos
   - Actividades programadas

4. **Información Turno Anterior**
   - Resumen novedades
   - Situaciones pendientes
   - Recomendaciones

**Wireframes:** WF-11 (turno), WF-12 (detalle elemento)  
**Criterios:** CA-33 a CA-40 (8 criterios)

---

## Feature 6 — Reportar situación crítica

**Objetivo:** Registro diferenciado de situaciones que requieren atención especial.

**Flujo:**
```
Inicio → Situación Crítica → Advertencia → Formulario → Confirmar
```

**Tipos de situaciones críticas:**
- Violencia (entre residentes, auto-lesiones)
- Crisis emocional
- Accidente
- Fuga
- Emergencia sanitaria
- Otra

**Datos requeridos:**
- NNA involucrado(s)
- Tipo de situación
- Descripción detallada (mínimo 20 caracteres)
- Acciones tomadas
- Personas notificadas

**Validación:**
- Tipo obligatorio
- Descripción mínimo 20 caracteres
- Confirmación previa a guardar

**Diferenciación Visual:**
- Color: Rojo (#DC3545)
- Ícono: ⚠️
- Acceso prominente desde Inicio
- Advertencia previa (confirmación)

**Wireframes:** WF-13 (advertencia), WF-14 (registro), WF-15 (confirmación)  
**Criterios:** CA-41 a CA-51 (11 criterios)

---

## 📋 Resumen de Features

| ID | Feature | Objetivo | Lectura | Escritura | Actor |
|---|---|---|---|---|---|
| F1 | Consultar residentes | Ver datos NNA | ✅ | ❌ | Educador |
| F2 | Registrar novedades | Documentar eventos | ❌ | ✅ | Educador |
| F3 | Consultar historial | Ver seguimiento | ✅ | ❌ | Educador |
| F4 | Registrar actividades | Documentar actividades | ✅ | ✅ | Educador |
| F5 | Consultar turno | Resumen operativo | ✅ | ❌ | Educador |
| F6 | Situación crítica | Registrar emergencias | ❌ | ✅ | Educador |

---

# 🏗️ ESTRUCTURA DEL PROYECTO

```
arguello-infancias-mobile/
├── app/
│   ├── (auth)/
│   │   ├── login.tsx
│   │   └── _layout.tsx
│   ├── (tabs)/
│   │   ├── _layout.tsx
│   │   ├── inicio.tsx
│   │   ├── residentes.tsx
│   │   ├── turno.tsx
│   │   └── critica.tsx
│   ├── residentes/
│   │   ├── [id].tsx
│   │   └── [id]/
│   │       ├── novedades.tsx
│   │       ├── historial.tsx
│   │       └── actividades.tsx
│   └── _layout.tsx
├── components/
│   ├── ResidentCard.tsx
│   ├── ActivityCard.tsx
│   ├── AlertCard.tsx
│   ├── buttons/
│   │   ├── PrimaryButton.tsx
│   │   ├── SecondaryButton.tsx
│   │   └── CriticalButton.tsx
│   └── common/
│       ├── LoadingState.tsx
│       ├── EmptyState.tsx
│       └── ErrorState.tsx
├── hooks/
│   ├── useAuth.ts
│   ├── useResidents.ts
│   ├── useActivities.ts
│   ├── useObservations.ts
│   └── useShiftInfo.ts
├── lib/
│   ├── supabase.ts
│   ├── api.ts
│   ├── auth.ts
│   ├── storage.ts
│   └── validation.ts
├── store/
│   ├── authStore.ts
│   ├── residentStore.ts
│   ├── uiStore.ts
│   └── offlineStore.ts
├── types/
│   ├── resident.ts
│   ├── activity.ts
│   ├── observation.ts
│   ├── task.ts
│   └── user.ts
├── utils/
│   ├── formatters.ts
│   ├── validators.ts
│   └── constants.ts
├── app.json
├── package.json
├── tsconfig.json
└── eas.json
```

---

# 🔐 SEGURIDAD MOBILE-SPECIFIC

### Obligatorios

- ✅ **Autenticación:** JWT + MFA (TOTP)
- ✅ **Almacenamiento seguro:** SecureStore para tokens (NO AsyncStorage)
- ✅ **Cifrado:** AES-256 para datos sensibles
- ✅ **HTTPS:** Siempre en producción
- ✅ **Rate limiting:** 5 intentos fallidos → esperar 5 min
- ✅ **RBAC:** Educador ve SOLO NNA asignados
- ✅ **Timeouts:** 30 min inactividad
- ✅ **Auditoría:** Toda acción registrada

### Nunca Exponer

- ❌ DATABASE_URL
- ❌ JWT_SECRET
- ❌ ENCRYPTION_KEY
- ❌ Tokens en localStorage
- ❌ Contraseñas en logs

### Offline & Sync

```
Usuario sin conexión:
1. Registra novedad localmente (AsyncStorage)
2. UI muestra "✓ Guardado (offline)"
3. Cuando vuelve conexión:
   → Auto-retry POST /api/minors/:id/observations
   → Sincroniza datos
   → Muestra "✓ Sincronizado"
```

---

# 📡 ENDPOINTS API (Compartidos con Web)

Mobile usa **mismos endpoints que web**, pero con RBAC:

```
GET /api/minors?filter=assigned_to_me
  - Solo residentes asignados al educador
  - Filtro automático por JWT

POST /api/minors/:id/observations
  - Educador crea observaciones
  - Auditoría registra

PATCH /api/tasks/:id
  - Educador actualiza status (no reasigna)

GET /api/minors/:id/medications?active=true
  - Lectura solamente

POST /api/minors/:id/critical-incidents
  - Crear reporte crítico
  - Auditoría inmediata
```

---

# 🧪 TESTING

### Tipos de Tests

- **Unit:** Validadores Zod, formatters (Jest)
- **Integration:** API calls + BD mock (Jest + Supertest)
- **E2E:** Flujos usuario (Detox o Maestro)

### Casos Críticos

- [ ] Login + MFA en mobile
- [ ] Offline → registrar → online → sync
- [ ] Ver SOLO residentes asignados
- [ ] Rate limiting funciona
- [ ] Logout limpia todo

### Coverage de Criterios

Cada criterio CA-01 a CA-51 debe tener un test asociado.

---

# 📱 COMPONENTES REUTILIZABLES

### ResidentCard
- Foto, nombre, edad, estado
- Clickeable → detalle

### ActivityCard
- Icono tipo, hora, descripción
- Badge estado

### AlertCard
- Fondo rojo/naranja según severidad
- Mensaje + acción

### Buttons
- **PrimaryButton:** Acciones principales (verde/azul)
- **SecondaryButton:** Alternativas (gris)
- **CriticalButton:** Situaciones críticas (rojo)

### Loading/Empty/Error
- LoadingState: Spinner + "Cargando..."
- EmptyState: Icono + "No hay datos"
- ErrorState: ⚠️ + mensaje + Reintentar

---

# 🔄 FLUJOS PRINCIPALES

## F1 — Consultar Residentes

```
INICIO
  ├─ Click "Residentes"
  ▼
LISTADO (WF-03)
  ├─ Click residente
  ▼
DETALLE (WF-04)
  └─ Click "Atrás" → LISTADO
```

## F2 — Registrar Novedad

```
DETALLE RESIDENTE
  ├─ Click "Nueva novedad"
  ▼
REGISTRO (WF-05)
  ├─ Completa datos
  ├─ Valida
  ▼
CONFIRMAR (WF-06)
  ├─ Click "Confirmar"
  ▼
GUARDAR + Vuelve a DETALLE
```

## F6 — Situación Crítica

```
INICIO
  ├─ Click "⚠️ SITUACIÓN CRÍTICA"
  ▼
ADVERTENCIA (WF-13)
  ├─ Mensaje confirmación
  ├─ Click "Continuar"
  ▼
REGISTRO (WF-14)
  ├─ Completa datos
  ▼
CONFIRMAR (WF-15)
  ├─ Click "CONFIRMAR REPORTE" (rojo)
  ▼
GUARDAR + Vuelve a INICIO
```

---

# 🎯 PRINCIPIOS DE DESARROLLO

## No Pantallas, Sino Features

❌ INCORRECTO: "Pantalla de residentes", "Pantalla de novedades"  
✅ CORRECTO: "Consultar residentes", "Registrar novedades"

Cada Feature = Una capacidad real del usuario.

## Desarrollo Incremental

Orden recomendado:

1. **F1** — Consultar residentes (fundacional)
2. **F2** — Registrar novedades (core)
3. **F3** — Consultar historial (lectura)
4. **F4** — Registrar actividades (escritura)
5. **F5** — Consultar turno (síntesis)
6. **F6** — Situación crítica (especial)

## Feature Definition of Done

Una Feature está **HECHA** cuando:

- [ ] Objetivo claramente definido
- [ ] Está implementada
- [ ] Puede ejecutarse desde mobile
- [ ] Guarda/consulta datos correctamente
- [ ] Respeta permisos (RBAC)
- [ ] Manejo de errores completo
- [ ] Fue testeada (manual + automatizado)
- [ ] No rompe Features anteriores
- [ ] Está documentada
- [ ] Estado actualizado en README.md

## No Sobreingeniería

```
❌ NO agregar: Chat, videollamadas, geolocalización
❌ NO agregar: Evaluaciones complejas
❌ NO agregar: Sincronización tiempo real
✅ Mantener: Simple, enfocado, seguro
```

---

# 🚀 DEVELOPMENT WORKFLOW (Vibe Engineering)

### Para cada Feature:

1. **Lee esta AGENTS-MOBILE.md** (contexto general)
2. **Lee AGENTS.md** (principios compartidos)
3. **Identifica la Feature** (qué hace, para quién, por qué)
4. **Define el flujo** (pasos, datos, validaciones)
5. **Escribe un prompt** en `prompts/<nombre>.md`
6. **Obtén aprobación** ("¿Implemento?")
7. **Implementa** (código + tests + documentación)
8. **Valida** (funciona, no rompe lo anterior)

---

# ⚠️ REGLAS NO NEGOCIABLES

1. **Seguridad > Velocidad** (siempre)
2. **Datos sensibles = Cifrados** (AES-256)
3. **Auditoría de todo** (user, timestamp, IP, acción)
4. **RBAC estricto** (educador ve SOLO sus NNA)
5. **No inventar reglas** (preguntar si hay duda)
6. **Código claro** (otros van a leerlo)
7. **Tests siempre** (criterios CA-01 a CA-51)
8. **Documentar cambios** (README, tipos, prompts)

---

# 📝 GIT & COMMITS

### Commits Pequeños y Descriptivos

✅ `feat: agregar consulta de residentes`  
✅ `feat: registrar novedades con validación`  
✅ `fix: corregir validación de formulario`  
✅ `docs: actualizar README`  

❌ `cambios`  
❌ `final`  
❌ `cosas`  

### No Modificar Archivos No Relacionados

Si trabajas en F1, no toques F2.

---

# 📞 REFERENCIAS

| Documento | Cuándo Leer | Contenido |
|-----------|-----------|----------|
| **AGENTS.md** | Siempre | Contexto general, seguridad, procesos |
| **AGENTS-MOBILE.md** (este) | Desarrollo mobile | Features, stack, flujos mobile |
| **03-ARGUELLO-MOBILE-FEATURES.md** | Detalle de Features | Descripción extendida |
| **04-CRITERIOS-ACEPTACION.md** | Testing | 51 criterios verificables |
| **05-WIREFRAMES.md** | Diseño UI | 15 wireframes especificados |
| **06-FLUJOS-NAVEGACION.md** | Navegación | Flujos entre pantallas |
| **BRIEF-CLAUDE-CODE.md** | Setup inicial | Cómo empezar proyecto |

---

# ✅ CHECKLIST ANTES DE EMPEZAR

- [ ] ¿Leí AGENTS.md?
- [ ] ¿Leí esta AGENTS-MOBILE.md?
- [ ] ¿Entiendo las 6 Features?
- [ ] ¿Sé qué datos necesito?
- [ ] ¿Conozco los permisos/roles?
- [ ] ¿Sé cómo se audita?
- [ ] ¿Identifico qué archivo/endpoint se modifica?
- [ ] ¿Tengo un prompt claro?

Si respondiste "no" a algo, detente y aclara primero.

---

# 🎓 REGLA DE ORO FINAL

> **Argüello Infancias Mobile debe ser una herramienta práctica, segura y confiable para el acompañamiento diario de NNA.**

Cada Feature debe resolver una **necesidad real del educador**, no ser sobreingeniería.

---

**¿Siguientes pasos?**

1. Elige una Feature (comienza con F1)
2. Lee detalle en 03-ARGUELLO-MOBILE-FEATURES.md
3. Revisa criterios en 04-CRITERIOS-ACEPTACION.md
4. Revisa wireframes en 05-WIREFRAMES.md
5. Escribe un prompt en `prompts/`
6. Obtén aprobación
7. ¡Codeá!

**Bienvenido. Ahora eres parte de Argüello Infancias.** 🚀
