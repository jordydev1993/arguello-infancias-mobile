# Discurso — Exposición del desarrollo (Unidades I a V)

**Para:** exposición oral, Laboratorio 2 (61N)
**Proyecto:** Argüello Infancias Mobile
**Basado en:** `AUDITORIA-UNIDADES-REACT-NATIVE.md` (auditoría real contra el código, 2026-09-14)
**Duración estimada:** 9-10 minutos entre los 4

## Reparto (4 analistas)

Repartido por rol, para que cada quien hable de lo que efectivamente construyó — y contiguo, sin ir y volver al micrófono:

| Quién | Habla de | ~Tiempo |
|---|---|---|
| **Jordy** (Producto / arquitectura) | Apertura + Unidad I | ~1:40 |
| **Cami** (UI/UX) | Unidad II + Plan 05 (Gradientes) | ~2:30 |
| **Meli** (QA) | Unidad III + Unidad IV + Plan 06 (Filtro por categoría) + Plan 07 (Paginación) | ~3:00 |
| **Sofi** (BD + análisis funcional) | Unidad V + Cierre | ~2:00 |

---

## Apertura — Jordy

Buenas. Venimos a contarles cómo construimos Argüello Infancias Mobile, la app que le da al personal de la residencia una forma de acompañar el día a día de cada NNA desde el celular: consultar quién está a cargo, registrar novedades, actividades y, si hace falta, reportar una situación crítica.

No les vamos a mostrar una lista de funcionalidades y ya — les vamos a contar **qué decisiones tomamos y por qué**, unidad por unidad, con evidencia real del código, no de lo que dice la documentación. De hecho, antes de esta exposición hicimos una auditoría completa del repositorio comparando lo que promete cada documento contra lo que el código realmente hace — y varias cosas que en un momento parecían huecos, en realidad eran decisiones de arquitectura ya tomadas con una alternativa mejor. Se los vamos a mostrar así, con la justificación de cada una.

---

## Unidad I — Configuración del entorno y fundamentos — Jordy

Arrancamos con un proyecto Expo con React Native, usando Expo Router — que es ruteo basado en archivos: cada pantalla es un archivo dentro de `src/app/`, agrupadas en `(auth)` para login y `(tabs)` para la app principal, con una ruta dinámica para el detalle de cada residente.

El entorno lo armamos con Android Studio y un emulador Android real, configurado por línea de comandos — un Pixel 7 corriendo Android 15 — y lo probamos tanto en ese emulador como en dispositivo físico con Expo Go.

Sobre los componentes base de React Native — `View`, `Text`, `Image`, `ScrollView`, `TextInput` — los usamos todos, pero no sueltos: los envolvimos en componentes propios reutilizables. Por ejemplo, nunca vamos a encontrar un `TextInput` desnudo en una pantalla — siempre está adentro de nuestro `FormField`, que le agrega la etiqueta, la validación y el manejo de error. Esa es también nuestra respuesta a "comunicación de datos entre componentes": todo viaja por props tipadas — un componente como `ResidentCard` recibe el residente y una función `onPress`, no adivina nada por su cuenta.

*(Acá le paso la palabra a Cami, que se encarga de todo el sistema visual.)*

---

## Unidad II — Estilos y componentes visuales — Cami

Acá es donde tomamos las decisiones de arquitectura más marcadas, y las vamos a defender una por una.

**En vez de `StyleSheet` de React Native, usamos NativeWind** — Tailwind adaptado a React Native. La razón: con `StyleSheet` cada pantalla termina con su propio objeto de estilos, y mantener consistencia visual entre 20 pantallas se vuelve un problema de copiar y pegar valores. Con NativeWind, todo el equipo escribe las mismas clases utilitarias que ya usamos en la web del proyecto, y el layout con Flexbox lo seguimos usando igual — `flex-row`, `items-center`, `justify-between` — solo que expresado como clases en vez de como objeto JavaScript.

**En vez de Styled Components y `ThemeProvider`, centralizamos el diseño con design tokens** — un solo archivo `design-tokens.json` con los colores, tipografías y espaciados de la marca, que alimenta tanto la configuración de Tailwind como una capa en TypeScript para los pocos casos donde hace falta un color como string plano, por ejemplo el ícono de un botón. Mismo objetivo que un `ThemeProvider` — una sola fuente de verdad — pero sin agregar una segunda librería de estilos corriendo en paralelo a la que ya elegimos.

**En vez de `TouchableOpacity` y `TouchableHighlight`, usamos `Pressable`** en toda la app — es el componente que el propio equipo de React Native recomienda hoy como reemplazo de los dos, con mejor soporte de accesibilidad y más control sobre los distintos estados de una interacción táctil.

Y en vez de traer React Native Paper o React Native Elements, **construimos nuestro propio sistema de componentes** — botones, badges de estado, campos de formulario — pensado específicamente para la identidad visual de Argüello Infancias, sin pelear contra los estilos por defecto de una librería ajena.

Lo único que nos faltaba acá eran gradientes, y ya lo tenemos resuelto en el papel: **Plan 05**, escrito y esperando aprobación. Convertimos la tarjeta de "Turno de hoy" en la pantalla de Inicio en un hero card con gradiente, donde el color cambia según el estado del turno — si está activo, combina los dos colores de marca del proyecto, azul y púrpura, que hoy, sorprendentemente, no se combinan en ningún otro lado de la interfaz. El gradiente no es decoración: comunica de un vistazo si estás de turno ahora mismo.

*(Le paso la palabra a Meli, que va a hablar de navegación y de cómo garantizamos que las listas de datos funcionen bien.)*

---

## Unidad III — Navegación — Meli

Toda la navegación Stack la resolvimos con Expo Router: `push` para avanzar, `back` con una salvaguarda — si no hay una pantalla anterior en el historial, en vez de romper, te manda al inicio — y paso de parámetros por URL, como el id del residente que viaja al entrar al detalle.

Las rutas son dinámicas y agrupadas: la carpeta `residentes/[id]` genera automáticamente una ruta por cada NNA, y los grupos `(auth)` y `(tabs)` organizan las pantallas sin que ese agrupamiento aparezca en la URL final.

Para la navegación principal elegimos Tabs — cinco secciones de acceso constante: Inicio, Residentes, Turno, situación Crítica y Perfil. No usamos un Drawer, y es una decisión deliberada: con cinco secciones, un Drawer agrega una capa de navegación extra sin necesidad real.

## Unidad IV — Listas y componentes de datos — Meli

Usamos `FlatList` para el listado principal de residentes y en el selector de opciones de nuestros formularios — listas virtualizadas, que no renderizan de más.

Para íconos usamos la librería de vectores de Expo, y en cada pantalla usamos `SafeAreaView` para respetar los márgenes seguros del dispositivo — notch, barra de estado, gestos del sistema.

En separación de componentes reutilizables estamos fuertes: tenemos más de once componentes propios bien delimitados, cada uno con una responsabilidad clara.

Ahora, con honestidad, desde el lado de QA: **filtrado por categoría y paginación con scroll infinito todavía no estaban implementados** cuando hicimos la auditoría. Ya están planeados los dos:

**Plan 06 — Filtro por categoría.** En la pestaña de Novedades del detalle de residente, agregamos una fila de chips filtrables por categoría — conducta, emocional, educativo, sanitario, otro — con un componente genérico que después va a servir para cualquier otra lista categorizada que construyamos.

**Plan 07 — Paginación y scroll infinito.** El listado de residentes pasa de traer todo de una vez a pedir de a páginas, usando `useInfiniteQuery` de TanStack Query contra Supabase. Hoy, con pocos residentes de ejemplo, no se va a notar visualmente — pero el mecanismo ya está diseñado y va a escalar solo cuando el dataset real crezca. Como QA, esto es justamente lo que nos interesa dejar preparado antes de tener volumen real de datos, no después.

Los dos están escritos como planes formales, con archivos exactos a tocar y criterios de aceptación, esperando aprobación.

*(Le paso la palabra a Sofi, que cierra con datos y estado global.)*

---

## Unidad V — Consumo de APIs y estado global — Sofi

Acá también tomamos una decisión de arquitectura que vale explicar: **en vez de escribir `fetch` o usar Axios a mano, todas nuestras peticiones HTTP pasan por el cliente oficial de Supabase**, que es nuestro backend. Por debajo, ese cliente usa `fetch`, pero no lo escribimos nosotros llamada por llamada — usamos la librería oficial porque nos resuelve autenticación, tipado y reintentos de una forma mucho más robusta que armarlo a mano.

Para el manejo de datos del servidor usamos **TanStack Query** en los cuatro hooks principales de la app — nos da caché, estados de carga y error ya resueltos, y revalidación automática. Cuando falla una consulta, no se rompe la pantalla: aparece un estado de error con un botón de reintentar.

Y para el estado que vive en el cliente, no en el servidor, usamos **Zustand** — tres stores: uno de sesión, conectado hoy a la autenticación real de Supabase; uno para el residente seleccionado; y uno para la preferencia de tema, que persiste entre sesiones.

Un ejemplo concreto de transformación de datos entre pantallas: cuando pedimos el detalle de un residente, no traemos una sola tabla — combinamos los datos del NNA con los de su tutor principal, que vive en otra tabla relacionada, y armamos un solo objeto listo para mostrar en la pantalla. Eso pasa en un hook, no en la pantalla — la pantalla solo consume el resultado ya armado.

---

## Cierre — Sofi

En resumen: cubrimos los cinco temas del programa, y donde elegimos una herramienta distinta a la nombrada en la cátedra, fue una decisión consciente, documentada y con una razón concreta detrás — no un atajo. Cami ya les mostró el plan de gradientes, Meli los de filtro por categoría y paginación — los tres escritos, con archivos exactos a tocar y criterios de aceptación, esperando aprobación para implementarse.

Gracias. Quedamos abiertos a preguntas.
