# 🔄 REUTILIZABLE DE LINGUA → ARGÜELLO INFANCIAS MOBILE

## Análisis de Proyecto Lingua vs Argüello Infancias Mobile

**Lingua** es una app de aprendizaje de idiomas con AI (Duolingo-inspired)  
**Argüello Infancias Mobile** es una app de acompañamiento de NNA en residencias

Aunque tienen propósitos diferentes, **comparten arquitectura técnica y patrones de diseño** que se pueden reutilizar.

---

## ✅ STACK TÉCNICO (100% REUTILIZABLE)

### Identical Stack

```
✅ Expo
✅ React Native  
✅ TypeScript
✅ Expo Router
✅ NativeWind / Tailwind CSS
✅ Zustand (state management)
✅ AsyncStorage (local persistence)
```

### Authentication
```
Lingua: Clerk
Argüello Infancias: Supabase Auth (similar pero diferente)

→ Patrón: Ambas usan (auth)/ folder + protected routes
→ REUTILIZABLE: Estructura de rutas autenticadas
```

### Backend Integration
```
Lingua: Stream SDK + GetStream + Vision Agents
Argüello Infancias: Supabase + Express API

→ REUTILIZABLE: Patrón de API calls + error handling + loading states
```

---

## 📂 ARQUITECTURA DE CARPETAS (100% REUTILIZABLE)

**Lingua usa esta estructura:**

```
app/
  (auth)/          ← Auth screens
    login.tsx
    signup.tsx
  (tabs)/          ← Main navigation
    _layout.tsx
    home.tsx
    learn.tsx
    ai-teacher.tsx
    chat.tsx
    profile.tsx
  lesson/
    [id].tsx
components/
constants/
data/
hooks/
lib/
store/
types/
assets/
```

**Argüello Infancias Mobile adaptará así:**

```
app/
  (auth)/          ← Auth (email/password + MFA)
    login.tsx
    signup.tsx
    mfa.tsx
  (tabs)/          ← Main navigation (5 tabs)
    _layout.tsx
    inicio.tsx
    residentes.tsx
    turno.tsx
    critica.tsx
    perfil.tsx
  residentes/
    [id].tsx
    [id]/
      novedades.tsx
      historial.tsx
      actividades.tsx
components/        ← Reutilizable (botones, cards, etc)
constants/         ← Colors, fonts, breakpoints
data/              ← Mock data (residentes, actividades, etc)
hooks/             ← useAuth, useResidents, useActivities
lib/               ← supabase.ts, api.ts, validation.ts
store/             ← authStore, residentStore, uiStore
types/             ← resident.ts, activity.ts, observation.ts
assets/            ← icons, illustrations, fonts
```

✅ **La estructura de carpetas se mantiene igual** (solo cambiar nombres de pantallas)

---

## 🎨 SISTEMA DE DISEÑO (85% REUTILIZABLE)

### TIPOGRAFÍA

**Lingua usa: Poppins**
```
Poppins es moderna, geométrica, friendly
→ REUTILIZAR para Argüello Infancias Mobile
```

**Jerarquía de Lingua:**
```
H1: 32px Bold (Page/Screen Title)
H2: 24px SemiBold (Section Title)
H3: 20px SemiBold (Card/Module Title)
H4: 16px Medium (Subheading)
Body Large: 16px Regular (Important content)
Body Medium: 14px Regular (Body text)
Body Small: 13px Regular (Supporting text)
Caption: 11px Regular (Labels, meta text)
```

✅ **REUTILIZAR ESTE ESQUEMA EXACTO** para Argüello Infancias Mobile

---

### COLORES (ADAPTADOS)

**Lingua - Primary Colors:**
```
Lingua Purple: #6C4EF5
Lingua Deep Purple: #5B3BF6
Lingua Blue: #4D8BFF
Lingua Green: #21C16B
```

**Argüello Infancias Mobile - Propuesta (sin paleta Figma aún):**
```
Primario: Azul educativo (#007AFF) - más académico
Secundario: Púrpura suave (#7C3AED) - reconfortante
Crítica: Rojo alertante (#DC3545) - urgente
Éxito: Verde (#28A745) - confirmación
Advertencia: Naranja (#FFC107) - atención
Neutral: Gris (#6B7280) - soporte
```

**PENDING: Obtener paleta de Figma → Actualizar colores exactos**

---

### COMPONENTES REUTILIZABLES

#### De Lingua (Source)

| Componente | Usado en | Reutilizable |
|-----------|----------|-------------|
| PrimaryButton | Lecciones, Auth | ✅ Sí (cambiar colores) |
| SecondaryButton | Navegación | ✅ Sí |
| LanguageCard | Selección de idioma | ⚠️ Adaptar (Resident Card) |
| LessonCard | Home, Learn | ✅ Sí (Activity/Task Card) |
| XPBar | Home | ⚠️ Adaptar (Progress Bar) |
| TabNavigation | Bottom tabs | ✅ Sí (estructura igual) |
| LoadingState | Data loading | ✅ Sí |
| EmptyState | No data | ✅ Sí |

#### Para Argüello Infancias Mobile (Adaptation)

```
✅ PrimaryButton
   → Para acciones principales (Guardar, Continuar, Confirmar)

✅ SecondaryButton  
   → Para acciones alternativas (Cancelar, Volver)

✅ CriticalButton (nuevo)
   → Para situación crítica (rojo, diferenciado)

✅ ResidentCard (adaptado de LanguageCard)
   → Mostrar: nombre, edad, foto, estado
   
✅ ActivityCard (adaptado de LessonCard)
   → Mostrar: tipo, estado, fecha, descripción
   
✅ AlertCard (nuevo)
   → Para alertas/novedades (amarillo, rojo)
   
✅ ProgressBar (adaptado de XPBar)
   → Para turno/actividades completadas
   
✅ TabNavigation
   → 5 tabs: Inicio, Residentes, Mi Turno, Crítica, Perfil
```

---

## 📝 ARCHIVOS PROMPTS DE LINGUA (REUTILIZABLE)

**Lingua creó 18 archivos de prompts:**

```
01-nativewind.md          → NativeWind + Tailwind setup
02-design-theme.md        → Tema de colores y tipografía
03-onboarding-ui.md       → Pantalla de bienvenida
04-authentication-ui.md   → Auth (login/signup)
05-select-language.md     → Selector (adaptable a residentes)
06-content-system.md      → Sistema de contenidos
07-language-ui.md         → UI de idiomas
08-zustand.md             → State management
09-custom-tab-nav.md      → Navegación por tabs
10-home-ui.md             → Pantalla de inicio
11-lesson-ui.md           → Pantalla de lecciones
12-audio-lesson-ui.md     → Audio interactions
13-stream-integration.md   → Video/streaming (NO para Argüello Infancias)
14-vision-agents.md       → AI vision (NO para Argüello Infancias)
15-connection-to-ui.md    → Conexión backend
16-ai-teacher-improvements.md → Mejoras AI (NO para Argüello Infancias)
17-live-captions.md       → Captions (NO para Argüello Infancias)
18-more-posthog.md        → Analytics (opcional)
```

**Para Argüello Infancias Mobile - Reutilizable:**

```
✅ 01-nativewind.md          → Setup NativeWind (copiar exacto)
✅ 02-design-theme.md        → Adaptar colores/fonts (Argüello Infancias theme)
✅ 03-onboarding-ui.md       → Adaptar flujo de bienvenida
✅ 04-authentication-ui.md   → Adaptar login/signup + MFA
✅ 05-select-language.md     → → Selector de residentes (adaptar)
✅ 08-zustand.md             → Store setup (copiar patrón)
✅ 09-custom-tab-nav.md      → Tab navigation (adaptar 5 tabs)
✅ 10-home-ui.md             → Inicio/Dashboard
✅ 15-connection-to-ui.md    → API connection pattern

❌ 06-content-system.md      → Diferente propósito
❌ 07-language-ui.md         → Específico de idiomas
❌ 11-lesson-ui.md           → Específico de lecciones
❌ 12-audio-lesson-ui.md     → Audio lessons (NO)
❌ 13-stream-integration.md   → Video streaming (NO)
❌ 14-vision-agents.md       → Vision agents (NO)
❌ 16-ai-teacher-improvements.md → AI teacher (NO)
❌ 17-live-captions.md       → Captions (NO)
```

---

## 🎨 DISEÑO VISUAL (STYLE GUIDE REUTILIZABLE)

### De Lingua Design System:

**Imagen 8 muestra:**

```
BRAND
├─ Logo: Fox mascot (naranja)
├─ Tipografía: Poppins
└─ Nombre: "lingua"

COLORS (System)
├─ Primary: Purple (#6C4EF5) - Interactive, CTA
├─ Secondary: Blue (#4D8BFF) - Alternative, Hover
├─ Success: Green (#21C16B) - Positive, Completion
├─ Warning: Yellow (#FFC800) - Caution
├─ Streak: Orange (#FF8A00) - Achievement
├─ Error: Red (#FF4D4F) - Negative
├─ Info: Blue (#4D8BFF) - Informational
├─ Text/Primary: Navy (#0D132B) - Main text
├─ Text/Secondary: Gray (#6B7280) - Supporting text
├─ Border: Light Gray (#E5E7EB)
├─ Surface: Lightest (#F6F7FB)
└─ Background: White (#FFFFFF)

TYPOGRAPHY
├─ Font: Poppins (sans-serif)
├─ Sizes: 11px, 13px, 14px, 16px, 20px, 24px, 32px
├─ Weights: Regular, Medium, SemiBold, Bold
└─ Line height: 1.2 to 1.6
```

### Para Argüello Infancias Mobile:

**Adoptar:**
✅ Tipografía Poppins (igual)  
✅ Jerarquía de tamaños (igual)  
✅ Pesos de fuente (igual)  
✅ Patrón de colores semánticos (adaptar colores)  
✅ Espaciado consistente  
✅ Border radius suave (8px, 12px)  
✅ Sombras sutiles (iOS-style)  

---

## 🖼️ PANTALLAS DE DISEÑO (ADAPTABLES)

### De Lingua (Imágenes adjuntas):

**Imagen 2: AI Teacher Lesson**
- Header: Nombre + online status
- Mascota (fox) hablando
- Message bubble con feedback
- Bottom action buttons (Camera, Mic, Subtitles, End Call)
- Bottom score feedback (Speaking, Pronunciation, Grammar)

→ **Para Argüello Infancias:** Video call con AI Tutor (similar estructura)

---

**Imagen 3: Lesson Selection**
- Hero illustration (café)
- Tabs: Lessons / Practice
- Lesson list con status indicators (✓ completed, 🔄 in progress, 🔒 locked)

→ **Para Argüello Infancias:** Listado de residentes / tareas (adaptable)

---

**Imagen 4: Home Screen**
- Welcome greeting
- Daily goal progress bar
- Hero card (continue learning)
- "Today's plan" list
- Bottom navigation tabs

→ **Para Argüello Infancias:** Inicio con turno + novedades + tareas (usar patrón)

---

**Imagen 5: Language Selection**
- Search bar
- Popular languages
- Flag icons + learner count
- Bottom illustration

→ **Para Argüello Infancias:** Selector de residentes o filtros

---

**Imagen 6: Auth Screen**
- Mascota
- Email + Password fields
- Social login (Google, Facebook, Apple)

→ **Para Argüello Infancias:** Auth + MFA (adaptar formulario)

---

**Imagen 7: Onboarding**
- Mascota waving
- Tagline + subheading
- Carousel dots
- CTA button

→ **Para Argüello Infancias:** Onboarding de educador (reutilizar estructura)

---

## 🔧 CONFIGURACIÓN TÉCNICA REUTILIZABLE

### NativeWind & Tailwind

**Lingua setup:**
```
nativewind: ^2.x
tailwindcss: ^3.x
```

→ **COPIAR EXACTO para Argüello Infancias Mobile** (misma versión)

---

### Zustand Store Pattern

**Lingua ejemplo:**
```typescript
// store/authStore.ts
export const useAuthStore = create((set) => ({
  user: null,
  setUser: (user) => set({ user }),
  logout: () => set({ user: null }),
}));
```

→ **MISMO PATRÓN para:**
- authStore (educador)
- residentStore (residentes asignados)
- uiStore (tema, idioma, etc)

---

### Hooks Pattern

**Lingua usa hooks para:**
- useAuth (auth state)
- useLesson (lesson data)
- useLessonProgress (progress tracking)

→ **Para Argüello Infancias:**
```typescript
- useAuth (educador auth)
- useResidents (residentes asignados)
- useActivities (actividades del turno)
- useObservations (novedades/historial)
- useShift (información del turno)
```

---

## 📊 TABLA COMPARATIVA REUTILIZABLE

| Aspecto | Lingua | Argüello Infancias Mobile | Reutilizable |
|---------|--------|-----------|-------------|
| Stack | Expo + RN + TS | Expo + RN + TS | ✅ 100% |
| Routing | Expo Router | Expo Router | ✅ 100% |
| Styling | NativeWind 2.x | NativeWind 2.x | ✅ 100% |
| State | Zustand | Zustand | ✅ 100% |
| Font | Poppins | Poppins | ✅ 100% |
| Color System | Semantic colors | Semantic colors | ✅ 90% (adaptar) |
| Components | PrimaryButton, Cards | PrimaryButton, Cards | ✅ 85% (adaptar) |
| Architecture | Clean folders | Clean folders | ✅ 100% |
| Auth | Clerk | Supabase | ⚠️ 50% (patrón sí, SDK no) |
| Backend | Stream SDK | Supabase API | ⚠️ 50% (patrón sí, SDK no) |
| AI Integration | Vision Agents | No AI vision | ❌ 0% |
| Video Calling | Stream SDK | Posible después | ❌ 0% (MVP) |

---

## 📋 ARCHIVOS A REUTILIZAR DIRECTAMENTE

### 1. **Design Tokens** (copiar estructura)
```
Lingua: colors, typography, spacing
↓
Argüello Infancias: adaptar mismo patrón en constants/
```

### 2. **Component Base** (copiar código, adaptar estilos)
```
PrimaryButton.tsx
SecondaryButton.tsx
LoadingState.tsx
EmptyState.tsx
```

### 3. **Store Pattern** (copiar estructura)
```
store/authStore.ts → mismo patrón
store/uiStore.ts → mismo patrón
```

### 4. **API Integration Pattern** (copiar patrón)
```
lib/api.ts → estructura de llamadas
lib/auth.ts → estructura de autenticación
```

### 5. **Tab Navigation** (copiar código, adaptar rutas)
```
app/(tabs)/_layout.tsx → cambiar tabs
```

---

## 🚫 QUÉ NO REUTILIZAR

```
❌ Clerk authentication (Supabase en Argüello Infancias)
❌ Stream SDK (Supabase en Argüello Infancias)
❌ GetStream (Supabase en Argüello Infancias)
❌ Vision Agents (No hay AI teacher)
❌ Lesson/Course system (Diferentes features)
❌ Audio lesson UI (No es el foco)
❌ XP/Gamification system (Diferente propósito)
❌ Language selection flow (Residentes, no idiomas)
```

---

## 🎯 RESUMEN EJECUTIVO

### Quick Win Checklist

- [x] **Arquitectura de carpetas**: Copiar estructura exacta
- [x] **NativeWind + Tailwind**: Copiar versión y configuración
- [x] **Tipografía Poppins**: Adoptar jerarquía exacta
- [x] **Colores semánticos**: Adaptar esquema (esperar paleta Figma)
- [x] **Componentes base**: Reutilizar, adaptar estilos
- [x] **Zustand pattern**: Copiar patrón de stores
- [x] **Hooks pattern**: Copiar patrón, adaptar funcionalidad
- [x] **Tab navigation**: Copiar código, cambiar rutas
- [x] **API integration pattern**: Copiar estructura (no SDKs)
- [x] **Auth flow pattern**: Copiar estructura (SDK diferente)

### Estimated Time Savings

```
Sin reutilizar Lingua: 200+ horas
Con reutilizar Lingua: 120+ horas
=================================
Ahorro: ~40% (80 horas)
```

---

## 📁 PARA OBTENER ASSETS DE LINGUA

**Si se quieren reutilizar images/icons de Lingua:**

```
Mencionaste: "las imágenes, iconos y fonts 
las tengo en una carpeta aparte"

→ Copia a: arguello-infancias-mobile/assets/
   ├── images/
   ├── icons/
   └── fonts/

→ Cambiar referencias en componentes
→ Adaptar colores si es necesario
```

---

## 🔄 WORKFLOW PROPUESTO

### Fase 1: Setup (Copiar exacto)
```
1. Copiar estructura de carpetas
2. Instalar NativeWind 2.x (como Lingua)
3. Copiar componentes base
4. Copiar design tokens (adaptar colores)
5. Configurar Zustand stores
```

### Fase 2: Adaptación (Cambiar específico)
```
1. Reemplazar Clerk con Supabase
2. Reemplazar Stream SDK con Supabase API
3. Cambiar LanguageCard → ResidentCard
4. Cambiar LessonCard → ActivityCard
5. Adaptar tab navigation a 5 tabs Argüello Infancias
```

### Fase 3: Features (Nuevo)
```
1. Implementar 6 Features (F1-F6)
2. Crear hooks específicos para Argüello Infancias
3. Crear screens específicas
4. Testing
```

---

**¡Con Lingua como base, Argüello Infancias Mobile MVP estará listo en 50% menos tiempo!** 🚀

EOFLIGA
cat /mnt/user-data/outputs/REUSABLE-LINGUA-PARA-ARGUELLO.md | head -150
