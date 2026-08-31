# PLAN 00 — Corrección de la estructura de archivos del proyecto

**Fecha:** 2026-08-31
**Autor:** Claude (ingeniero principal)
**Estado:** ✅ Implementado (2026-08-31) — commit directo a `main`
**Reemplaza a:** `docs/_archivo/arbol-plan-original/` (plan original)

**Decisiones tomadas por Jordy:** reorg completa de `docs/` · se tocó `AGENTS.md` · `docs/arbol/` movido a `_archivo/` · commit directo a `main` (sin rama/PR).
**Chequeos:** `npx tsc --noEmit` ✓ · `npm run lint` ✓ · links de `docs/00-INDICE.md` verificados ✓ · `src/` sin cambios funcionales.

---

## 0. Por qué este plan

`AGENTS.md` exige dos carpetas que **hoy no existen**:

| Ruta esperada | Referenciada en | Estado |
|---|---|---|
| `skills/design.md` | AGENTS.md §[8] | ❌ falta |
| `skills/testing.md` | AGENTS.md §[9] | ❌ falta |
| `prompts/XX-nombre-plan.md` | AGENTS.md §[1], §RESUMEN | ❌ falta (este archivo la crea) |

Además el repo arrastra basura de una ejecución parcial del plan original:

- `arguello-mobile/` en la raíz → **19 carpetas vacías** (proyecto-dentro-del-proyecto que generó `01-SETUP-ESTRUCTURA-COMPLETO.sh` por su `PROJECT_DIR=./arguello-mobile` por defecto).
- `src/constants/` → carpeta vacía (el código real usa `src/utils/constants.ts`).

El plan original (`docs/arbol/`) **no se puede ejecutar tal cual**: sus comandos `cp ../ARCHIVO` asumen que los docs están en el directorio padre (están dentro de `docs/`), duplica 3 archivos en dos ubicaciones, agrega carpetas `src/` vacías sin mover código, y genera un índice con ~10 links rotos. Este plan corrige todo eso.

---

## 1. Alcance

### Dentro
1. Borrar basura: `arguello-mobile/`, `src/constants/`.
2. Crear `skills/` con archivos **canónicos** (mover, no copiar) → `design.md`, `testing.md`, `database.md`.
3. Crear `prompts/` (ya iniciada por este archivo) + `.gitkeep`.
4. Reorganizar `docs/` plano → subcarpetas temáticas con `git mv` (sin renumerar, sin duplicar).
5. Actualizar los índices que quedan obsoletos (`INDEX-COMPLETO.md`, `RESUMEN-ARGUELLO-MOBILE.md`) y crear `docs/00-INDICE.md` **solo con archivos que existen**.
6. Mover `docs/arbol/` → `docs/_archivo/arbol-plan-original/` (se conserva como referencia histórica, no se borra).
7. `.gitignore`: añadir `arguello-mobile/`.

### Fuera (descartado del plan original)
- ❌ **Reorg de `src/components/{cards,forms,states}` y `src/hooks/{auth,features,common}`.** El código ya usa `src/components/{common,ui}` y `src/hooks/` plano (12 archivos). Subdividir ahora es churn sin beneficio para un MVP de 2-3 semanas. Se pospone a v2.
- ❌ Duplicar el design-system / modelo de datos en `skills/` **y** `docs/`. Una sola fuente de verdad: `skills/`. En `docs/` van punteros.
- ❌ `README.md` nuevo en la raíz (ya existe uno; no se toca en este plan).
- ❌ Renumerar archivos `01-`…`06-` al moverlos.
- ❌ Ejecutar los scripts `.sh` (frágiles en Windows/PowerShell; se hace con `git mv` a mano).
- ❌ `push` directo a `main`. Todo va en rama + PR.

---

## 2. Archivos: qué se crea / mueve / modifica

### 2.1 Borrados
```
arguello-mobile/            (19 carpetas vacías — rm -r)
src/constants/              (carpeta vacía — rm -r)
```

### 2.2 Carpeta skills/ (nueva — archivos canónicos vía git mv)
```
docs/DESIGN-SYSTEM-ARGUELLO-MOBILE.md                     → skills/design.md
docs/04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md           → skills/testing.md
docs/modelo de datos/VALIDACION-MODELO-DATOS-ARGUELLO.md  → skills/database.md
skills/README.md                                          (nuevo — qué es cada skill)
```
> Nota: el `AGENTS.md` actual (con cambios sin commitear) referencia `skills/design.md` y `skills/testing.md`. `database.md` se incluye por completitud; si querés que `AGENTS.md` lo vuelva a referenciar, lo agrego en §2.6.

### 2.3 Carpeta prompts/ (nueva)
```
prompts/00-correccion-estructura-plan.md   (este archivo)
prompts/.gitkeep
```

### 2.4 Reorganización de docs/ (git mv — nombres SIN cambios)

```
docs/
├── 00-INDICE.md                          (nuevo — índice real)
│
├── 01-proyecto/
│   ├── 01-documento-alcance.md           ← docs/01-documento-alcance.md
│   ├── 02-arquitectura.md                ← docs/02-arquitectura.md
│   └── BRIEF-CLAUDE-CODE.md              ← docs/BRIEF-CLAUDE-CODE.md
│
├── 02-especificaciones/
│   ├── 03-ARGUELLO-MOBILE-FEATURES.md    ← docs/03-…-FEATURES.md
│   ├── 04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md   → PUNTERO a skills/testing.md
│   ├── 05-ARGUELLO-MOBILE-WIREFRAMES.md  ← docs/05-…-WIREFRAMES.md
│   └── 06-ARGUELLO-MOBILE-FLUJOS-NAVEGACION.md      ← docs/06-…-FLUJOS-NAVEGACION.md
│
├── 03-diseno/
│   └── README.md                         (nuevo — puntero a skills/design.md)
│
├── 04-backend/
│   ├── README.md                         (nuevo — puntero a skills/database.md)
│   └── modelo-de-datos/                  ← docs/modelo de datos/ (git mv, renombrada sin espacios)
│       ├── 00-INDICE-ARCHIVOS-GENERADOS.md
│       ├── CORRECCIONES-MODELO-DATOS-ARGUELLO.md
│       ├── RECOMENDACIONES-MODELO-DATOS.md
│       └── RESUMEN-SESION-MODELO-DATOS.md
│       (VALIDACION-…md se fue a skills/database.md)
│
├── 05-integracion/
│   ├── REUSABLE-LINGUA-PARA-ARGUELLO.md  ← docs/REUSABLE-LINGUA-PARA-ARGUELLO.md
│   ├── WORKFLOW-VIBE-ENGINEERING-31-08.md ← docs/WORKFLOW-VIBE-ENGINEERING-31-08.md
│   ├── ANALISIS-VIBE-ENGINEERING.md      ← docs/ANALISIS-VIBE-ENGINEERING.md
│   ├── VIBE-ENGINEERING-QUICK-START.txt  ← docs/VIBE-ENGINEERING-QUICK-START.txt
│   └── UNIFICACION-AGENTS-MOBILE.md      ← docs/UNIFICACION-AGENTS-MOBILE.md
│
├── 06-operativo/
│   ├── EMULADOR-ANDROID.md               ← docs/EMULADOR-ANDROID.md
│   ├── EAS-COMPARTIR.md                  ← docs/EAS-COMPARTIR.md
│   └── ESTADO-SCAFFOLD.md                ← docs/ESTADO-SCAFFOLD.md
│
├── _archivo/
│   ├── INDEX-COMPLETO.md                 ← docs/INDEX-COMPLETO.md (obsoleto pero se conserva)
│   ├── RESUMEN-ARGUELLO-MOBILE.md        ← docs/RESUMEN-ARGUELLO-MOBILE.md
│   ├── MAPA-ARBOL-PROYECTO.md            ← docs/MAPA-ARBOL-PROYECTO.md (se regenera actualizado)
│   └── arbol-plan-original/              ← docs/arbol/  (el plan que este reemplaza)
```

**Decisión sobre `04-…-CRITERIOS-ACEPTACION.md`:** como el contenido se movió a `skills/testing.md`, en `docs/02-especificaciones/` queda un archivo de **1 línea** apuntando a `../../../skills/testing.md`. Igual para design y database. Así "una sola fuente de verdad" y quien navega docs/ encuentra el puntero.

### 2.5 Índices a actualizar (contenido)
```
docs/_archivo/INDEX-COMPLETO.md       → banner al inicio: "OBSOLETO, ver docs/00-INDICE.md"
docs/_archivo/RESUMEN-ARGUELLO-MOBILE.md → idem
docs/00-INDICE.md (nuevo)             → navegación real: solo enlaza archivos existentes
```

### 2.6 (Opcional — solo si lo aprobás) AGENTS.md
- Reañadir referencia a `skills/database.md` en §[5] MODELO DE DATOS.
- Actualizar cualquier ruta `docs/XX` citada que haya cambiado.
> Por defecto **no toco `AGENTS.md`** porque tiene cambios sin commitear tuyos (−598/+385 líneas). Decime si lo incluyo.

### 2.7 .gitignore
```
+ arguello-mobile/
```

---

## 3. APIs / BD

No aplica. Este plan es solo reorganización de archivos y documentación. Cero cambios de código en `src/`, cero migraciones, cero llamadas a Supabase.

---

## 4. Cómo se ejecuta (comandos, en rama)

```bash
git checkout -b chore/correccion-estructura

# --- Fase 1: limpieza ---
rm -rf arguello-mobile src/constants
echo "arguello-mobile/" >> .gitignore

# --- Fase 2: skills/ (canónicos) ---
mkdir -p skills
git mv "docs/DESIGN-SYSTEM-ARGUELLO-MOBILE.md" skills/design.md
git mv "docs/04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md" skills/testing.md
git mv "docs/modelo de datos/VALIDACION-MODELO-DATOS-ARGUELLO.md" skills/database.md
# + crear skills/README.md

# --- Fase 3: prompts/ ---
mkdir -p prompts && touch prompts/.gitkeep
# (00-correccion-estructura-plan.md ya está)

# --- Fase 4: reorg docs/ ---
mkdir -p docs/{01-proyecto,02-especificaciones,03-diseno,04-backend,05-integracion,06-operativo,_archivo}
git mv "docs/modelo de datos" docs/04-backend/modelo-de-datos
git mv docs/01-documento-alcance.md            docs/01-proyecto/
git mv docs/02-arquitectura.md                 docs/01-proyecto/
git mv docs/BRIEF-CLAUDE-CODE.md               docs/01-proyecto/
git mv docs/03-ARGUELLO-MOBILE-FEATURES.md     docs/02-especificaciones/
git mv docs/05-ARGUELLO-MOBILE-WIREFRAMES.md   docs/02-especificaciones/
git mv docs/06-ARGUELLO-MOBILE-FLUJOS-NAVEGACION.md docs/02-especificaciones/
git mv docs/REUSABLE-LINGUA-PARA-ARGUELLO.md   docs/05-integracion/
git mv docs/WORKFLOW-VIBE-ENGINEERING-31-08.md docs/05-integracion/
git mv docs/ANALISIS-VIBE-ENGINEERING.md       docs/05-integracion/
git mv docs/VIBE-ENGINEERING-QUICK-START.txt   docs/05-integracion/
git mv docs/UNIFICACION-AGENTS-MOBILE.md       docs/05-integracion/
git mv docs/EMULADOR-ANDROID.md                docs/06-operativo/
git mv docs/EAS-COMPARTIR.md                   docs/06-operativo/
git mv docs/ESTADO-SCAFFOLD.md                 docs/06-operativo/
git mv docs/INDEX-COMPLETO.md                  docs/_archivo/
git mv docs/RESUMEN-ARGUELLO-MOBILE.md         docs/_archivo/
git mv docs/MAPA-ARBOL-PROYECTO.md             docs/_archivo/
git mv docs/arbol                              docs/_archivo/arbol-plan-original

# --- Fase 5: punteros + índices ---
# crear docs/02-especificaciones/04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md (puntero)
# crear docs/03-diseno/README.md            (puntero)
# crear docs/04-backend/README.md           (puntero)
# crear docs/00-INDICE.md                   (índice real)
# banner OBSOLETO en los 2 archivos de _archivo/
# regenerar docs/_archivo/MAPA-ARBOL-PROYECTO.md con la nueva estructura
```

Nota Windows: `git mv` funciona igual en PowerShell y en el Bash tool. No se usan los `.sh` del plan original.

---

## 5. Criterios de aceptación de ESTE plan

| # | Criterio | Verificación |
|---|---|---|
| E-01 | `skills/design.md` y `skills/testing.md` existen y no están vacíos | `test -s skills/design.md && test -s skills/testing.md` |
| E-02 | `prompts/` existe con el plan dentro | `ls prompts/00-correccion-estructura-plan.md` |
| E-03 | `arguello-mobile/` y `src/constants/` ya no existen | `! test -e arguello-mobile && ! test -e src/constants` |
| E-04 | Ningún archivo `.md` duplicado entre `skills/` y `docs/` (solo punteros de 1 línea) | inspección manual |
| E-05 | `git log --follow` conserva historia de los archivos movidos | `git log --oneline --follow skills/design.md` |
| E-06 | `docs/00-INDICE.md` no tiene links rotos | revisar cada link → archivo existe |
| E-07 | `git grep -n "docs/arbol\|docs/modelo de datos\|DESIGN-SYSTEM-ARGUELLO"` no da resultados en archivos activos (solo en `_archivo/`) | `git grep` |
| E-08 | La app compila igual que antes (nada de `src/` cambió salvo borrar carpeta vacía) | ver §6 |
| E-09 | Todo en rama `chore/correccion-estructura`, `main` intacto | `git branch` |

---

## 6. Chequeos obligatorios (AGENTS.md §[7])

```bash
npm run typecheck      # ✓ sin errores (no debería cambiar: src/ intacto)
npm run lint           # ✓ sin warnings nuevos
npx tsc --noEmit       # ✓
git status             # ✓ solo movimientos/creaciones esperadas
git diff --stat main   # ✓ 0 líneas en src/*.ts(x) salvo borrado de carpeta vacía
```

> No corro `npx expo build` ni `expo start` con BD porque este plan **no toca código ni datos**. Si querés igual arranco `expo start` para confirmar que la app abre.

---

## 7. Pasos exactos para probar (post-implementación)

1. `git checkout chore/correccion-estructura`
2. `npm run typecheck` → sin errores
3. Abrir `docs/00-INDICE.md` → clickear cada link → todos resuelven
4. `cat skills/design.md | head` y `cat skills/testing.md | head` → contenido correcto
5. `ls arguello-mobile src/constants 2>&1` → "No such file or directory"
6. `git log --follow --oneline skills/testing.md` → muestra commits previos del archivo de criterios
7. `npx expo start` (opcional) → la app abre, se navega entre tabs

---

## 8. Riesgos y mitigación

| Riesgo | Mitigación |
|---|---|
| Otros docs referencian rutas viejas por nombre (prosa, no links) | §5 E-07 con `git grep`; se actualizan `INDEX-COMPLETO` y `RESUMEN` con banner |
| `AGENTS.md` cita `docs/XX` que cambió | Revisar en Fase 5; §2.6 opcional |
| Perder el plan original | Se **mueve** a `docs/_archivo/arbol-plan-original/`, no se borra |
| El equipo (Meli/Cami/Sofi) tiene links guardados | Comunicar en el PR + `_archivo/` con banners de redirección |
| Cambios sin commitear en `AGENTS.md` | No se toca `AGENTS.md` salvo que se apruebe §2.6 |

---

## 9. Decisiones que necesito de vos antes de implementar

1. **Reorg completa de `docs/` (6 subcarpetas)** — ¿la hacés ahora o preferís algo más liviano (solo crear `skills/` + `prompts/` y dejar `docs/` plano)?
2. **§2.6 — ¿toco `AGENTS.md`** para reañadir `skills/database.md` y actualizar rutas, o lo dejás para vos?
3. **`docs/arbol/`** — ¿mover a `_archivo/` (mi recomendación) o borrar del todo?
4. ¿Rama + PR, o commit directo a `main`?

---

**Aprobación:** _(esperando "✓ Aprobado" o "✕ Cambiar X")_
