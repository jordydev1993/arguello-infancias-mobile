# 📋 PLAN DETALLADO: 6 FEATURES (31 Agosto - 02 Septiembre 2026)

**Argüello Infancias Mobile — Implementación Completa**

**Equipo:** Jordy (Producto), Meli (QA), Cami (UI/UX), Sofi (Backend)

---

## 📊 OVERVIEW: 6 FEATURES EN 3 DÍAS

```
31/08 ─────────────── 01/09 ─────────────── 02/09
 ↓                     ↓                      ↓
Setup               F1 + F2              F3-F6 + MVP
                  (17 criterios)      (34 criterios)
```

| Feature | Criterios | Días | Status |
|---------|-----------|------|--------|
| F1: Consultar residentes | 7 | 31/08 → 01/09 | ✅ Prioridad 1 |
| F2: Registrar novedades | 10 | 31/08 → 01/09 | ✅ Prioridad 1 |
| F3: Consultar historial | 7 | 01/09 → 02/09 | ⏳ Prioridad 2 |
| F4: Registrar actividades | 8 | 01/09 → 02/09 | ⏳ Prioridad 2 |
| F5: Consultar turno | 8 | 02/09 | 🔄 Prioridad 3 |
| F6: Situación crítica | 11 | 02/09 | 🔄 Prioridad 3 |
| **TOTAL** | **51** | | |

---

## 📅 DISTRIBUCIÓN POR DÍAS

### DÍAS DE SETUP (30/08)

**Prerrequisito: Que se hizo el 30/08**

```
30/08 (sábado - no incluido en conteo)
├─ Jordy: Alcance + arquitectura ✅
├─ Meli: 6 Features + criterios ✅
├─ Cami: Flujos + wireframes ✅
└─ Sofi: Modelo de datos ✅

Resultado: Especificación 100% lista
```

---

## 🟦 **31 DE AGOSTO (DOMINGO) — DÍA 1: ESTRUCTURA + F1**

**Horas:** 09:00 - 17:00 (8 horas intensas)

### MAÑANA (09:00 - 14:00)

---

#### **🔵 JORDY — Crear Proyecto Base**

**Tiempo:** 5 horas

```
[ ] 09:00-09:30: Standup + Setup inicial (30 min)
    - Revisar especificaciones del 30/08
    - Crear Expo project: npx create-expo-app arguello-mobile
    - Configurar TypeScript
    - Crear estructura de carpetas
    
[ ] 09:30-10:30: Crear navegación base (60 min)
    - Expo Router setup
    - Stack navigator (auth, tabs)
    - Tabs: Inicio, Residentes, Actividades, Crítica, Perfil
    - Crear: src/app/_layout.tsx + (tabs)/_layout.tsx
    - Componentes stub
    
[ ] 10:30-11:30: Configurar Zustand store (60 min)
    - Crear: src/store/authStore.ts
    - Crear: src/store/residentStore.ts
    - Crear: src/store/uiStore.ts
    - Auth flow (login/logout)
    - Global state management
    
[ ] 11:30-12:30: Setup Supabase client (60 min)
    - Crear: src/lib/supabase.ts
    - Configurar env variables (.env.local)
    - Auth setup
    - Database connection test
    
[ ] 12:30-13:30: Almuerzo

[ ] 13:30-14:00: Validación proyecto base (30 min)
    - expo start
    - Verificar navegación funciona
    - Verificar no hay errores TypeScript
    - Git commit: "init: project base with navigation and stores"

📊 ENTREGABLE: Proyecto Expo funcional, navegación, stores, Supabase client
```

---

#### **🟣 MELI — Validar Requisitos + Criterios**

**Tiempo:** 5 horas

```
[ ] 09:00-09:30: Standup (30 min)

[ ] 09:30-10:30: Revisar F1 criterios (60 min)
    Lectura profunda de:
    - CA-01 a CA-07 (7 criterios)
    - Especificaciones detalladas
    - Casos de prueba
    - Edge cases
    
[ ] 10:30-11:30: Revisar F2 criterios (60 min)
    Lectura profunda de:
    - CA-08 a CA-17 (10 criterios)
    - Tipos de novedades
    - Validaciones
    - Casos de prueba
    
[ ] 11:30-12:30: Crear matriz de testing (60 min)
    Documento: testing-matrix-F1-F2.md
    - Caso de prueba por criterio
    - Pre-condiciones
    - Pasos
    - Resultado esperado
    
[ ] 12:30-13:30: Almuerzo

[ ] 13:30-14:00: Preparar checklist (30 min)
    - Checklist de validación F1 (7 items)
    - Checklist de validación F2 (10 items)
    - Lista de bugs esperados

📊 ENTREGABLE: Testing matrix, checklists, requisitos validados
```

---

#### **🟢 CAMI — Crear Componentes Base**

**Tiempo:** 5 horas

```
[ ] 09:00-09:30: Standup (30 min)

[ ] 09:30-10:30: Design system setup (60 min)
    - Crear: src/theme/colors.ts
    - Crear: src/theme/typography.ts
    - Crear: src/theme/spacing.ts
    Paleta Argüello:
    - Primary: #007AFF (azul)
    - Secondary: #7C3AED (púrpura)
    - Success: #28A745
    - Warning: #FFC107
    - Critical: #DC3545
    
[ ] 10:30-11:30: UI Components base (60 min)
    Crear en src/components/ui/:
    [ ] PrimaryButton.tsx
    [ ] SecondaryButton.tsx
    [ ] CriticalButton.tsx
    [ ] FormField.tsx
    [ ] SelectField.tsx
    [ ] TextAreaField.tsx
    [ ] ScreenHeader.tsx
    [ ] StatusBadge.tsx
    
[ ] 11:30-12:30: State components (60 min)
    Crear en src/components/states/:
    [ ] EmptyState.tsx (sin residentes, sin novedades)
    [ ] LoadingState.tsx (spinner)
    [ ] ErrorState.tsx (error message + retry)
    
[ ] 12:30-13:30: Almuerzo

[ ] 13:30-14:00: Exportar componentes (30 min)
    - Crear: src/components/index.ts (barrel export)
    - Storybook setup (optional)
    - Documentar cada componente

📊 ENTREGABLE: 12 componentes UI base, design system
```

---

#### **🟡 SOFI — Setup BD + Conexión**

**Tiempo:** 5 horas

```
[ ] 09:00-09:30: Standup (30 min)

[ ] 09:30-10:30: Crear DDL en Supabase (60 min)
    Conectar a Supabase
    Ejecutar: sql/001-schema.sql
    Crear tablas:
    [ ] perfiles_usuarios
    [ ] residentes
    [ ] turnos_trabajo
    [ ] residentes_turnos
    [ ] novedades
    [ ] actividades_diarias
    [ ] situaciones_criticas
    [ ] audit_log
    
[ ] 10:30-11:30: Crear índices + constraints (60 min)
    [ ] Índices para residentes (búsqueda, filtro)
    [ ] Índices para novedades (fecha, usuario)
    [ ] Índices para audit_log
    [ ] Foreign keys correctas
    [ ] ON DELETE RESTRICT/CASCADE correcto
    
[ ] 11:30-12:30: Setup RLS policies (60 min)
    [ ] RLS en residentes (por rol)
    [ ] RLS en novedades (RBAC)
    [ ] RLS en actividades
    [ ] Test: educador ve solo asignados
    
[ ] 12:30-13:30: Almuerzo

[ ] 13:30-14:00: Datos de prueba (30 min)
    Crear: sql/002-seed-data.sql
    - 5 residentes
    - 2 usuarios (educador, coordinador)
    - 3 turnos
    - Asignaciones

📊 ENTREGABLE: BD con 7 tablas, índices, RLS, datos de prueba
```

---

### TARDE (14:00 - 17:00)

---

#### **🔵 JORDY — Implementar F1 (Consultar Residentes)**

**Tiempo:** 3 horas

**F1 Criterios: CA-01 a CA-07**
- CA-01: Listar residentes asignados
- CA-02: Mostrar nombre
- CA-03: Edad calculada
- CA-04: Foto
- CA-05: Alertas importantes
- CA-06: Filtros
- CA-07: Refresh

```
[ ] 14:00-14:30: Crear pantalla F1 (30 min)
    Crear: src/app/(tabs)/residentes.tsx
    - Header con título
    - Búsqueda/filtro
    - FlatList para residentes
    
[ ] 14:30-15:30: Crear hook useResidents (60 min)
    Crear: src/hooks/features/useResidents.ts
    - GET /api/residentes
    - Filter + search
    - Loading, error states
    - Refresh logic
    
[ ] 15:30-16:30: Crear componentes F1 (60 min)
    Crear en src/components/cards/:
    [ ] ResidentCard.tsx
      - Muestra foto, nombre, edad, alertas
      - Navegable a detail
      - Usa design tokens
      
    Crear en src/components/ui/:
    [ ] SearchField.tsx (búsqueda)
    [ ] RefreshButton.tsx
    
[ ] 16:30-17:00: Integración + test (30 min)
    - Conectar con Zustand store
    - Test en emulador: ¿carga residentes?
    - Verificar RBAC (educador ve solo asignados)
    - Git: "feat: implement F1 (consulting residents)"

📊 ENTREGABLE: F1 funcional (7/7 criterios comenzados)
```

---

#### **🟣 MELI — Validar Implementación F1**

**Tiempo:** 3 horas

```
[ ] 14:00-15:00: Code review F1 (60 min)
    - Revisar: residentes.tsx
    - Revisar: useResidents.ts
    - Revisar: ResidentCard.tsx
    - Checklist:
      ✓ TypeScript types correctos
      ✓ RBAC implementado
      ✓ Error handling
      ✓ Loading states
      ✓ Sigue AGENTS.md
      
[ ] 15:00-16:00: Testing manual F1 (60 min)
    En emulador:
    [ ] CA-01: ¿Lista residentes? ✓
    [ ] CA-02: ¿Muestra nombre? ✓
    [ ] CA-03: ¿Edad correcta? ✓
    [ ] CA-04: ¿Foto carga? ✓
    [ ] CA-05: ¿Alertas visibles? ✓
    [ ] CA-06: ¿Filtro funciona? ✓
    [ ] CA-07: ¿Refresh funciona? ✓
    
    Registrar bugs (si existen)
    
[ ] 16:00-17:00: Crear reporte F1 (60 min)
    Documento: test-results-F1-31-08.md
    - Criterios pasados: 7/7
    - Bugs encontrados: [lista]
    - Errores de types: [lista]
    - Next: Preparar F2 para mañana

📊 ENTREGABLE: F1 validada, test report, bugs documentados
```

---

#### **🟢 CAMI — Diseñar UI para F1 + F2**

**Tiempo:** 3 horas

```
[ ] 14:00-15:00: Revisar F1 en emulador (60 min)
    - ¿Colores correctos?
    - ¿Espaciado correcto?
    - ¿Tipografía Poppins?
    - ¿Responsive?
    - Notas de mejora visual
    
[ ] 15:00-16:00: Diseñar pantallas F2 (60 min)
    En Figma/Miro:
    [ ] Diseño de modal "Registrar novedad"
    [ ] Form layout
    [ ] Campos: tipo, descripción, fecha
    [ ] Botones (guardar, cancelar)
    [ ] Estados (vacío, con datos, error)
    
[ ] 16:00-17:00: Preparar assets para F2 (60 min)
    - Iconos para tipos de novedad (6 tipos)
    - Validación visual (error states)
    - Loading animations
    - Exportar para desarrollo mañana

📊 ENTREGABLE: UI F1+F2 diseñada, assets listos
```

---

#### **🟡 SOFI — Crear APIs F1 + F2**

**Tiempo:** 3 horas

```
[ ] 14:00-15:00: Crear API F1 (60 min)
    GET /api/residentes
    [ ] Query Supabase
    [ ] Filter: assigned_to_me
    [ ] Response: { residentes: [...], total: N }
    [ ] Error handling
    [ ] Request logging
    
[ ] 15:00-16:00: Crear API F2 (60 min)
    POST /api/novedades
    [ ] Input validation (zod)
    [ ] Insert en BD
    [ ] Trigger audit_log
    [ ] Response: { id, fecha_hora, usuario_id }
    [ ] Error handling
    
[ ] 16:00-17:00: Integración + test (60 min)
    - Conectar app a APIs
    - Test GET /api/residentes (¿trae datos?)
    - Preparar POST /api/novedades para mañana
    - Git: "feat: add APIs for F1 and F2"

📊 ENTREGABLE: APIs F1+F2 funcionales, tests manuales
```

---

### **RESUMEN 31/08**

**Entregables:**
```
✅ Proyecto Expo base (navegación, stores, Supabase)
✅ 12 componentes UI base
✅ Design system (colores, tipografía)
✅ BD con 7 tablas + índices + RLS + datos de prueba
✅ APIs GET /residentes, POST /novedades
✅ F1 implementada (7 criterios)
✅ Testing matrix F1+F2
✅ Git push
```

**Criterios completados:** 7/51 (13%)

---

## 🟩 **01 DE SEPTIEMBRE (LUNES) — DÍA 2: F2 + F3 + F4**

**Horas:** 09:00 - 17:00 (8 horas intensas)

### MAÑANA (09:00 - 14:00)

---

#### **🔵 JORDY — Implementar F2 (Registrar Novedades)**

**Tiempo:** 5 horas

**F2 Criterios: CA-08 a CA-17**
- CA-08: Form novedad
- CA-09: Validación campos
- CA-10: Timestamp automático
- CA-11 a CA-17: Casos específicos

```
[ ] 09:00-09:30: Standup (30 min)

[ ] 09:30-10:30: Pantalla detail residente (60 min)
    Crear: src/app/(tabs)/residentes/[id].tsx
    - Header con nombre residente
    - Tabs: Info, Novedades, Actividades
    - FlatList de novedades existentes
    
[ ] 10:30-11:30: Crear hook useObservations (60 min)
    Crear: src/hooks/features/useObservations.ts
    - POST /api/novedades (crear)
    - GET /api/residentes/:id/novedades (listar)
    - DELETE /api/novedades/:id (borrar)
    - Loading, error states
    
[ ] 11:30-12:30: Integración UI + form (60 min)
    - Conectar con Cami components
    - Form validation
    - Submit handler
    - Error/success messages
    
[ ] 12:30-13:30: Almuerzo

[ ] 13:30-14:00: Validación F2 (30 min)
    - Test en emulador: ¿se guarda novedad?
    - Verificar en BD
    - Verificar timestamp
    - Logs

📊 ENTREGABLE: F2 funcional (10/10 criterios comenzados)
```

---

#### **🟣 MELI — Validar F1 Completo + F2**

**Tiempo:** 5 horas

```
[ ] 09:00-09:30: Standup (30 min)

[ ] 09:30-10:30: Testing F1 exhaustivo (60 min)
    Todas las CA-01 a CA-07
    - Edge cases
    - Performance
    - Documentar bugs
    
[ ] 10:30-11:30: Code review F2 (60 min)
    - Revisar formulario
    - Revisar validaciones
    - Revisar API integration
    - Checklist F2
    
[ ] 11:30-12:30: Preparar testing F3+F4 (60 min)
    - Leer especificaciones F3 (7 criterios)
    - Leer especificaciones F4 (8 criterios)
    - Crear matriz testing
    
[ ] 12:30-13:30: Almuerzo

[ ] 13:30-14:00: Validar F2 en emulador (30 min)
    [ ] CA-08: ¿Form aparece? ✓
    [ ] CA-09: ¿Validación funciona? ✓
    [ ] CA-10: ¿Timestamp? ✓
    [ ] CA-11-17: Otros criterios
    
    Bugs encontrados: [lista]

📊 ENTREGABLE: F1 100% validada, F2 en testing
```

---

#### **🟢 CAMI — Implementar Componentes F2**

**Tiempo:** 5 horas

```
[ ] 09:00-09:30: Standup (30 min)

[ ] 09:30-10:30: Crear componentes formulario (60 min)
    Crear en src/components/forms/:
    [ ] NoveltyForm.tsx
      - Seleccionar tipo novedad (6 tipos)
      - Input descripción
      - Submit + cancel buttons
      - Validation visual
      
[ ] 10:30-11:30: Crear tarjetas de novedades (60 min)
    Crear en src/components/cards/:
    [ ] NoveltyCard.tsx
      - Muestra tipo, descripción, fecha
      - Muestra usuario que creó
      - Ícono por tipo
      - Editable si corresponde
      
[ ] 11:30-12:30: Crear componentes F3 (60 min)
    Diseñar en Figma:
    [ ] Timeline component (historial)
    [ ] TimelineItem.tsx
    [ ] Ícono por tipo de evento
    [ ] Conexión visual entre items
    
[ ] 12:30-13:30: Almuerzo

[ ] 13:30-14:00: Preparar para F4 (30 min)
    - Diseñar formulario actividades
    - Assets para F3+F4
    - Exportar para desarrollo

📊 ENTREGABLE: Componentes F2+F3 completos
```

---

#### **🟡 SOFI — Implementar CRUD F2 + F3**

**Tiempo:** 5 horas

```
[ ] 09:00-09:30: Standup (30 min)

[ ] 09:30-10:30: APIs F2 completas (60 min)
    GET /api/residentes/:id/novedades
    [ ] Listar novedades por residente
    [ ] Filtro por tipo
    [ ] Ordenar por fecha desc
    [ ] Paginación (limit, offset)
    
    PUT /api/novedades/:id
    [ ] Actualizar novedad
    [ ] Solo creador o admin
    
    DELETE /api/novedades/:id
    [ ] Soft delete (deleted_at)
    [ ] Solo creador o admin
    
[ ] 10:30-11:30: APIs F3 (historial) (60 min)
    GET /api/residentes/:id/historial
    [ ] Listar todos los eventos (novedades, actividades)
    [ ] Timeline ordenado por fecha
    [ ] Tipos de eventos
    [ ] Responsable de cada evento
    
[ ] 11:30-12:30: Validar F2+F3 en BD (60 min)
    - Test inserts/updates/deletes
    - Verificar audit_log
    - Verificar soft deletes
    - Performance queries
    
[ ] 12:30-13:30: Almuerzo

[ ] 13:30-14:00: Preparar F4 (30 min)
    - Diseñar tabla actividades_diarias
    - Preparar APIs GET/POST
    - Test data

📊 ENTREGABLE: APIs F2+F3 funcionales
```

---

### TARDE (14:00 - 17:00)

---

#### **🔵 JORDY — Implementar F3 (Consultar Historial)**

**Tiempo:** 3 horas

**F3 Criterios: CA-18 a CA-24**
- CA-18: Mostrar historial
- CA-19: Timeline visual
- CA-20: Filtros
- CA-21-24: Casos específicos

```
[ ] 14:00-14:30: Crear pantalla timeline (30 min)
    Crear: src/app/(tabs)/residentes/[id]/historial.tsx
    - Timeline visual
    - Usar componentes Cami
    - Filtros (tipo evento)
    
[ ] 14:30-15:30: Crear hook useTimeline (60 min)
    Crear: src/hooks/features/useTimeline.ts
    - GET /api/residentes/:id/historial
    - Filter por tipo
    - Pagination
    
[ ] 15:30-16:30: Integración (60 min)
    - Conectar con datos
    - Test: ¿carga historial?
    - Verificar timestamps
    - Verificar iconos por tipo
    
[ ] 16:30-17:00: Validación (30 min)
    - Test en emulador
    - Git: "feat: implement F3 (consulting history)"

📊 ENTREGABLE: F3 funcional (7/7 criterios)
```

---

#### **🟣 MELI — Testing F2 + F3**

**Tiempo:** 3 horas

```
[ ] 14:00-15:00: Testing exhaustivo F2 (60 min)
    Criterios CA-08 a CA-17
    - Form validation
    - DB storage
    - RBAC permissions
    - Bugs documentados
    
[ ] 15:00-16:00: Testing F3 (60 min)
    Criterios CA-18 a CA-24
    - Timeline carga
    - Eventos correctos
    - Ordenamiento
    - Filtros funcionan
    
[ ] 16:00-17:00: Preparar F4 + F5 + F6 (60 min)
    - Leer specs (24 criterios)
    - Crear matriz testing completa
    - Identificar bloqueadores

📊 ENTREGABLE: F2+F3 100% validadas
```

---

#### **🟢 CAMI — Crear Componentes F4**

**Tiempo:** 3 horas

```
[ ] 14:00-15:00: Diseñar F4 UX (60 min)
    Crear en Figma:
    [ ] ActivityForm.tsx
      - Seleccionar tipo (6 tipos)
      - Input descripción
      - Toggle "realizada"
      - Fecha selector
      
[ ] 15:00-16:00: Crear componentes F4 (60 min)
    Crear en src/components/:
    [ ] ActivityCard.tsx
    [ ] ActivityForm.tsx
    [ ] DatePicker.tsx (custom)
    
[ ] 16:00-17:00: Preparar F5+F6 (60 min)
    - Diseñar tabla de turnos (F5)
    - Diseñar modal crítica (F6)
    - Assets finales

📊 ENTREGABLE: Componentes F4 listos
```

---

#### **🟡 SOFI — Implementar F4 APIs**

**Tiempo:** 3 horas

```
[ ] 14:00-15:00: APIs F4 (60 min)
    POST /api/actividades
    GET /api/residentes/:id/actividades
    PUT /api/actividades/:id (mark realizada)
    
[ ] 15:00-16:00: Validación BD (60 min)
    - Insert/update/delete test
    - Soft deletes
    - Audit log
    
[ ] 16:00-17:00: Preparar F5+F6 (60 min)
    - APIs para turnos
    - APIs para crítica
    - Tablas relacionadas

📊 ENTREGABLE: F4 APIs funcionales
```

---

### **RESUMEN 01/09**

**Entregables:**
```
✅ F2 completa (10 criterios)
✅ F3 completa (7 criterios)
✅ F4 completa (8 criterios)
✅ Componentes para F4+F5+F6
✅ APIs para F2+F3+F4
✅ Testing F1+F2+F3 100%
```

**Criterios completados:** 32/51 (63%)

---

## 🟨 **02 DE SEPTIEMBRE (MARTES) — DÍA 3: F5 + F6 + MVP FINAL**

**Horas:** 09:00 - 17:00 (8 horas intensas)

### MAÑANA (09:00 - 14:00)

---

#### **🔵 JORDY — Implementar F5 + F6**

**Tiempo:** 5 horas

**F5 Criterios: CA-33 a CA-40** (Consultar turno)
- CA-33: Mostrar turno actual
- CA-34-40: Tareas, horarios

**F6 Criterios: CA-41 a CA-51** (Situación crítica)
- CA-41: Mostrar botón crítica
- CA-42: Form crítica
- CA-43-51: Casos específicos

```
[ ] 09:00-09:30: Standup (30 min)

[ ] 09:30-10:30: Implementar F5 (60 min)
    Crear: src/app/(tabs)/inicio.tsx (turno actual)
    - GET /api/turnos/mi-turno
    - Mostrar turno actual
    - Mostrar tareas del día
    - Mostrar residentes asignados
    
[ ] 10:30-11:30: Implementar F6 (60 min)
    Crear modal crítica:
    - Botón en header (siempre visible)
    - Modal form crítica
    - Tipos de crítica (5)
    - Descripción + validación
    - POST /api/critica (inmediato)
    
[ ] 11:30-12:30: Integración F5+F6 (60 min)
    - Conectar APIs
    - Validar datos
    - Test en emulador
    - Verificar alerts crítica
    
[ ] 12:30-13:30: Almuerzo

[ ] 13:30-14:00: Checkpoint (30 min)
    - Todas las 6 Features funcionan
    - Git status
    - Preparar para pruebas

📊 ENTREGABLE: F5+F6 funcionales (19 criterios)
```

---

#### **🟣 MELI — Testing F4 + F5 + F6**

**Tiempo:** 5 horas

```
[ ] 09:00-09:30: Standup (30 min)

[ ] 09:30-10:30: Testing F4 (60 min)
    Criterios CA-25 a CA-32
    - Form actividades
    - Registrar actividades
    - Mark realizada
    - Listado
    
[ ] 10:30-11:30: Testing F5 (60 min)
    Criterios CA-33 a CA-40
    - ¿Turno actual correcto?
    - ¿Tareas del día?
    - ¿Residentes asignados?
    - ¿Horario visible?
    
[ ] 11:30-12:30: Testing F6 (60 min)
    Criterios CA-41 a CA-51
    - ¿Botón crítica visible?
    - ¿Form crítica funciona?
    - ¿Se guarda en BD?
    - ¿Alerta se envía?
    - ¿Audit log registra?
    
[ ] 12:30-13:30: Almuerzo

[ ] 13:30-14:00: Reporte completo (30 min)
    Documento: QA-FINAL-REPORT.md
    - 51/51 criterios: ✅ / ❌
    - Bugs: [lista]
    - Performance: OK
    - Blockers: None

📊 ENTREGABLE: Testing 100% (51 criterios)
```

---

#### **🟢 CAMI — UI Polish + Figma**

**Tiempo:** 5 horas

```
[ ] 09:00-09:30: Standup (30 min)

[ ] 09:30-10:30: Review F5 UI (60 min)
    - Turno card visual
    - Tareas visual
    - Residentes list
    - Colores y espaciado
    
[ ] 10:30-11:30: Review F6 UI (60 min)
    - Modal crítica visual
    - Botón siempre visible
    - Estados (loading, error)
    - Validación visual
    
[ ] 11:30-12:30: Polish visual final (60 min)
    - Colores Argüello ✓
    - Espaciado correcto ✓
    - Tipografía Poppins ✓
    - Dark mode? (opcional)
    - Accesibilidad WCAG
    
[ ] 12:30-13:30: Almuerzo

[ ] 13:30-14:00: Actualizar Figma (30 min)
    - Exportar screenshots
    - Crear prototipo final
    - Documentar changes

📊 ENTREGABLE: UI 100% polida
```

---

#### **🟡 SOFI — Validar BD + Documentación**

**Tiempo:** 5 horas

```
[ ] 09:00-09:30: Standup (30 min)

[ ] 09:30-10:30: Validar performance F5+F6 (60 min)
    - Query turno actual
    - Query tareas del día
    - POST crítica
    - Tiempos < 200ms
    
[ ] 10:30-11:30: Validar RLS completo (60 min)
    - Educador ve solo su info
    - Coordinador ve todo
    - Admin no accede (mobile)
    - Crítica solo para educador+coordinador
    
[ ] 11:30-12:30: Validar audit_log completo (60 min)
    - Todos los eventos registrados
    - Timestamps correctos
    - Datos antes/después
    - Performance queries
    
[ ] 12:30-13:30: Almuerzo

[ ] 13:30-14:00: Documentación BD (30 min)
    Documento: DB-ARCHITECTURE-FINAL.md
    - Schema completo
    - Relaciones
    - RLS policies
    - Guía developer

📊 ENTREGABLE: BD 100% validada + documentada
```

---

### TARDE (14:00 - 17:00)

---

#### **🔵 JORDY — Finalización + MVP**

**Tiempo:** 3 horas

```
[ ] 14:00-14:30: Fix bugs críticos (30 min)
    - Bugs encontrados en testing
    - Arreglos rápidos
    - Re-test
    
[ ] 14:30-15:30: Integración final (60 min)
    - Todas las 6 Features conectadas
    - Navegación funciona perfecta
    - Data flow correcto
    - Performance optimizado
    
[ ] 15:30-16:30: Documentación README (60 min)
    Actualizar: README.md
    - Cómo ejecutar proyecto
    - Cómo configurar env
    - Estructura de carpetas
    - Features implementadas (F1-F6)
    - Testing guide
    
[ ] 16:30-17:00: Git final + cierre (30 min)
    git add -A
    git commit -m "feat: MVP complete (6 Features, 51/51 criteria)"
    git push origin main
    Verificar en GitHub

📊 ENTREGABLE: MVP F1-F6 funcional 100%
```

---

#### **🟣 MELI — QA Final + Report**

**Tiempo:** 3 horas

```
[ ] 14:00-14:30: Fix bugs con Jordy (30 min)
    - Revisar junto a Jordy cada bug
    - Verificar arreglos
    
[ ] 14:30-15:30: Testing final exhaustivo (60 min)
    Todos los 51 criterios:
    [ ] F1: 7/7 ✓
    [ ] F2: 10/10 ✓
    [ ] F3: 7/7 ✓
    [ ] F4: 8/8 ✓
    [ ] F5: 8/8 ✓
    [ ] F6: 11/11 ✓
    
[ ] 15:30-16:30: Crear QA Report final (60 min)
    Documento: QA-FINAL-REPORT-02-SEP.md
    - Estado: 51/51 ✓ (100%)
    - Bugs: 0 críticos ✓
    - Performance: OK ✓
    - Security: RLS OK ✓
    - Recommendations: [lista para iteración 2]
    
[ ] 16:30-17:00: Preparar demo (30 min)
    - Casos de prueba demostrables
    - Pasos para mostrar cada Feature
    - Datos de prueba listos

📊 ENTREGABLE: QA Report final, 0 bugs críticos
```

---

#### **🟢 CAMI — Design Final + Assets**

**Tiempo:** 3 horas

```
[ ] 14:00-15:00: Revisar visual final (60 min)
    - Todas las 6 Features en emulador
    - Colores correctos
    - Espaciado consistente
    - Estados visuales completos
    
[ ] 15:00-16:00: Crear guía visual (60 min)
    Documento: VISUAL-GUIDE-MVP.md
    - Screenshots por Feature
    - Componentes usados
    - Design tokens utilizados
    - Variantes (normal, loading, error)
    
[ ] 16:00-17:00: Assets finales (60 min)
    - Exportar SVGs si aplica
    - Crear design system doc
    - Figma final link
    - Prototipo clickeable

📊 ENTREGABLE: Design 100% completo + guía visual
```

---

#### **🟡 SOFI — BD Final + Documentación**

**Tiempo:** 3 horas

```
[ ] 14:00-15:00: Validar todas las APIs (60 min)
    GET, POST, PUT, DELETE
    F1-F6 completamente
    [ ] Status 200/201
    [ ] Error handling correcto
    [ ] Response format correcto
    
[ ] 15:00-16:00: Documentar APIs (60 min)
    Documento: API-REFERENCE.md
    - Todos los endpoints (F1-F6)
    - Parámetros
    - Response examples
    - Error codes
    - Guía de autenticación
    
[ ] 16:00-17:00: Archivado BD (60 min)
    - Schema backup
    - Seed data backup
    - Instrucciones setup
    - Performance metrics final

📊 ENTREGABLE: BD 100% documentada + APIs listas
```

---

### **TARDE: DEMO INTERNA + CIERRE (14:30-17:30)**

**Todos participan**

```
[ ] 14:30-15:30: DEMO INTERNA (60 min)
    Presentación ante todo el equipo:
    
    JORDY: Demo vivo en emulador
    ├─ F1: Lista de residentes, filtros
    ├─ F2: Registrar novedad, guardado
    ├─ F3: Timeline/historial
    ├─ F4: Registrar actividad
    ├─ F5: Ver turno actual
    └─ F6: Botón crítica funcional
    
    MELI: Resultados QA
    ├─ "51 criterios cumplidos ✓"
    ├─ "0 bugs críticos"
    ├─ "Performance OK"
    └─ "Listo para producción"
    
    CAMI: Diseño visual
    ├─ "Colores Argüello aplicados"
    ├─ "Componentes reutilizables"
    ├─ "UI consistente"
    └─ "WCAG AA compliant"
    
    SOFI: Backend status
    ├─ "7 tablas optimizadas"
    ├─ "RLS policies activas"
    ├─ "Audit log funcionando"
    └─ "APIs performantes"
    
[ ] 15:30-16:30: RETROSPECTIVA (60 min)
    Documento: RETROSPECTIVE-02-SEP.md
    
    ¿QUÉ SALIÓ BIEN?
    [ ] Estructura Vibe Engineering ✓
    [ ] Paralelismo de trabajo ✓
    [ ] Comunicación del equipo ✓
    [ ] Documentación exhaustiva ✓
    [ ] Velocidad implementación ✓
    
    ¿QUÉ SALIÓ MAL?
    [ ] (Espacio para feedback)
    [ ] (Espacio para feedback)
    
    ¿QUÉ MEJORAR?
    [ ] (Para iteración 2)
    [ ] (Para F7-F12)
    
[ ] 16:30-17:00: PLANNING SIGUIENTE (30 min)
    - Roadmap F7-F12 (siguiente sprint)
    - Asignación de Features
    - Fecha estimada
    - Bloqueadores identificados
    
[ ] 17:00-17:30: GIT FINAL + CIERRE
    git add . (documentación)
    git commit -m "docs: final documentation and retrospective"
    git push origin main
    
    ¡MVP COMPLETADO! 🎉

📊 RESULTADO FINAL
```

---

## 📊 **RESUMEN FINAL: 6 FEATURES EN 3 DÍAS**

### **Estado de Features**

| Feature | Criterios | 31/08 | 01/09 | 02/09 | Total |
|---------|-----------|-------|-------|-------|-------|
| F1: Residentes | 7 | 7 | ✓ | ✓ | 7/7 ✅ |
| F2: Novedades | 10 | — | 10 | ✓ | 10/10 ✅ |
| F3: Historial | 7 | — | 7 | ✓ | 7/7 ✅ |
| F4: Actividades | 8 | — | 8 | ✓ | 8/8 ✅ |
| F5: Turno | 8 | — | — | 8 | 8/8 ✅ |
| F6: Crítica | 11 | — | — | 11 | 11/11 ✅ |
| **TOTAL** | **51** | **7** | **25** | **19** | **51/51 ✅** |

---

### **Carga de Trabajo**

**JORDY (Producto):** 15 horas
- Día 1: 5h (proyecto base)
- Día 2: 5h (F1+F2)
- Día 3: 5h (F3+F4+F5+F6)

**MELI (QA):** 15 horas
- Día 1: 5h (matriz testing)
- Día 2: 5h (testing F1-F3)
- Día 3: 5h (testing F4-F6 + QA report)

**CAMI (UI/UX):** 15 horas
- Día 1: 5h (componentes base + F1+F2)
- Día 2: 5h (componentes F2+F3+F4)
- Día 3: 5h (UI polish + assets finales)

**SOFI (Backend):** 15 horas
- Día 1: 5h (BD setup + APIs F1-F2)
- Día 2: 5h (APIs F2-F4)
- Día 3: 5h (APIs F5-F6 + validación)

**TOTAL EQUIPO:** 60 horas = 3 días × 20 horas/día

---

### **Métricas de Éxito**

✅ **Criterios:** 51/51 (100%)  
✅ **Bugs críticos:** 0  
✅ **Performance:** < 200ms (queries)  
✅ **Security:** RLS policies activas  
✅ **Documentation:** 100% completa  
✅ **Code quality:** TypeScript tipado  
✅ **Testing:** 100% manual + automated  
✅ **Demo:** Exitosa  

---

## 🚀 **PRÓXIMO PASO (05-09 Septiembre)**

Después del MVP F1-F6:

```
Semana 2: F7-F12 (Features restantes)
├─ Análisis de requirements
├─ Setup nuevas tablas BD
├─ Implementación paralela
└─ MVP v2.0

Sprint planning: 05/09 09:00
Estimado: 6 features en 5 días
```

---

**¡MVP COMPLETADO! 🎉**

**Dates:** 31 Agosto - 02 Septiembre 2026  
**Team:** Jordy + Meli + Cami + Sofi  
**Features:** 6 (51 criterios)  
**Status:** Production-ready ✅

