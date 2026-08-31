# 🚀 BRIEF PARA CLAUDE CODE — Cielo Móvil v1

## Resumen Ejecutivo

**Cielo Móvil** es una aplicación móvil para acompañamiento diario de menores (NNA) en residencias bajo protección judicial.

**Usuarios finales:** Educadores y operadores convivenciales  
**Stack:** Expo + React Native + TypeScript + Supabase  
**MVP scope:** 6 Features funcionales (51 criterios verificables)  
**Documentación:** 6 archivos .md prescriptivos (zero ambigüedad)

---

## 📋 DOCUMENTACIÓN PROPORCIONADA

**Todos estos archivos están en `/outputs/`:**

1. `01-documento-alcance.md` — Alcance, objetivos, requisitos
2. `02-arquitectura.md` — Stack, componentes, modelos de datos
3. `03-CIELO-MOBILE-FEATURES.md` — 6 Features detalladas + flujos
4. `04-CIELO-MOBILE-CRITERIOS-ACEPTACION.md` — 51 criterios (DADO-CUANDO-ENTONCES)
5. `05-CIELO-MOBILE-WIREFRAMES.md` — 15 wireframes con especificaciones
6. `06-CIELO-MOBILE-FLUJOS-NAVEGACION.md` — Navegación entre pantallas

**Bonus:** `AGENTS-MOBILE.md` (metodología de desarrollo)

---

## 🎯 LAS 6 FEATURES (NO CONFUNDIR CON PANTALLAS)

### F1 — Consultar información de residentes
- Lectura de datos básicos de NNA asignados
- Wireframes: WF-03, WF-04
- Criterios: CA-01 a CA-07 (7 criterios)

### F2 — Registrar novedades del turno
- Crear registro de evento/novedad
- Wireframes: WF-05, WF-06
- Criterios: CA-08 a CA-17 (10 criterios)

### F3 — Consultar historial de seguimiento
- Ver registros cronológicos
- Wireframes: WF-07, WF-08
- Criterios: CA-18 a CA-24 (7 criterios)

### F4 — Registrar actividades diarias
- Documentar actividades realizadas + estado
- Wireframes: WF-09, WF-10
- Criterios: CA-25 a CA-32 (8 criterios)

### F5 — Consultar novedades y tareas del turno
- Vista consolidada del turno
- Wireframes: WF-11, WF-12
- Criterios: CA-33 a CA-40 (8 criterios)

### F6 — Reportar situación crítica
- Registro especial diferenciado (rojo/naranja)
- Wireframes: WF-13, WF-14, WF-15
- Criterios: CA-41 a CA-51 (11 criterios)

**TOTAL: 6 Features, 15 wireframes, 51 criterios verificables**

---

## 🛠️ TAREA INICIAL PARA CLAUDE CODE

### PASO 1: Crear Estructura del Proyecto

```bash
cielo-mobile/
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

### PASO 2: Configuración Inicial

**app.json:**
- Nombre: "Cielo Móvil"
- Identificador: com.cielo.mobile
- Versión: 1.0.0
- Soporte para iOS y Android
- Orientación: portrait

**package.json (dependencias críticas):**
```json
{
  "expo": "^51.0",
  "react-native": "0.74",
  "typescript": "^5",
  "zustand": "^4",
  "zod": "^3",
  "@react-navigation/native": "^6",
  "expo-router": "^3",
  "nativewind": "^2",
  "@supabase/supabase-js": "^2",
  "@react-native-async-storage/async-storage": "^1",
  "react-native-gesture-handler": "^2"
}
```

### PASO 3: Types Principales

**types/resident.ts:**
```typescript
export type Resident = {
  id: string;
  first_name: string;
  last_name: string;
  birthdate: string;
  status: 'active' | 'egressed';
  photo_url?: string;
  primary_caregiver_id?: string;
};
```

**types/activity.ts:**
```typescript
export type Activity = {
  id: string;
  minor_id: string;
  activity_type: 'escuela' | 'recreativa' | 'deportiva' | 'comida' | 'pedagogica' | 'medico' | 'otra';
  status: 'pendiente' | 'realizada' | 'no_realizada';
  observations?: string;
  created_at: string;
  created_by: string;
};
```

**types/observation.ts:**
```typescript
export type Observation = {
  id: string;
  minor_id: string;
  content: string;
  category: 'conducta' | 'emocional' | 'educativo' | 'sanitario' | 'otro';
  reported_by: string;
  observation_date: string;
  created_at: string;
};
```

### PASO 4: Schemas Zod para Validación

**lib/validation.ts:**
```typescript
import { z } from 'zod';

export const ObservationSchema = z.object({
  minor_id: z.string().uuid('ID de residente inválido'),
  content: z.string().min(10, 'Mínimo 10 caracteres').max(500),
  category: z.enum(['conducta', 'emocional', 'educativo', 'sanitario', 'otro']),
});

export const ActivitySchema = z.object({
  minor_id: z.string().uuid(),
  activity_type: z.enum(['escuela', 'recreativa', 'deportiva', 'comida', 'pedagogica', 'medico', 'otra']),
  status: z.enum(['pendiente', 'realizada', 'no_realizada']),
  observations: z.string().optional(),
});

export const CriticalIncidentSchema = z.object({
  minor_id: z.string().uuid(),
  incident_type: z.enum(['violencia', 'crisis_emocional', 'accidente', 'fuga', 'emergencia_sanitaria', 'otra']),
  description: z.string().min(20, 'Mínimo 20 caracteres').max(1000),
  actions_taken: z.string().optional(),
  people_notified: z.array(z.string()).optional(),
});
```

### PASO 5: Componentes Reutilizables

**components/ResidentCard.tsx:**
- Foto/avatar
- Nombre
- Edad
- Estado (badge)
- Clickeable → detalle

**components/ActivityCard.tsx:**
- Tipo de actividad (icono)
- Descripción
- Estado (badge)
- Fecha/hora

**components/buttons/CriticalButton.tsx:**
- Color: rojo (#DC3545)
- Icono: ⚠️
- Texto: "Situación Crítica"
- Accesible desde múltiples pantallas

### PASO 6: Primeras Pantallas (Mock Data)

**app/(auth)/login.tsx:**
- Formulario login (usuario, contraseña)
- Validación básica
- Mock: usuario@test.com / password123

**app/(tabs)/inicio.tsx:**
- Saludo personalizado
- Resumen turno
- Botones de acceso a Features
- Botón diferenciado "Situación Crítica"

**app/(tabs)/residentes.tsx:**
- Lista de residentes (mock: 5 NNA)
- Click → detalle
- ResidentCard reutilizable

**app/residentes/[id].tsx:**
- Información del residente
- Tabs: Info, Novedades, Historial, Actividades
- Botones de acción

---

## 🎨 PALETA DE COLORES

**⚠️ OBTENER DE FIGMA → Copiar aquí**

```
Primario: #007AFF (azul)
Secundario: #5AC8FA (azul claro)
Crítica: #DC3545 (rojo)
Éxito: #28A745 (verde)
Advertencia: #FFC107 (naranja)
Error: #DC3545 (rojo)
Neutral: #6C757D (gris)
Fondo: #FFFFFF (blanco)
```

---

## 🔑 PUNTOS CLAVE

### ✅ HACER

- [ ] Estructura clara: app/, components/, hooks/, lib/, store/, types/
- [ ] TypeScript strict mode en tsconfig.json
- [ ] Zod schemas para TODAS las validaciones
- [ ] Zustand para estado global (auth, residentes, UI)
- [ ] AsyncStorage para cache local
- [ ] Componentes reutilizables (ResidentCard, ActivityCard, etc.)
- [ ] Mock data en types (para primeras pantallas)
- [ ] Crear archivo design-tokens.json (colores, tipografía)
- [ ] Documentar cómo ejecutar: `npm install && expo start`
- [ ] Incluir .env.example con variables Supabase

### ❌ NO HACER

- ❌ Crear 15 pantallas (solo crear 4-5 para MVP)
- ❌ Conectar a Supabase real (usar mock data)
- ❌ Implementar todas las Features (solo F1 mockup)
- ❌ Agregar navegación compleja (mantener simple)
- ❌ Componentes sin reutilización
- ❌ Código sin tipos (TypeScript strict)

---

## 📝 NOTAS IMPORTANTES

1. **No son 15 Features:** Los 15 wireframes son **soporte visual** para las **6 Features**

2. **RBAC:** Educadores solo ven residentes asignados (filtrar por `primary_caregiver_id`)

3. **Situación Crítica:** Debe estar visualmente diferenciada (rojo, ícono ⚠️, acceso prominente)

4. **Offline sync:** Implementar con AsyncStorage (guardar localmente, sincronizar cuando hay conexión)

5. **Auditoría:** Log de todas las acciones (tabla audit_log en BD)

6. **Validación:** Usar Zod schemas ANTES de enviar datos a Supabase

7. **Testing:** Crear tests para criterios CA-01 a CA-51

---

## 🎯 ENTREGABLES ESPERADOS

**Después de esta tarea, el proyecto debe tener:**

1. ✅ Estructura carpetas completa
2. ✅ TypeScript configurado (strict)
3. ✅ 6 types principales (resident, activity, observation, task, user, critical)
4. ✅ 5 schemas Zod para validaciones
5. ✅ 6 componentes reutilizables (ResidentCard, ActivityCard, AlertCard, 3 botones)
6. ✅ 5 pantallas básicas (login mockup, inicio, residentes, detalle, turno)
7. ✅ Zustand store (auth, residents, ui)
8. ✅ design-tokens.json con paleta de colores
9. ✅ .env.example con variables
10. ✅ README.md con instrucciones

---

## 🚀 EJECUCIÓN

**Comando para empezar:**
```bash
npx create-expo-app cielo-mobile --template
cd cielo-mobile
npm install
expo start
```

**Después que Claude Code prepare la estructura:**
```bash
# Verificar TypeScript
npx tsc --noEmit

# Ejecutar app
expo start

# En iOS/Android
# Escanear QR con Expo Go
```

---

## 📞 REFERENCIAS

- **Documentación:** `/outputs/01-*.md` a `/outputs/06-*.md`
- **Metodología:** `/outputs/AGENTS-MOBILE.md`
- **Features detalladas:** `/outputs/03-CIELO-MOBILE-FEATURES.md`
- **Criterios de testing:** `/outputs/04-CIELO-MOBILE-CRITERIOS-ACEPTACION.md`
- **Wireframes referencia:** `/outputs/05-CIELO-MOBILE-WIREFRAMES.md`
- **Navegación:** `/outputs/06-CIELO-MOBILE-FLUJOS-NAVEGACION.md`

---

## ✅ CHECKLIST FINAL

- [ ] Leviste toda la documentación (6 archivos)
- [ ] Entiendes las 6 Features y sus criterios
- [ ] Tienes paleta de colores (Figma)
- [ ] Claude Code comienza con estructura completa
- [ ] Mock data es realista (nombres, edades, etc.)
- [ ] TypeScript es strict
- [ ] Zod valida TODOS los inputs
- [ ] Componentes son reutilizables
- [ ] README.md es claro (cómo correr proyecto)

---

**🎯 META:** Después de esta tarea, el proyecto MVP está **80% listo**. Solo falta conectar a Supabase real y completar los flujos de F2-F6.

**¡Adelante!**
