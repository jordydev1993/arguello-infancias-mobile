# 🎨 DESIGN SYSTEM — Cielo Móvil

**Basado en Lingua Design System, adaptado para Cielo Móvil**

---

## 1. TIPOGRAFÍA

**Font Family:** Poppins (sans-serif moderna, geométrica)

### Jerarquía de Tamaños

```
H1 (Page/Screen Title)
├─ Size: 32px
├─ Weight: Bold (700)
├─ Line Height: 1.2
└─ Use: Screen titles, headers

H2 (Section Title)
├─ Size: 24px
├─ Weight: SemiBold (600)
├─ Line Height: 1.3
└─ Use: Section headers, major divisions

H3 (Card/Module Title)
├─ Size: 20px
├─ Weight: SemiBold (600)
├─ Line Height: 1.3
└─ Use: Card titles, module names

H4 (Subheading)
├─ Size: 16px
├─ Weight: Medium (500)
├─ Line Height: 1.4
└─ Use: Subheadings, labels

Body Large (Important content)
├─ Size: 16px
├─ Weight: Regular (400)
├─ Line Height: 1.6
└─ Use: Body text (main content)

Body Medium (Body text)
├─ Size: 14px
├─ Weight: Regular (400)
├─ Line Height: 1.6
└─ Use: Standard body text

Body Small (Supporting text)
├─ Size: 13px
├─ Weight: Regular (400)
├─ Line Height: 1.6
└─ Use: Supporting text, descriptions

Caption (Meta text)
├─ Size: 11px
├─ Weight: Regular (400)
├─ Line Height: 1.4
└─ Use: Labels, captions, metadata
```

---

## 2. PALETA DE COLORES

### Primary Colors (Educación + Protección)

```
CIELO BLUE (Primario principal)
├─ Color: #007AFF
├─ RGB: 0, 122, 255
├─ Use: CTA buttons, links, highlights
└─ Message: Confianza, profesionalismo

CIELO PURPLE (Secundario, reconfortante)
├─ Color: #7C3AED
├─ RGB: 124, 58, 237
├─ Use: Alternative CTAs, accents
└─ Message: Calidez, protección

CIELO TEAL (Terciario, calmante)
├─ Color: #14B8A6
├─ RGB: 20, 184, 166
├─ Use: Secondary accents
└─ Message: Tranquilidad, bienestar
```

### Semantic Colors (Acciones & Estados)

```
SUCCESS (Éxito, confirmación)
├─ Color: #28A745
├─ RGB: 40, 167, 69
├─ Use: Checkmarks, completion, positivo
└─ Example: "✓ Novedad registrada"

WARNING (Advertencia, atención)
├─ Color: #FFC107
├─ RGB: 255, 193, 7
├─ Use: Caution, pending, alert
└─ Example: "Tarea pendiente"

STREAK (Hito, achievement)
├─ Color: #FF8A00
├─ RGB: 255, 138, 0
├─ Use: Special, achievement, special event
└─ Example: "🔥 Racha de 7 días"

ERROR (Error, crítica)
├─ Color: #DC3545
├─ RGB: 220, 53, 69
├─ Use: Errors, critical, danger
└─ Example: "❌ Situación crítica"

INFO (Información)
├─ Color: #17A2B8
├─ RGB: 23, 162, 184
├─ Use: Information, note
└─ Example: "ℹ️ Nuevo mensaje"
```

### Neutral Colors (Text, Borders, Backgrounds)

```
TEXT / PRIMARY (Main text)
├─ Color: #0D132B
├─ RGB: 13, 19, 43
├─ Use: Primary text, headings
└─ Contrast: WCAG AA

TEXT / SECONDARY (Supporting text)
├─ Color: #6B7280
├─ RGB: 107, 114, 128
├─ Use: Secondary text, disabled, metadata
└─ Contrast: WCAG A

BORDER (Dividers, outlines)
├─ Color: #E5E7EB
├─ RGB: 229, 231, 235
├─ Use: Borders, dividers, separators
└─ Light and subtle

SURFACE (Cards, containers)
├─ Color: #F6F7FB
├─ RGB: 246, 247, 251
├─ Use: Card backgrounds, light surfaces
└─ Slightly blue-tinted

BACKGROUND (Page background)
├─ Color: #FFFFFF
├─ RGB: 255, 255, 255
├─ Use: Main background
└─ Clean, spacious feeling
```

---

## 3. COMPONENTES

### Botones

#### PrimaryButton
```
State: Default
├─ Background: #007AFF (CIELO BLUE)
├─ Text: white, 16px SemiBold
├─ Padding: 12px 24px
├─ Border Radius: 12px
└─ Shadow: 0 4px 12px rgba(0,122,255,0.3)

State: Hover/Active
├─ Background: #0051D5 (darker blue)
└─ Shadow: 0 6px 16px rgba(0,122,255,0.4)

State: Disabled
├─ Background: #E5E7EB
├─ Text: #9CA3AF (disabled gray)
└─ Shadow: none
```

#### SecondaryButton
```
State: Default
├─ Background: transparent
├─ Border: 2px solid #007AFF
├─ Text: #007AFF, 16px SemiBold
├─ Padding: 10px 22px
└─ Border Radius: 12px

State: Hover/Active
├─ Background: rgba(0,122,255,0.08)
└─ Border: 2px solid #0051D5

State: Disabled
├─ Border: 2px solid #E5E7EB
├─ Text: #D1D5DB
└─ Background: #F9FAFB
```

#### CriticalButton (Especial para Situación Crítica)
```
State: Default
├─ Background: #DC3545 (ERROR red)
├─ Text: white, 16px Bold
├─ Padding: 12px 24px
├─ Border Radius: 12px
├─ Shadow: 0 4px 12px rgba(220,53,69,0.3)
└─ Icon: ⚠️

State: Hover/Active
├─ Background: #BB2D3B (darker red)
└─ Shadow: 0 6px 16px rgba(220,53,69,0.4)

Note: Mostrar advertencia previa
```

---

### Cards & Containers

#### ResidentCard
```
Layout:
├─ Photo (60x60, rounded-full)
├─ Name (H4, primary text)
├─ Age (Body Small, secondary text)
├─ Status badge (Success, Warning, or neutral)
└─ Touch target: full card

Styling:
├─ Background: #FFFFFF
├─ Border: 1px solid #E5E7EB
├─ Padding: 16px
├─ Border Radius: 12px
├─ Shadow: 0 1px 3px rgba(0,0,0,0.1)

Example:
[👤] María (12 años) | Active ✓
```

#### ActivityCard
```
Layout:
├─ Type icon (32x32)
├─ Activity name (H4)
├─ Status badge (Pending/Done/Skipped)
├─ Time/Date (Caption, secondary)
└─ Description (Body Small, optional)

Styling:
├─ Background: #FFFFFF
├─ Border: 1px solid #E5E7EB
├─ Padding: 12px
├─ Border Radius: 8px
├─ Shadow: 0 1px 3px rgba(0,0,0,0.08)

Example:
[📖] Lección | At the Café | In Progress ⏳
```

#### AlertCard
```
States:
- Success (green)
- Warning (yellow)
- Error (red)
- Info (blue)

Layout:
├─ Icon (left, colored)
├─ Message (H4 + Body text)
├─ Action button (optional)
└─ Close button (optional)

Styling:
├─ Padding: 16px
├─ Border Radius: 8px
├─ Border: 1px solid (colored, transparent)
├─ Background: colored + 8% opacity
└─ Icon color: match semantic color

Example (Warning):
🔔 "Medicación pendiente - Mariana a las 14:00"
```

---

### Input Fields

#### Text Input
```
State: Default
├─ Background: #F6F7FB
├─ Border: 1px solid #E5E7EB
├─ Padding: 12px 16px
├─ Font: Body Medium
├─ Border Radius: 8px
└─ Placeholder: #9CA3AF (gray)

State: Focus
├─ Border: 2px solid #007AFF
├─ Background: #FFFFFF
└─ Shadow: 0 0 0 3px rgba(0,122,255,0.1)

State: Error
├─ Border: 2px solid #DC3545
├─ Error text: Caption, #DC3545
└─ Below input: "Este campo es obligatorio"
```

#### Password Input (with toggle)
```
Same as Text Input, with:
├─ Eye icon (toggle show/hide)
└─ Icon color: #6B7280 (gray)
```

---

### Progress & Status

#### ProgressBar (Turno)
```
Layout:
├─ Label: "Turno: 8:00 - 16:00"
├─ Progress bar (background: #E5E7EB)
├─ Filled portion: #007AFF or #28A745
├─ Percentage text: "15/20"
└─ Status badge

Styling:
├─ Bar height: 8px
├─ Border Radius: 4px
├─ Animation: smooth transition
└─ Use for: Daily goals, tasks completed
```

#### StatusBadge
```
Success (Green)
├─ Background: #D1FAE5
├─ Text: #065F46, 11px SemiBold
└─ Icon: ✓

Pending (Yellow)
├─ Background: #FEF3C7
├─ Text: #92400E, 11px SemiBold
└─ Icon: ⏳

In Progress (Blue)
├─ Background: #DBEAFE
├─ Text: #1E40AF, 11px SemiBold
└─ Icon: 🔄

Locked (Gray)
├─ Background: #F3F4F6
├─ Text: #6B7280, 11px SemiBold
└─ Icon: 🔒
```

---

### Navigation

#### Tab Navigation (5 tabs)
```
Layout:
├─ Height: 60px (bottom safe area)
├─ 5 equal tabs: Inicio | Residentes | Turno | Crítica | Perfil
├─ Icons: 24x24
├─ Label: Caption (11px)
└─ Active tab highlighted

Styling:
├─ Background: #FFFFFF
├─ Border Top: 1px solid #E5E7EB
├─ Active tab:
│  ├─ Icon color: #007AFF
│  ├─ Label color: #007AFF
│  └─ Bottom border: 3px #007AFF
├─ Inactive tab:
│  ├─ Icon color: #9CA3AF
│  └─ Label color: #9CA3AF

Special: Crítica Tab
├─ Icon color: #DC3545 (rojo)
├─ Label: Bold
└─ Highlight: Distinguido visualmente
```

---

## 4. ESPACIADO & LAYOUT

### Spacing Scale
```
2px   - Micro spacing
4px   - Minimal
8px   - Small
12px  - Medium-small
16px  - Medium (standard)
24px  - Medium-large
32px  - Large
48px  - Extra large
```

### Padding & Margins
```
Screens: 16px padding all sides (mobile safe)
Cards: 12-16px internal padding
Sections: 24px vertical spacing
List items: 12px vertical, 16px horizontal
Buttons: 12px vertical, 24px horizontal
```

---

## 5. SOMBRAS

```
Elevation 1 (Cards, buttons)
├─ box-shadow: 0 1px 3px rgba(0,0,0,0.1)
└─ Use: Standard cards, light elevation

Elevation 2 (Popovers, menus)
├─ box-shadow: 0 4px 12px rgba(0,0,0,0.15)
└─ Use: Floating elements, modals

Elevation 3 (Dialogs, alerts)
├─ box-shadow: 0 10px 25px rgba(0,0,0,0.2)
└─ Use: Top-level dialogs, full-screen modals

Button Active (Interaction)
├─ box-shadow: 0 6px 16px rgba(0,122,255,0.3)
└─ Use: Interactive feedback
```

---

## 6. BORDER RADIUS

```
Micro (Small UI elements)
├─ 4px - Input fields (subtle)
└─ Use: Minimal rounding

Standard (Most components)
├─ 8px - Cards, containers, buttons
└─ Use: Default, comfortable rounding

Medium (Larger components)
├─ 12px - Buttons, large cards
└─ Use: Prominent elements

Large (Full rounding)
├─ 50% - Avatars, circular elements
└─ Use: User photos, icons
```

---

## 7. ESTADOS & INTERACTIONS

### Button States
```
Default → Hover → Pressed → Disabled
Cambios:
├─ Color (darker on interaction)
├─ Shadow (larger on press)
└─ Opacity (reduced if disabled)
```

### Loading State
```
├─ Spinner icon (centered)
├─ Message: "Cargando..." (optional)
├─ Opacity: 60%
└─ Animation: smooth rotation
```

### Empty State
```
├─ Icon (large, 64x64)
├─ Title (H3)
├─ Description (Body Small)
├─ Optional CTA button
└─ Centered on screen
```

### Error State
```
├─ Error icon (red)
├─ Error message (Body Medium, red)
├─ Error details (Body Small, gray)
├─ "Reintentar" button
└─ Optional dismiss button
```

---

## 8. ANIMACIONES & TRANSITIONS

### Timing
```
Fast: 150ms (hover, small elements)
Standard: 300ms (page transitions, cards)
Slow: 500ms (major state changes)
```

### Easing
```
In-Out: ease (standard, smooth)
Out: easeOut (appear animations)
In: easeIn (disappear animations)
```

### Animations
```
Fade: opacity change
Slide: position change (from edge)
Scale: size change
Bounce: emphasis (micro-interactions)
```

---

## 9. DARK MODE (FUTURE)

**Para versión futura (no MVP):**

```
Background: #1A1A1A
Surface: #2D2D2D
Text Primary: #FFFFFF
Text Secondary: #B0B0B0
Border: #404040
Accent: #007AFF (mismo)
```

---

## 10. RESPONSIVE BREAKPOINTS

```
Mobile (320px - 480px): Full width
Small (481px - 768px): Constrained width
Medium (769px+): Tablet/larger
```

**Nota:** Cielo Móvil es mobile-first, pero compatible con tablets.

---

## 11. ICONO STYLE GUIDE

**Si se reutilizan íconos de Lingua:**

```
Size: 24x24 (default)
         32x32 (large)
         16x16 (small)
         64x64 (hero)

Color: Match semantic color or neutral
Style: Outline (not filled)
Weight: 2px line weight
```

**Íconos Cielo Móvil:**
```
Bottom Nav Icons:
├─ Home: 🏠
├─ Residentes: 👥
├─ Turno: 📋
├─ Crítica: ⚠️
└─ Perfil: 👤

Action Icons:
├─ Agregar: ➕
├─ Editar: ✏️
├─ Eliminar: 🗑️
├─ Guardar: ✓
├─ Cancelar: ✕
├─ Atrás: ←
├─ Adelante: →
├─ Más: ⋯
├─ Búsqueda: 🔍
├─ Menú: ☰
├─ Notifications: 🔔
├─ Chat: 💬
└─ Configuración: ⚙️

Status Icons:
├─ Completado: ✓ (green)
├─ Pendiente: ⏳ (yellow)
├─ En Progreso: 🔄 (blue)
├─ Bloqueado: 🔒 (gray)
├─ Crítico: ⚠️ (red)
└─ Online: 🟢 (green)
```

---

## 12. TAILWIND CSS UTILITIES

**Para Cielo Móvil (usando NativeWind):**

```
Colors:
- Primary: bg-blue-500, text-blue-500
- Secondary: bg-purple-500, text-purple-500
- Success: bg-green-500, text-green-500
- Warning: bg-yellow-500, text-yellow-500
- Error: bg-red-500, text-red-500

Text:
- Heading 1: text-3xl font-bold
- Heading 2: text-2xl font-semibold
- Body: text-base font-normal
- Caption: text-xs font-normal

Spacing:
- px-4 (16px horizontal)
- py-3 (12px vertical)
- gap-3 (12px between items)

Shadows:
- shadow (elevation 1)
- shadow-md (elevation 2)
- shadow-lg (elevation 3)

Rounded:
- rounded (8px)
- rounded-lg (12px)
- rounded-full (50%)
```

---

## 13. ACCESIBILIDAD

### WCAG AA Compliance

```
✅ Color contrast ratio ≥ 4.5:1 (normal text)
✅ Color contrast ratio ≥ 3:1 (large text)
✅ Touch targets ≥ 48x48 (mobile)
✅ Font sizes ≥ 16px (mobile readability)
✅ Line height ≥ 1.5
✅ Focus states visible
✅ Semantic HTML (buttons, inputs, etc)
✅ Alt text for images
✅ Keyboard navigation
```

---

## 14. CASO DE USO: Pantalla de Residentes

**Ejemplo de aplicación del Design System:**

```
┌─────────────────────────────────────┐
│ RESIDENTES              [Settings]  │  ← H1, Header
├─────────────────────────────────────┤
│                                     │
│ 👤 María García      [Age: 12]  ✓  │  ← Card
│ 👤 Juan Pérez        [Age: 14]  ✓  │
│ 👤 Sofia López       [Age: 11]  🔄 │
│                                     │
│ [Primary Button: Nueva novedad]     │
│                                     │
└─────────────────────────────────────┘
│ Home │ Resid... │ Turno │ Crítica │ │ ← Bottom Nav
```

---

**Design System completo para Cielo Móvil MVP.** ✅
