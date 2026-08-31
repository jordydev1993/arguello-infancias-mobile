# skills/ — Herramientas de referencia

Fuente de verdad **única** para diseño, criterios de aceptación y modelo de datos.
`AGENTS.md` obliga a leer el skill relevante antes de cada Feature.

| Archivo | Qué contiene | Se lee para |
|---|---|---|
| `design.md` | Colores (tema Argüello: azul + púrpura), tipografía Poppins, escala de espaciado, componentes reutilizables, WCAG AA | Cualquier pantalla o componente (AGENTS.md §[8]) |
| `testing.md` | 51 criterios de aceptación CA-01…CA-51 (F1–F6), formato DADO–CUANDO–ENTONCES | Antes de dar una Feature por terminada (AGENTS.md §[9]) |
| `database.md` | Validación del modelo de datos: 7 tablas, restricciones, índices, RLS, audit log | Cualquier Feature que lea/escriba en BD (AGENTS.md §[5]) |

> Si necesitás el mismo contenido desde `docs/`, ahí hay punteros a estos archivos
> (`docs/02-especificaciones/04-…`, `docs/03-diseno/`, `docs/04-backend/`). No hay copias.
