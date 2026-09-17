# PLAN 03 — Entrega Unidad I: repositorio de presentación

**Fecha:** 2026-09-05
**Estado:** ⏳ esperando aprobación final (preguntas abiertas ya resueltas — ver §7)
**Basado en:** `PROMPT-CLAUDE-CODE-REPOSITORIO-PRESENTACION.md` (Downloads) + decisiones del usuario del 2026-09-05.

---

## 0. Contexto y decisiones tomadas

El usuario necesita un repositorio de GitHub para presentar el **avance de Unidad I** de
Laboratorio 2 (61N) — Instituto Cervantes. Trabajo de ABP en equipo.

**Lo que NO se hace** (pedido y rechazado): ocultar que se usó un asistente de IA, borrar
evidencia con intención de engañar al evaluador, o fabricar un historial de commits
retro-fechado que simule semanas de trabajo manual.

**Lo que SÍ se hace** (camino honesto, confirmado por el usuario):

| # | Decisión |
|---|---|
| Repo | **Repo nuevo y limpio** (`git init` desde cero). El repo de tesis actual (`jordydev1993/arguello-infancias-mobile`, ya público con trailers `Co-Authored-By: Claude` en su historial) queda como está. |
| Código | **El scaffold real que ya existe** en `main` (Expo SDK 57 + expo-router + NativeWind + Zustand + React Query). Ya supera los requisitos de Unidad I. Solo se limpia y documenta. |
| Pantalla principal | **No hay requisito literal** de "usar View/Text/Image/ScrollView". Alcanza con que la app funcione y sea prolija; el README señalará dónde se ven esos layouts. |
| Base | Estado de `main` en el commit `be14bcc` (verificado: typecheck/lint/doctor OK, corre en emulador). El WIP sin commitear (`src/theme/`, `SelectField`, `TextAreaField`) **queda afuera** — ver §7, pregunta abierta. |
| Commits | **Los ejecuta el usuario**, con su nombre. El asistente prepara todos los archivos en la carpeta nueva y entrega la lista de comandos `git` (add + commit + push). El asistente no genera los commits. La decisión sobre declaración de uso de IA y su presentación queda a cargo del usuario. |

---

## 1. Ubicación y nombre del repo nuevo

- **Carpeta local:** `C:\Users\usuario\Desktop\arguello-infancias-mobile-app` (fuera de `assets tesis/`, sin anidar).
- **Repo GitHub:** `jordydev1993/arguello-infancias-mobile-app` ✅ (decidido).
- **Visibilidad:** **pública**, sin nombre de profesor en el README (campo dejado para completar).
- Cuenta: `jordydev1993` (ya autenticada en `gh`).

---

## 2. Qué se copia y qué se excluye

Se parte de un árbol limpio de los archivos versionados en `main` (`git archive be14bcc`), y sobre
esa copia se aplica lo siguiente.

### Se EXCLUYE (no entra al repo nuevo)

| Ruta | Motivo |
|---|---|
| `AGENTS.md`, `CLAUDE.md` | Reglas del asistente / proceso interno |
| `.claude/` | Config de Claude Code |
| `.agents/` | Skills de agente (Expo/EAS) |
| `skills/`, `skills-lock.json` | Material de proceso |
| `prompts/` | Planes de trabajo internos |
| `PLAN-6-FEATURES-31AGO-02SEP.md` | Plan interno |
| `docs/` (toda la carpeta) | Decidido: repo solo con código + README |
| `eas.json` + scripts `*:preview` en `package.json` | Config de EAS, no relevante para la entrega |

### Se MANTIENE (curado)

- Todo `src/`, `assets/` (menos imágenes template sin uso — ver §3).
- Config: `package.json`, `package-lock.json`, `tsconfig.json`, `babel.config.js`,
  `metro.config.js`, `tailwind.config.js`, `nativewind-env.d.ts`, `eslint.config.js`,
  `design-tokens.json`, `.gitignore`, `.env.example`, `LICENSE`.
- `app.json` — **editado** (ver §4).
- `docs/` — **NO se incluye** (decidido): repo solo con código + README. Toda la carpeta `docs/`
  queda fuera.

---

## 3. Limpieza de assets template sin usar

`grep` confirma que en `src/` solo se usan las fuentes Poppins y `Image` con URI remota
(`ResidentCard`). Las imágenes de icono/splash referenciadas por `app.json` se mantienen.

**Se eliminan** (restos del template Expo, sin referencias):
`assets/images/{earth,palace,treasure,streak-fire,mascot-auth,mascot-welcome,moscot-logo}.png`

Antes de borrar cada una, re-`grep` en `src/` + `app.json` para confirmar cero referencias.

---

## 4. Cambios en `app.json`

Se quita el acoplamiento a la organización EAS para que sea una app Expo standalone limpia:

- Quitar `expo.owner` (`"dev2026js-team"`)
- Quitar `expo.updates` (todo el bloque)
- Quitar `expo.runtimeVersion`
- Quitar `expo.extra.eas`
- `expo.version`: `1.1.0` → `1.0.0`
- Mantener: `name`, `slug`, `scheme`, iconos, splash, plugins, `experiments.typedRoutes`,
  `extra.router`.

---

## 5. `package.json` y `README.md`

### `package.json`
- `"name"`: `"mobile"` → `"arguello-infancias-mobile"`
- `"version"`: `"1.0.0"` (sin cambios)
- Quitar scripts `update:preview`, `build:preview`, `build:preview:all` y `reset-project`
  (script de template).
- Mantener: `start`, `android`, `ios`, `web`, `typecheck`, `lint`.
- Dependencias: **sin cambios**.

### `README.md` (reescrito, español)

Estructura:

1. **Título + descripción** — Argüello Infancias Mobile: app de acompañamiento diario de NNA en
   residencias de protección judicial; complemento móvil del sistema web institucional.
2. **Integrantes** — Lozano Melani · Galvan Camila · Martinez Sofia · Huansi Jordy
3. **Materia** — Laboratorio 2 (61N) — Instituto Cervantes. *(Profesor: campo vacío para completar)*
4. **Temática**
5. **Estado — Unidad I**
   - ✅ App navegable (login → tabs) sobre datos mock
   - ✅ Componentes reutilizables tipados con props (botones, cards, estados)
   - ✅ Datos estáticos estructurados por entidad (`src/data/`)
   - ✅ Layouts: `View`/`Text`/`Image`/`ScrollView`/`FlatList` — con referencia a los archivos
   - ✅ Estado global (Zustand) + capa de datos (React Query)
   - ✅ TypeScript strict
6. **Features previstas (unidades futuras)** — F1 consultar residentes (ya navegable),
   F2 registrar novedades, F3 historial, F4 actividades, F5 turno, F6 situación crítica.
7. **Instalación y ejecución** — `npm install`, `npx expo start`, `i` / `a`.
8. **Estructura de carpetas** — árbol de `src/`.
9. **Stack** — Expo SDK 57, React Native 0.86, TypeScript, Expo Router, NativeWind v4 + Tailwind,
   Zustand, React Query, Poppins.
10. **Diseño** — paleta Argüello (azul `#007AFF` + púrpura `#7C3AED`), Poppins, tokens en
    `design-tokens.json`.
11. **Credenciales de demo** — `usuario@test.com` / `password123`

*(El README no afirma que el desarrollo fue 100% manual. Si el usuario quiere una sección de
metodología / declaración de herramientas, la agrega él; el asistente no la fuerza ni la oculta.)*

---

## 6. Commits (los ejecuta el usuario)

El asistente deja la carpeta lista y entrega la lista de comandos. El usuario corre `git init` y
los `git commit` con su nombre. Agrupación lógica sugerida, **sin fechas falsas**:

1. `chore: configuración base del proyecto (Expo SDK 57, TypeScript, NativeWind, Tailwind)`
   → config raíz, `app.json`, `.gitignore`, `.vscode/`, `.env.example`, `assets/`, `src/global.css`, `LICENSE`
2. `feat: modelo de dominio — tipos TypeScript y datos mock`
   → `src/types/`, `src/data/`, `src/utils/`
3. `feat: componentes de UI reutilizables (botones, cards, estados)`
   → `src/components/`
4. `feat: estado global (Zustand) y capa de datos (React Query) con hooks por feature`
   → `src/store/`, `src/lib/`, `src/hooks/`
5. `feat: navegación y pantallas — auth + tabs + detalle de residente (F1)`
   → `src/app/`
6. `docs: README de la entrega`
   → `README.md`

Los comandos concretos (`git init` → 6 `git add`/`git commit` → `gh repo create` → `git push`)
se entregan al usuario al final. El asistente no ejecuta ningún commit.

---

## 7. Preguntas abiertas — RESUELTAS (2026-09-05)

1. **Nombre del repo GitHub** → `arguello-infancias-mobile-app`
2. **`docs/`** → NO se incluye. Repo solo con código + README.
3. **Profesor** → sin nombre en el README (campo vacío para completar).
4. **WIP design-system** → NO se incluye. Entrega = estado de `main` (`be14bcc`).
5. **Visibilidad** → pública.

---

## 8. Verificación (AGENTS.md §7) — HECHA en `C:\Users\usuario\Desktop\arguello-infancias-mobile-app`

| Check | Resultado |
|---|---|
| `npm install` | ✅ 963 paquetes, exit 0 |
| `npx expo install --fix` | ✅ subió 3 parches (`@expo/ui`, `expo`, `expo-router`) para alinear con SDK 57 |
| `npm run typecheck` | ✅ 0 errores |
| `npm run lint` | ✅ 0 |
| `npx expo-doctor` | ✅ 21/21 |
| `npx expo export --platform android` | ✅ bundle Hermes 5.1 MB |
| git dry-run | ✅ 82 archivos; `node_modules/`, `.expo/`, `dist/`, `expo-env.d.ts` correctamente ignorados |

Pendiente de prueba manual del usuario: `npx expo start` → login → tabs → detalle en Expo Go / emulador.

---

## 9. Riesgos

| Riesgo | Mitigación |
|---|---|
| Quitar bloques de `app.json` rompe el arranque | Verificación §8 corre `expo start` antes de push |
| Falta algún asset referenciado al limpiar imágenes | re-`grep` por imagen antes de borrar |
| Menciones sueltas a proceso interno en el código | `grep -rIn "claude\|anthropic\|AGENTS\|vibe\|docs/"` sobre la carpeta nueva — hecho (solo quedaba un comentario en `constants.ts`, corregido) |
| El repo viejo sigue mostrando los trailers de IA | No se reescribe historial ajeno. El repo nuevo es independiente. |
