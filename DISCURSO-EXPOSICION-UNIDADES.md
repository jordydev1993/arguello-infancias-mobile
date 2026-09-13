# Discurso — Exposición del desarrollo (Unidades I a V)

**Para:** exposición oral, Laboratorio 2 (61N)
**Proyecto:** Argüello Infancias Mobile
**Basado en:** `AUDITORIA-UNIDADES-REACT-NATIVE.md` (auditoría real contra el código, 2026-09-14)
**Duración estimada:** 7-9 minutos leído a ritmo normal

> Está escrito para una sola voz corrida — si lo dividen entre varios integrantes, cada `## Unidad` es un corte natural para pasar el micrófono.

---

## Apertura

Buenas. Venimos a contarles cómo construimos Argüello Infancias Mobile, la app que le da al personal de la residencia una forma de acompañar el día a día de cada NNA desde el celular: consultar quién está a cargo, registrar novedades, actividades y, si hace falta, reportar una situación crítica.

No les vamos a mostrar una lista de funcionalidades y ya — les vamos a contar **qué decisiones tomamos y por qué**, unidad por unidad, con evidencia real del código, no de lo que dice la documentación. De hecho, antes de esta exposición hicimos una auditoría completa del repositorio comparando lo que promete cada documento contra lo que el código realmente hace — y varias cosas que en un momento parecían huecos, en realidad eran decisiones de arquitectura ya tomadas con una alternativa mejor. Se los vamos a mostrar así, con la justificación de cada una.

---

## Unidad I — Configuración del entorno y fundamentos

Arrancamos con un proyecto Expo con React Native, usando Expo Router — que es ruteo basado en archivos: cada pantalla es un archivo dentro de `src/app/`, agrupadas en `(auth)` para login y `(tabs)` para la app principal, con una ruta dinámica para el detalle de cada residente.

El entorno lo armamos con Android Studio y un emulador Android real, configurado por línea de comandos — un Pixel 7 corriendo Android 15 — y lo probamos tanto en ese emulador como en dispositivo físico con Expo Go.

Sobre los componentes base de React Native — `View`, `Text`, `Image`, `ScrollView`, `TextInput` — los usamos todos, pero no sueltos: los envolvimos en componentes propios reutilizables. Por ejemplo, nunca vamos a encontrar un `TextInput` desnudo en una pantalla — siempre está adentro de nuestro `FormField`, que le agrega la etiqueta, la validación y el manejo de error. Esa es también nuestra respuesta a "comunicación de datos entre componentes": todo viaja por props tipadas — un componente como `ResidentCard` recibe el residente y una función `onPress`, no adivina nada por su cuenta.

---

## Unidad II — Estilos y componentes visuales

Acá es donde tomamos las decisiones de arquitectura más marcadas, y las vamos a defender una por una.

**En vez de `StyleSheet` de React Native, usamos NativeWind** — Tailwind adaptado a React Native. La razón: con `StyleSheet` cada pantalla termina con su propio objeto de estilos, y mantener consistencia visual entre 20 pantallas se vuelve un problema de copiar y pegar valores. Con NativeWind, todo el equipo escribe las mismas clases utilitarias que ya usamos en la web del proyecto, y el layout con Flexbox lo seguimos usando igual — `flex-row`, `items-center`, `justify-between` — solo que expresado como clases en vez de como objeto JavaScript.

**En vez de Styled Components y `ThemeProvider`, centralizamos el diseño con design tokens** — un solo archivo `design-tokens.json` con los colores, tipografías y espaciados de la marca, que alimenta tanto la configuración de Tailwind como una capa en TypeScript para los pocos casos donde hace falta un color como string plano, por ejemplo el ícono de un botón. Mismo objetivo que un `ThemeProvider` — una sola fuente de verdad — pero sin agregar una segunda librería de estilos corriendo en paralelo a la que ya elegimos.

**En vez de `TouchableOpacity` y `TouchableHighlight`, usamos `Pressable`** en toda la app — es el componente que el propio equipo de React Native recomienda hoy como reemplazo de los dos, con mejor soporte de accesibilidad y más control sobre los distintos estados de una interacción táctil.

Y en vez de traer React Native Paper o React Native Elements, **construimos nuestro propio sistema de componentes** — botones, badges de estado, campos de formulario — pensado específicamente para la identidad visual de Argüello Infancias, sin pelear contra los estilos por defecto de una librería ajena.

Lo único que todavía no teníamos en esta unidad eran gradientes — y a eso llegamos en el cierre, porque ya tenemos el plan escrito para resolverlo con una funcionalidad real, no decorativa.

---

## Unidad III — Navegación

Toda la navegación Stack la resolvimos con Expo Router: `push` para avanzar, `back` con una salvaguarda — si no hay una pantalla anterior en el historial, en vez de romper, te manda al inicio — y paso de parámetros por URL, como el id del residente que via al entrar al detalle.

Las rutas son dinámicas y agrupadas: la carpeta `residentes/[id]` genera automáticamente una ruta por cada NNA, y los grupos `(auth)` y `(tabs)` organizan las pantallas sin que ese agrupamiento aparezca en la URL final.

Para la navegación principal elegimos Tabs — cinco secciones de acceso constante: Inicio, Residentes, Turno, situación Crítica y Perfil. No usamos un Drawer, y es una decisión deliberada: con cinco secciones, un Drawer agrega una capa de navegación extra sin necesidad real.

---

## Unidad IV — Listas y componentes de datos

Usamos `FlatList` para el listado principal de residentes y en el selector de opciones de nuestros formularios — listas virtualizadas, que no renderizan de más.

Para íconos usamos la librería de vectores de Expo, y en cada pantalla usamos `SafeAreaView` para respetar los márgenes seguros del dispositivo — notch, barra de estado, gestos del sistema.

En separación de componentes reutilizables estamos fuertes: tenemos más de once componentes propios bien delimitados, cada uno con una responsabilidad clara.

Ahora, con honestidad: **filtrado por categoría y paginación con scroll infinito todavía no estaban implementados** cuando hicimos la auditoría. Ya tenemos los dos planeados y son parte de lo que les vamos a mostrar como próximos pasos.

---

## Unidad V — Consumo de APIs y estado global

Acá también tomamos una decisión de arquitectura que vale explicar: **en vez de escribir `fetch` o usar Axios a mano, todas nuestras peticiones HTTP pasan por el cliente oficial de Supabase**, que es nuestro backend. Por debajo, ese cliente usa `fetch`, pero nosotros no lo escribimos nosotros llamada por llamada — usamos la librería oficial porque nos resuelve autenticación, tipado y reintentos de una forma mucho más robusta que armarlo a mano.

Para el manejo de datos del servidor usamos **TanStack Query** en los cuatro hooks principales de la app — nos da caché, estados de carga y error ya resueltos, y revalidación automática. Cuando falla una consulta, no se rompe la pantalla: aparece un estado de error con un botón de reintentar.

Y para el estado que vive en el cliente, no en el servidor, usamos **Zustand** — tres stores: uno de sesión, conectado hoy a la autenticación real de Supabase; uno para el residente seleccionado; y uno para la preferencia de tema, que persiste entre sesiones.

Un ejemplo concreto de transformación de datos entre pantallas: cuando pedimos el detalle de un residente, no traemos una sola tabla — combinamos los datos del NNA con los de su tutor principal, que vive en otra tabla relacionada, y armamos un solo objeto listo para mostrar en la pantalla. Eso pasa en un hook, no en la pantalla — la pantalla solo consume el resultado ya armado.

---

## Lo que sigue — 3 planes ya escritos, esperando aprobación

Terminamos siendo honestos sobre lo que falta, porque ya lo planificamos y tiene fecha de implementación corta:

**Plan 05 — Gradientes.** Convertimos la tarjeta de "Turno de hoy" en la pantalla de Inicio en un hero card con gradiente, donde el color cambia según el estado del turno: si está activo, combina los dos colores de marca del proyecto — azul y púrpura — que hoy, sorprendentemente, no se combinan en ningún lado de la interfaz. El gradiente no es decoración: comunica de un vistazo si estás de turno ahora mismo.

**Plan 06 — Filtro por categoría.** En la pestaña de Novedades del detalle de residente, agregamos una fila de chips filtrables por categoría — conducta, emocional, educativo, sanitario, otro — reutilizando un componente genérico que después va a servir para cualquier otra lista categorizada que construyamos.

**Plan 07 — Paginación y scroll infinito.** El listado de residentes pasa de traer todo de una vez a pedir de a páginas, usando `useInfiniteQuery` de TanStack Query contra Supabase. Hoy, con pocos residentes de ejemplo, no se va a notar visualmente — pero el mecanismo ya está diseñado y va a escalar solo cuando el dataset real crezca.

Los tres están escritos como planes formales, con archivos exactos a tocar y criterios de aceptación, esperando la aprobación para implementarse.

---

## Cierre

En resumen: cubrimos los cinco temas del programa, y donde elegimos una herramienta distinta a la nombrada en la cátedra, fue una decisión consciente, documentada y con una razón concreta detrás — no un atajo. Y donde todavía hay un hueco real, ya está planificado, con fecha corta de cierre.

Gracias. Quedamos abiertos a preguntas.
