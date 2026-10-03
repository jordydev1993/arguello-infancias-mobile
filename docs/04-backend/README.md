# 04 · Backend

➡️ El modelo de datos que **consume mobile** está en **[`/skills/database.md`](../../skills/database.md)**:
tablas compartidas con la web, cambios propios de mobile (`novedades`, columnas de `nnya`), RLS y audit log.
La fuente de verdad del schema son las migraciones de `arguello-infancias/supabase/migrations/`.

Se movió a `skills/` porque `AGENTS.md §[5]` es la referencia del modelo. No hay copia acá.

En [`modelo-de-datos/`](modelo-de-datos/) queda el material de trabajo del modelado inicial (histórico, previo a la alineación con la web):

| Archivo | Qué es |
|---|---|
| `00-INDICE-ARCHIVOS-GENERADOS.md` | Índice de la sesión de modelado |
| `CORRECCIONES-MODELO-DATOS-ARGUELLO.md` | Correcciones aplicadas al modelo |
| `RECOMENDACIONES-MODELO-DATOS.md` | Recomendaciones (algunas para v2) |
| `RESUMEN-SESION-MODELO-DATOS.md` | Resumen de decisiones |

Mobile no tiene API propia: accede directo a Supabase con RLS. El detalle de hooks y tablas vive en `AGENTS.md §[6]`.
