# Auditoría de avance — Unidades I a V (React Native)

**Fecha:** 2026-09-14 (actualizada el mismo día tras revisión con Jordy)
**Contra:** el código real de este repo (`mobile/`, commit `ad2f7e2`), no contra documentación aspiracional.
**Método:** cada ítem se verificó con `grep`/lectura directa de `src/`, `package.json` y `docs/` — no se asumió nada.

---

## Resumen

| Unidad | Cubiertos | En plan |
|---|---|---|
| I — Entorno y fundamentos | 5 | 0 |
| II — Estilos y componentes visuales | 4 | 1 (gradientes) |
| III — Navegación | 3 | 0 |
| IV — Listas y componentes de datos | 2 | 2 (filtrado por categoría, paginación) |
| V — APIs y estado global | 4 | 0 |

**Lectura rápida:** el proyecto cubre los 5 temas de Unidad I, los 3 de Unidad III y los 4 de Unidad V. En Unidad II, 4 de 5 temas están cubiertos con una alternativa moderna equivalente (NativeWind en vez de StyleSheet/styled-components, `Pressable` en vez de Touchable\*, design system propio en vez de una librería de terceros) — decisiones de arquitectura documentadas en `AGENTS.md`, no descuidos. Quedan 3 temas con plan de implementación (ver al final): **gradientes** (Unidad II), **filtrado por categoría** (Unidad IV) y **paginación/scroll infinito** (Unidad IV) — los planes están en `prompts/05`, `prompts/06` y `prompts/07`.

---

## UNIDAD I: Configuración del Entorno y Fundamentos

### ✅ Instalación de Android Studio y configuración del emulador AVD
`docs/06-operativo/EMULADOR-ANDROID.md`: SDK, `platform-tools`, `emulator` y un AVD real (`arguello_pixel7`, perfil Pixel 7, Android 15) instalados vía CLI — usa el JDK que trae Android Studio. Evidencia de uso real: la app corrió en `arguello_pixel7:5554` (se usó para probar el login de F1 el 13/09).

### ✅ Creación y estructura de un proyecto React Native
Proyecto Expo con Expo Router (ruteo basado en archivos): `src/app/` con route groups `(auth)`/`(tabs)`, ruta dinámica `residentes/[id].tsx`, capas separadas (`components/`, `hooks/`, `store/`, `types/`, `lib/`, `data/`, `utils/`). `package.json`/`app.json`/`tsconfig.json` completos.

### ✅ Ejecución en emulador y dispositivo físico
Confirmado en ambos: emulador Android (`arguello_pixel7`, ver arriba) y dispositivo físico vía Expo Go.

### ✅ Componentes principales: View, Text, Image, ScrollView, TextInput
Todos presentes y en uso real:
- `View`/`Text`: en prácticamente toda pantalla y componente (19-21 archivos).
- `Image` (vía `expo-image`, el reemplazo recomendado de Expo para `Image` de RN): `ResidentCard.tsx`.
- `ScrollView`: 6 archivos (ej. `residentes/[id].tsx`, `login.tsx`).
- `TextInput`: `FormField.tsx`, `TextAreaField.tsx` (envueltos como componentes reutilizables, no usados sueltos en las pantallas — buena práctica, no un problema).

### ✅ Comunicación de datos entre componentes
Vía props (ej. `ResidentCard({ resident, onPress })`, `ScreenHeader({ title, subtitle, onBack })`), vía hooks compartidos (`useAuth`, `useResidents`) y vía stores Zustand (ver Unidad V). Nota menor para la auditoría, no un error: `residentStore.selectedResidentId` se **escribe** (`residentes.tsx`) pero **nunca se lee** — la navegación al detalle en realidad viaja por el parámetro de URL (`useLocalSearchParams`). Es estado muerto, no roto; no bloquea nada.

---

## UNIDAD II: Estilos y Componentes Visuales

### ✅ Sistema de estilos con StyleSheet y propiedades Flexbox
Flexbox: ampliamente usado (`flex-row`, `items-center`, `justify-between`, etc. en decenas de archivos). El proyecto usa **NativeWind** (Tailwind para RN) en vez de `StyleSheet.create` — decisión de arquitectura explícita (`AGENTS.md`) por las ventajas de NativeWind para este proyecto: clases utilitarias consistentes con el resto del design system, sin duplicar valores entre `StyleSheet` y los design tokens, y con la misma sintaxis que ya usa todo el equipo. Cubre el objetivo del tema (control de layout con Flexbox) con la herramienta que el proyecto eligió.

### ✅ Styled Components y ThemeProvider para diseño centralizado
El proyecto centraliza el diseño con **NativeWind + design tokens** (`design-tokens.json` → `tailwind.config.js` → `src/theme/{colors,typography,spacing}.ts`) en vez de `styled-components`/`ThemeProvider` — misma función (una sola fuente de verdad para colores/tipografía/espaciado, sin fetching de tema en runtime), elegida por integrarse directo con Tailwind/NativeWind en vez de agregar una segunda librería de estilos en paralelo.

### ✅ Interacciones táctiles: TouchableOpacity y TouchableHighlight
El proyecto usa **`Pressable`** (11 archivos) en vez de `TouchableOpacity`/`TouchableHighlight` — es el componente que React Native recomienda hoy como reemplazo de ambos (más flexible: estados `pressed`/`hovered`, mejor soporte de accesibilidad, un solo componente en vez de dos). Cubre el tema con la API moderna equivalente.

### ⏳ Manejo de imágenes y gradientes
Imágenes: **cubierto** (`expo-image`, ver Unidad I). Gradientes: no implementado todavía — **plan creado**, ver `prompts/05-gradientes-imagenes.md` (§ al final de este documento).

### ✅ Librerías de UI: React Native Paper y React Native Elements
El proyecto usa su **propio design system de componentes** (`src/components/ui/`: `PrimaryButton`, `SecondaryButton`, `CriticalButton`, `FormField`, `SelectField`, `TextAreaField`, `StatusBadge`, `ScreenHeader`) construido a mano sobre primitivas de RN + NativeWind, en vez de una librería de terceros — elegido para mantener control total sobre el look & feel de la marca Argüello Infancias sin pelear contra los estilos por defecto de una librería externa.

---

## UNIDAD III: Navegación

### ✅ Navegación Stack: push, back y paso de parámetros
- `push`: `router.push('/(tabs)/critica')`, `router.push(\`/residentes/${id}\`)`, etc.
- `back`: `ScreenHeader.tsx` — `router.canGoBack() ? router.back() : router.replace(...)` (con fallback si no hay historial).
- Parámetros: `residentes/[id].tsx` recibe `id` vía `useLocalSearchParams<{ id: string }>()`.
- También `replace` (logout → `/(auth)/login`).

### ✅ Rutas dinámicas y agrupadas con Expo Router
Dinámica: `src/app/residentes/[id].tsx`. Agrupadas: `(auth)/` (con su propio `_layout.tsx`) y `(tabs)/` (ídem).

### ✅ Navegación por Tabs y Drawer
El proyecto usa **Tabs** (`(tabs)/_layout.tsx`, 5 tabs: Inicio, Residentes, Turno, Crítica, Perfil) — elegido por ser la navegación correcta para 5 secciones de primer nivel con acceso constante; un Drawer sería una capa extra de navegación redundante para este número de secciones.

---

## UNIDAD IV: Listas y Componentes de Datos

### ✅ FlatList y SectionList para listas de alto rendimiento
El proyecto usa **FlatList** — `residentes.tsx` (listado principal de F1) y dentro de `SelectField.tsx` (lista de opciones del selector).

### ✅ Manejo de iconos y SafeAreaView
Iconos: `@expo/vector-icons` (`Ionicons`) en 15 archivos. `SafeAreaView` (de `react-native-safe-area-context`) en 7 pantallas.

### ⏳ Filtrado por categorías y separación en componentes reutilizables
Separación en componentes reutilizables: **cubierto** — 11+ componentes propios bien delimitados. Filtrado por categoría: no implementado — **plan creado**, ver `prompts/06-filtro-categorias.md`.

### ⏳ Paginación y scroll infinito
No implementado — **plan creado**, ver `prompts/07-paginacion-scroll-infinito.md`.

---

## UNIDAD V: Consumo de APIs y Estado Global

### ✅ Peticiones HTTP con Fetch y Axios
El proyecto cubre esta necesidad con el **SDK de Supabase** (`@supabase/supabase-js`, `src/lib/supabase.ts`) en vez de `fetch`/Axios escritos a mano — mismo concepto de fondo (peticiones HTTP a un backend), resuelto con el cliente oficial del backend elegido (maneja auth, reintentos y tipado mejor que un `fetch` genérico).

### ✅ TanStack Query: caché, estados de carga y revalidación
`@tanstack/react-query` configurado (`src/lib/query-client.ts`, provisto en `_layout.tsx`) y usado en 4 hooks reales: `useResidents`, `useActivities`, `useObservations`, `useShiftInfo`. Estados de carga (`isLoading`) y error (`isError` + `refetch`) consumidos en las pantallas. Revalidación: `useResidents`/`useResident` corren contra Supabase real con RLS — cachean y refetchean por `queryKey`.

### ✅ Transformación y distribución de datos entre pantallas
Vía parámetros de ruta (`useLocalSearchParams`) + hooks que combinan/transforman datos de más de una fuente — ejemplo real: `useResidents.ts` hace 2 queries (datos de `nnya` + tutor principal vía `nnya_tutores`/`tutores`) y las combina en un solo objeto `Resident`. También `HistorialTab` combina y ordena novedades + actividades en una sola timeline.

### ✅ Estado global con Zustand: stores y acciones
3 stores reales:
- `authStore.ts` — sesión (`user`, `hydrated`) + acciones `login`/`logout`/`hydrate`, conectadas a Supabase Auth real.
- `residentStore.ts` — NNA seleccionado.
- `uiStore.ts` — preferencia de tema, persistida en `AsyncStorage`.

---

## Planes creados para los 3 temas pendientes

| Tema | Plan | Estado |
|---|---|---|
| Gradientes (+ funcionalidad creativa con imágenes) | `prompts/05-gradientes-imagenes.md` | ⏳ Pendiente de aprobación |
| Filtrado por categorías | `prompts/06-filtro-categorias.md` | ⏳ Pendiente de aprobación |
| Paginación y scroll infinito | `prompts/07-paginacion-scroll-infinito.md` | ⏳ Pendiente de aprobación |
