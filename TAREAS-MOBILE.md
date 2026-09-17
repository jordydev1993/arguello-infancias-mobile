# Tareas pendientes — App Mobile (`arguello-infancias-mobile`)

**Fecha:** 2026-09-15
**Fuente:** tablero del equipo (https://github.com/users/jordydev1993/projects/1), áreas
"App mobile" + "Modelo de datos", consultado en vivo vía `gh project item-list`.
**Repo:** `arguello-infancias-mobile` (repo único de trabajo — ver decisión del 2026-09-15).

---

## Estado general

Las 6 features del MVP (F1–F6) y la conexión a Supabase quedaron **Hechas**, cada una con su PR
mergeado:

| Feature | Tarjeta | PR |
|---|---|---|
| F1 — Consultar residentes | [#16](https://github.com/jordydev1993/arguello-infancias-mobile/issues/16) | #30 |
| F2 — Registrar novedades | [#11](https://github.com/jordydev1993/arguello-infancias-mobile/issues/11) | [#33](https://github.com/jordydev1993/arguello-infancias-mobile/pull/33) |
| F3 — Historial | [#13](https://github.com/jordydev1993/arguello-infancias-mobile/issues/13) | [#35](https://github.com/jordydev1993/arguello-infancias-mobile/pull/35) |
| F4 — Registrar actividades | [#12](https://github.com/jordydev1993/arguello-infancias-mobile/issues/12) | [#34](https://github.com/jordydev1993/arguello-infancias-mobile/pull/34) |
| F5 — Mi turno | [#14](https://github.com/jordydev1993/arguello-infancias-mobile/issues/14) | [#36](https://github.com/jordydev1993/arguello-infancias-mobile/pull/36) |
| F6 — Situación crítica | [#15](https://github.com/jordydev1993/arguello-infancias-mobile/issues/15) | [#32](https://github.com/jordydev1993/arguello-infancias-mobile/pull/32) |

[#17](https://github.com/jordydev1993/arguello-infancias-mobile/issues/17) (Backend F1–F6) y
[#18](https://github.com/jordydev1993/arguello-infancias-mobile/issues/18) (correcciones
ON DELETE/soft-delete) se cerraron: la primera por redundante (ya resuelta por las 6 de arriba),
la segunda porque el documento que citaba estaba desactualizado — el hallazgo real que quedaba se
movió a [cielo-abierto#16](https://github.com/jordydev1993/cielo-abierto/issues/16) (schema
compartido con la web, no depende de mobile).

**Jordy no tiene pendientes acá.** Lo que queda es de Meli, Cami y Sofi.

---

## 6 tarjetas pendientes

| # | Persona | Qué es | Estado | Prioridad |
|---|---|---|---|---|
| [#19](https://github.com/jordydev1993/arguello-infancias-mobile/issues/19) | Meli | Tests de los 51 criterios de aceptación CA-01…CA-51 | Sin empezar | Media |
| [#20](https://github.com/jordydev1993/arguello-infancias-mobile/issues/20) | Cami | Revisión UI/UX de F2–F6 contra `skills/design.md` y wireframes | Sin empezar | Media |
| [#21](https://github.com/jordydev1993/arguello-infancias-mobile/issues/21) | Cami | Integrar `SelectField`/`TextAreaField` en F2/F4 — **F2 y F4 ya las usan** (PRs #33/#34), esto ya no tiene código pendiente, solo falta que Cami lo revise y cierre | Sin empezar | Baja |
| [#5](https://github.com/jordydev1993/arguello-infancias-mobile/issues/5) | Sofi | Reescribir `RESUMEN-SESION-MODELO-DATOS.md` | Sin empezar | Media |
| [#6](https://github.com/jordydev1993/arguello-infancias-mobile/issues/6) | Sofi | Reescribir `RECOMENDACIONES-MODELO-DATOS.md` | Sin empezar | Media |
| [#7](https://github.com/jordydev1993/arguello-infancias-mobile/issues/7) | Sofi | Reescribir `CORRECCIONES-MODELO-DATOS-ARGUELLO.md` — ojo, la versión vieja tenía un script que hubiera duplicado `audit_log`, no ejecutarlo | Sin empezar | Media |
| [#8](https://github.com/jordydev1993/arguello-infancias-mobile/issues/8) | Sofi | Actualizar `AGENTS.md` §[5] Modelo de datos (sacar las 7 tablas viejas, reflejar `nnya`) | Sin empezar | Media |

**Bloqueante para Sofi (#5–#8):** el [PR #29](https://github.com/jordydev1993/arguello-infancias-mobile/pull/29)
registra por escrito las 4 decisiones del modelo de datos (#1–#4, ya tomadas) pero **todavía no
está mergeado**. Conviene mergearlo primero:

```bash
gh pr merge 29 --repo jordydev1993/arguello-infancias-mobile --squash --delete-branch
```

## Resumen por persona

| Persona | Pendientes |
|---|---|
| Jordy | 0 |
| Meli | 1 |
| Cami | 2 |
| Sofi | 4 |

## Plantilla de pedido

```
Contexto: soy <tu nombre>, tarjeta #<N> del tablero (<pegá el título>).
Repo: arguello-infancias-mobile

Pedido: Leé AGENTS.md + la skill que corresponda (skills/design.md, skills/testing.md,
skills/database.md), inspeccioná <archivo o carpeta relacionado>, y escribime un PLAN
en prompts/NN-slug.md para <qué querés lograr, en una frase>.

No implementes todavía — quiero revisar el plan primero.
```
