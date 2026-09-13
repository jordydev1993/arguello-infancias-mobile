# Auditoría de avance — Unidades I a V (React Native)

**Fecha:** 2026-09-14
**Contra:** el código real de este repo (`mobile/`, commit `ec055df`), no contra documentación aspiracional.
**Método:** cada ítem se verificó con `grep`/lectura directa de `src/`, `package.json` y `docs/` — no se asumió nada.

---

## Resumen

| Unidad | Cubiertos | Parciales / con matiz | Faltantes |
|---|---|---|---|
| I — Entorno y fundamentos | 4 | 1 | 0 |
| II — Estilos y componentes visuales | 1 | 2 | 2 |
| III — Navegación | 2 | 0 | 1 |
| IV — Listas y datos | 2 | 1 | 2 |
| V — APIs y estado global | 2 | 2 | 0 |

**Lectura rápida:** el proyecto está sólido en navegación, listas básicas, TanStack Query y Zustand. Los huecos reales están concentrados en **Unidad II** (librerías de UI de terceros, gradientes, la API `StyleSheet` literal) y en **Unidad IV** (filtrado por categoría, paginación/scroll infinito, `SectionList`) — ninguno bloquea el proyecto, pero si la cátedra evalúa estos puntos puntuales, hoy no están.

---

## UNIDAD I: Configuración del Entorno y Fundamentos

### ✅ Instalación de Android Studio y configuración del emulador AVD
`docs/06-operativo/EMULADOR-ANDROID.md`: SDK, `platform-tools`, `emulator` y un AVD real (`arguello_pixel7`, perfil Pixel 7, Android 15) instalados vía CLI — usa el JDK que trae Android Studio (`C:\Program Files\Android\Android Studio\jbr`), así que Android Studio está instalado, aunque el setup del SDK/AVD se hizo por línea de comandos en vez de por la UI de Android Studio. Evidencia de uso real: la app corrió en `arguello_pixel7:5554` (se usó para probar el login de F1 el 13/09).

### ✅ Creación y estructura de un proyecto React Native
Proyecto Expo con Expo Router (ruteo basado en archivos): `src/app/` con route groups `(auth)`/`(tabs)`, ruta dinámica `residentes/[id].tsx`, capas separadas (`components/`, `hooks/`, `store/`, `types/`, `lib/`, `data/`, `utils/`). `package.json`/`app.json`/`tsconfig.json` completos.

### ⚠️ Ejecución en emulador y dispositivo físico
Emulador: confirmado (ver arriba). **Dispositivo físico**: no hay evidencia en el repo de haberlo probado en un teléfono real (ni con Expo Go ni con un build). No es necesariamente un problema — pero si la cátedra pide evidencia de ambos, falta la de dispositivo físico.

### ✅ Componentes principales: View, Text, Image, ScrollView, TextInput
Todos presentes y en uso real:
- `View`/`Text`: en prácticamente toda pantalla y componente (19-21 archivos).
- `Image` (via `expo-image`, el reemplazo recomendado de Expo para `Image` de RN): `ResidentCard.tsx`.
- `ScrollView`: 6 archivos (ej. `residentes/[id].tsx`, `login.tsx`).
- `TextInput`: `FormField.tsx`, `TextAreaField.tsx` (envueltos como componentes reutilizables, no usados sueltos en las pantallas — buena práctica, no un problema).

### ✅ Comunicación de datos entre componentes
Vía props (ej. `ResidentCard({ resident, onPress })`, `ScreenHeader({ title, subtitle, onBack })`), vía hooks compartidos (`useAuth`, `useResidents`) y vía stores Zustand (ver Unidad V). Dato para la auditoría, no un error: `residentStore.selectedResidentId` se **escribe** (`residentes.tsx`) pero **nunca se lee** en ningún lado — la navegación al detalle en realidad viaja por el parámetro de URL (`useLocalSearchParams`), no por ese store. Es estado muerto, no roto.

---

## UNIDAD II: Estilos y Componentes Visuales

### ⚠️ Sistema de estilos con StyleSheet y propiedades Flexbox
**Flexbox: sí**, ampliamente (`flex-row`, `items-center`, `justify-between`, etc. en decenas de archivos). **`StyleSheet.create`: cero usos** — es una decisión de arquitectura explícita, no un olvido: `AGENTS.md` prohíbe expresamente `StyleSheet` ("usar NativeWind, no StyleSheet"). Todo el proyecto estiliza con clases de Tailwind vía NativeWind (`className="..."`). Si la cátedra pide específicamente la API `StyleSheet.create({...})`, no aparece en ningún archivo.

### ❌ Styled Components y ThemeProvider para diseño centralizado
No instalado (`styled-components` no está en `package.json`), cero usos de `ThemeProvider`. El proyecto sí tiene diseño centralizado, pero con otra tecnología: `design-tokens.json` → `tailwind.config.js` → `src/theme/{colors,typography,spacing}.ts` (wrapper TS de los mismos tokens). Cumple el objetivo de fondo (una sola fuente de verdad para colores/tipografía/espaciado) pero no con las herramientas nombradas en el programa.

### ⚠️ Interacciones táctiles: TouchableOpacity y TouchableHighlight
Ninguno de los dos se usa. El proyecto usa **`Pressable`** (11 archivos) — es el componente que React Native recomienda hoy como reemplazo de ambos (más flexible, mismo propósito). Cubre el concepto, no la API literal que pide el programa.

### ⚠️ Manejo de imágenes y gradientes
Imágenes: sí (`expo-image`, ver Unidad I). **Gradientes: cero usos** — no está instalado `expo-linear-gradient` ni ninguna librería de gradientes, y no hay ningún gradiente en el diseño actual (los fondos son sólidos, con tokens de color planos).

### ❌ Librerías de UI: React Native Paper y React Native Elements
Ninguna de las dos está instalada. El proyecto tiene su propio design system de componentes (`src/components/ui/`: `PrimaryButton`, `SecondaryButton`, `CriticalButton`, `FormField`, `SelectField`, `TextAreaField`, `StatusBadge`, `ScreenHeader`) construido a mano sobre primitivas de RN + NativeWind, no sobre una librería de terceros.

---

## UNIDAD III: Navegación

### ✅ Navegación Stack: push, back y paso de parámetros
- `push`: `router.push('/(tabs)/critica')`, `router.push(\`/residentes/${id}\`)`, etc.
- `back`: `ScreenHeader.tsx` — `router.canGoBack() ? router.back() : router.replace(...)` (con fallback si no hay historial, buena práctica).
- Parámetros: `residentes/[id].tsx` recibe `id` vía `useLocalSearchParams<{ id: string }>()`.
- También `replace` (logout → `/(auth)/login`).

### ✅ Rutas dinámicas y agrupadas con Expo Router
Dinámica: `src/app/residentes/[id].tsx`. Agrupadas: `(auth)/` (con su propio `_layout.tsx`) y `(tabs)/` (idem) — los paréntesis excluyen el segmento de la URL, patrón correcto de Expo Router.

### ⚠️ Navegación por Tabs y Drawer
**Tabs: sí** — `(tabs)/_layout.tsx` define 5 tabs (Inicio, Residentes, Turno, Crítica, Perfil). **Drawer: no implementado** — no hay `@react-navigation/drawer` instalado ni ningún uso. Con 5 secciones, un Tabs es la elección de UX correcta y un Drawer sería redundante — pero si el programa pide demostrar la API de Drawer específicamente, no está.

---

## UNIDAD IV: Listas y Componentes de Datos

### ⚠️ FlatList y SectionList para listas de alto rendimiento
**FlatList: sí** — `residentes.tsx` (listado principal de F1) y dentro de `SelectField.tsx` (lista de opciones del selector). **SectionList: no se usa.** El caso que más se le parece —el historial agrupado por día en `HistorialTab` (F3, `residentes/[id].tsx`)— agrupa a mano con `agruparPorDia()` (`utils/formatters.ts`) y lo renderiza con `.map()` anidado dentro de un `ScrollView`, en vez de usar el componente `SectionList` real. Funciona, pero no es la API que pide el programa, y con más de unos pocos días de historial pierde el beneficio de rendimiento que `SectionList` da (virtualización).

### ✅ Manejo de iconos y SafeAreaView
Iconos: `@expo/vector-icons` (`Ionicons`) en 15 archivos. `SafeAreaView` (de `react-native-safe-area-context`, la versión correcta — no la de `react-native` core, deprecada) en 7 pantallas.

### ❌ Filtrado por categorías y separación en componentes reutilizables
**Separación en componentes reutilizables: fuerte** — 11+ componentes propios bien delimitados (`ResidentCard`, `ActivityCard`, `AlertCard`, `EmptyState`, `ErrorState`, `LoadingState`, badges, botones, campos de formulario). **Filtrado por categoría: no implementado en ningún lado** — ni en el listado de residentes, ni en los mocks de novedades/actividades (que sí tienen categorías definidas — `OBSERVATION_CATEGORY_LABELS`, `tipo_actividad`— pero ninguna pantalla ofrece filtrar por ellas todavía).

### ❌ Paginación y scroll infinito
No implementado. Ninguna `FlatList` usa `onEndReached`/`onEndReachedThreshold`, no hay `useInfiniteQuery` de TanStack Query en ningún hook. Las listas actuales (5 NNA mock, pocas novedades/actividades mock) no lo necesitan todavía en volumen real, pero la técnica no está demostrada en el código.

---

## UNIDAD V: Consumo de APIs y Estado Global

### ⚠️ Peticiones HTTP con Fetch y Axios
**Axios: no instalado** (de hecho prohibido explícitamente: `AGENTS.md` → "❌ Axios (solo fetch)"). **Fetch: no aparece como código propio tampoco** — no hay ningún `fetch(...)` escrito a mano en `src/`. Todas las peticiones HTTP reales pasan por el SDK `@supabase/supabase-js` (`src/lib/supabase.ts`), que internamente usa `fetch`, pero esa llamada queda encapsulada dentro de la librería, no es código del alumno. Si el programa pide ver un `fetch()` explícito, hoy no hay ninguno — es una consecuencia directa de haber decidido "cliente Supabase directo" en vez de una capa de API propia (decisión #4 del proyecto).

### ✅ TanStack Query: caché, estados de carga y revalidación
`@tanstack/react-query` configurado (`src/lib/query-client.ts`, provisto en `_layout.tsx`) y usado en 4 hooks reales: `useResidents`, `useActivities`, `useObservations`, `useShiftInfo`. Estados de carga (`isLoading`) y error (`isError` + `refetch`) consumidos en las pantallas (`LoadingState`, `ErrorState` con botón de reintento). Revalidación: `useResidents`/`useResident` corren contra Supabase real con RLS — cachean y refetchean por `queryKey` de forma estándar.

### ✅ Transformación y distribución de datos entre pantallas
Vía parámetros de ruta (`useLocalSearchParams`) + hooks que combinan/transforman datos de más de una fuente antes de mostrarlos — ejemplo real: `useResidents.ts` hace 2 queries (datos de `nnya` + tutor principal vía `nnya_tutores`/`tutores`) y las combina en un solo objeto `Resident` con `contacto_emergencia` armado a mano. También `HistorialTab` combina y ordena novedades + actividades en una sola timeline.

### ✅ Estado global con Zustand: stores y acciones
3 stores reales, cada uno con su propósito claro:
- `authStore.ts` — sesión (`user`, `hydrated`) + acciones `login`/`logout`/`hydrate`, ahora conectadas a Supabase Auth real.
- `residentStore.ts` — NNA seleccionado (ver nota de Unidad I: hoy no se lee en ningún lado).
- `uiStore.ts` — preferencia de tema, persistida en `AsyncStorage`.

---

## Qué falta — priorizado

Si tenés que elegir qué cerrar antes de una entrega, en este orden:

1. **Filtrado por categoría** (Unidad IV) — es la pieza más chica y más reutilizable: aplica directo a F2 (novedades) y F4 (actividades) cuando se construyan esas pantallas (issues #11/#12).
2. **`fetch()` explícito o Axios** (Unidad V) — si la cátedra necesita verlo literal, la opción más simple sin romper nada es un `fetch()` de ejemplo en algún lugar no crítico (ej. una llamada a un endpoint público de prueba), documentado como demostración del concepto.
3. **`SectionList`** (Unidad IV) — reemplazar el agrupado manual de `HistorialTab` por un `SectionList` real es un cambio acotado a un solo archivo.
4. **Paginación/scroll infinito** (Unidad IV) — más relevante una vez que F1 tenga volumen real de NNA (hoy 5 en mock).
5. **Gradientes + una librería de UI (Paper/Elements)** (Unidad II) — los más opcionales: el proyecto ya tiene su propio design system funcionando; agregar estos sería más para "demostrar que se sabe usar la herramienta" que una necesidad real del producto.
6. **`StyleSheet`/styled-components/`ThemeProvider`/Touchable\* literales** (Unidad II) — no recomendado tocarlos: son decisiones de arquitectura ya tomadas y documentadas (`AGENTS.md`) con alternativas modernas equivalentes (NativeWind, `Pressable`). Si la cátedra los exige literalmente, es una conversación de "qué se evalúa" más que una tarea de código.
7. **Evidencia de prueba en dispositivo físico** (Unidad I) — más un tema de captura/documentación que de código: correr `npx expo start` y escanear el QR con Expo Go en un teléfono, y dejar constancia (captura o nota).
