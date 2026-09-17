# Instructivo — Implementar los tests automatizados con OpenCode (tarjeta #19)

**Para:** Meli
**Qué resuelve:** llevar `test-plan-automatizado.md` (ya corregido) a tests reales, corriendo
`opencode` en la terminal.
**Repo:** `arguello-infancias-mobile` (rama `main` actualizada)

---

## 0. Antes de empezar

- El plan de pruebas ya fue corregido: `test-plan-automatizado.md`. Ya no dice que F2/F4/F6 están
  bloqueadas — las 6 funcionalidades están implementadas, así que el trabajo que queda es
  **escribir los tests**, no esperar a que algo se desbloquee.
- Este repo ya tiene un `AGENTS.md` en la raíz con las reglas del proyecto (flujo de trabajo, stack,
  qué no hacer). **OpenCode lee `AGENTS.md` automáticamente** al abrir el proyecto — no hace falta
  pegárselo a mano.

---

## 1. Instalar OpenCode (si no lo tenés)

En una terminal (PowerShell o Git Bash):

```bash
curl -fsSL https://opencode.ai/install | bash
```

Alternativa si tenés Node/npm:

```bash
npm i -g opencode-ai@latest
```

Verificá que quedó instalado:

```bash
opencode --version
```

---

## 2. Abrir el proyecto

```bash
cd "C:\Users\usuario\Desktop\assets tesis\mobile"
opencode
```

Esto abre la terminal interactiva de OpenCode dentro del proyecto. La primera vez te va a pedir
elegir/loguearte con un proveedor de modelo — seguí las instrucciones en pantalla.

---

## 3. Pedirle el PLAN (no le pidas que implemente directo)

Siguiendo el mismo flujo que ya usa el equipo (`AGENTS.md` §[1]: plan → aprobación → implementación
→ chequeos), el primer prompt no debe pedir código todavía. Pegá esto en el prompt de OpenCode:

```
Leé AGENTS.md y test-plan-automatizado.md. Quiero implementar los tests automatizados de
las tarjetas P1 (CP-03, CP-06, CP-11 — los formularios de F2, F4 y F6) usando Jest +
@testing-library/react-native + jest-expo, según la sección "Configuración del Entorno de
Pruebas" del plan.

No implementes todavía: primero escribime un PLAN en prompts/XX-tests-p1-plan.md con qué
archivos vas a crear, qué vas a mockear (hooks de React Query, expo-router) y cómo cada test
cubre los pasos de CP-03/CP-06/CP-11 del plan. Esperá mi aprobación antes de escribir código.
```

OpenCode va a inspeccionar el código real (`src/app/nueva-novedad.tsx`, `nueva-actividad.tsx`,
`situacion-critica.tsx`, los hooks de mutación) y devolver un plan.

---

## 4. Revisar y aprobar

- Leé el plan que generó en `prompts/XX-tests-p1-plan.md`.
- Si algo no coincide con cómo funciona realmente el formulario, corregilo en el prompt antes de
  aprobar (ej.: "el paso de confirmación no es opcional, revisá los 3 pasos de nueva-novedad.tsx").
- Cuando esté bien, respondé en la terminal:

```
Aprobado, implementá.
```

---

## 5. Verificar antes de dar por terminado

Cuando OpenCode termine de escribir los tests, pedile explícitamente que corra los chequeos
(no asumas que lo hace solo):

```
Corré npm install (por las devDependencies nuevas), npm run typecheck, npm run lint y
npm test, y pegame el resultado de cada uno.
```

Los cuatro tienen que pasar sin errores antes de considerar la tarjeta lista. Si `npm test` falla,
pedile que corrija el test que falla, no que lo borre o lo skippee.

---

## 6. Repetir para P2 y P3

Una vez mergeado P1, mismo patrón para el resto del plan:

```
Ahora implementá los tests P2 (CP-01, CP-04, CP-05, CP-07, CP-08) del test-plan-automatizado.md.
Mismo flujo: PLAN primero, esperá mi aprobación, después implementás.
```

Y después P3 (CP-02, CP-09, CP-10).

---

## 7. Subir el trabajo

Dentro de OpenCode podés pedirle que arme el commit y el PR (el mismo patrón que sigue todo el
equipo — rama nueva, nunca commitear directo a `main`):

```
Creá una rama chore/tests-p1, commiteá los tests P1 con un mensaje descriptivo, subila a
origin y abrí un PR contra main referenciando la tarjeta #19.
```

Revisá el diff que te muestre antes de confirmar que lo suba — mismo criterio que con cualquier
otra herramienta: vos aprobás lo que se sube, la IA no decide sola.

---

## Problemas comunes

| Problema | Qué hacer |
|---|---|
| `opencode --version` no anda después de instalar | Cerrá y volvé a abrir la terminal (el PATH se actualiza al reiniciarla), o instalá con `npm i -g opencode-ai@latest` en vez del script |
| Te pide loguearte con un proveedor de modelo que no tenés | Elegí el que tengas disponible (pedile a Jordy la cuenta/clave si hace falta) |
| Los comandos exactos de este instructivo no coinciden con lo que ves en pantalla | La CLI cambia de versión en versión — corré `opencode --help` para ver los comandos/flags de la versión que tenés instalada; la lógica de fondo (PLAN → aprobación → implementar → verificar) es la que importa, no el comando exacto |
