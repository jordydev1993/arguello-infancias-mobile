# ✨ MEJORES PRÁCTICAS: 4 Analistas + Claude Code

## 🎯 LA RECETA MÁGICA

```
Documentación exhaustiva
        ↓
Vibe Engineering (8 pasos)
        ↓
Claude Code (planes + código)
        ↓
4 Analistas (paralelo)
        ↓
Testing automático
        ↓
= FEATURES PRODUCTION-READY EN 3.5 HORAS
```

---

## 📋 CHECKLIST PRE-IMPLEMENTACIÓN

Antes de empezar CUALQUIER feature:

### Nivel 1: Documentación (Jordy)

- [ ] **Especificación creada** en `docs/02-ESPECIFICACIONES/F[X]-[nombre].md`
  ```markdown
  # F[X] - [Nombre Feature]
  
  ## Descripción
  [2-3 párrafos de qué es]
  
  ## Criterios de Aceptación
  - CA-1: [Descripción]
  - CA-2: [Descripción]
  - ...
  
  ## Casos de Uso
  1. [Caso de uso 1]
  2. [Caso de uso 2]
  
  ## Dependencias
  - [Otra feature si aplica]
  - [Componente existente si aplica]
  ```

- [ ] **Criterios de aceptación** en `docs/02-ESPECIFICACIONES/criterios-aceptacion-F[X].md`
  ```markdown
  # Criterios de Aceptación: F[X]
  
  ## CA-1: [Nombre criterio]
  
  ### Descripción
  [Detallado qué debe cumplir]
  
  ### Pre-requisitos
  [Si aplica]
  
  ### Pasos
  1. [Paso 1]
  2. [Paso 2]
  
  ### Resultado esperado
  [Qué debe pasar]
  
  ### Datos de prueba
  [Si aplica]
  ```

- [ ] **Wireframes o mockups** (Cami) en `docs/02-ESPECIFICACIONES/wireframes-F[X].md`
- [ ] **Flujos de navegación** (Cami) en `docs/02-ESPECIFICACIONES/flujos-navegacion-F[X].md`
- [ ] **Modelo de datos** (Sofi) en `docs/04-BACKEND/F[X]-modelo-datos.md`

### Nivel 2: Proyecto Preparado (Todos)

- [ ] **Rama creada:** `git checkout -b feature/F[X]-[nombre-slug]`
- [ ] **AGENTS.md actualizado** (solo descripción de feature, no métodos)
- [ ] **Skills/ leído** por cada persona en su rol

### Nivel 3: Listos para Claude Code (Todos)

- [ ] **Proyecto clonado en local** (cada uno)
- [ ] **Claude Code terminal abierto** (cada uno)
- [ ] **Permisos en Supabase confirmados** (Sofi)
- [ ] **Acceso a Figma** (Cami)

---

## 🔄 CICLO DIARIO (8:00 - 17:00)

### **09:00 - STANDUP (15 min)**

**En Zoom + Slack**

```
JORDY:
- "Feature de hoy: F[X]"
- "Criterios: N"
- "División trabajo:"
  - "Yo: frontend + integración"
  - "Cami: UI + assets"
  - "Sofi: APIs + BD"
  - "Meli: testing + QA"
- "¿Preguntas?"

TODOS:
- Confirman comprensión
- Mencionan bloqueadores conocidos
- "Comenzamos en 5 min"
```

**En Slack:**

```
#desarrollo-general

🟦 [JORDY] 
F[X] comenzado. Rama: feature/F[X]-nombre
Criterios: N. Deadline: 13:00

🟣 [MELI] ✓ Listo
🟢 [CAMI] ✓ Listo
🟡 [SOFI] ✓ Listo
```

---

### **09:15 - LECTURA (10 min)**

**En paralelo (no requiere comunicación):**

```bash
# JORDY - Terminal Claude Code
$ cat AGENTS.md | grep -A 30 "F[X]"
$ cat docs/02-ESPECIFICACIONES/F[X]-[nombre].md
$ cat docs/02-ESPECIFICACIONES/criterios-aceptacion-F[X].md
$ tree -L 3 src/components/

# MELI - Terminal Claude Code
$ cat AGENTS.md | grep -A 20 "Testing"
$ cat skills/testing.md
$ cat docs/02-ESPECIFICACIONES/criterios-aceptacion-F[X].md

# CAMI - Terminal Claude Code
$ cat skills/design.md
$ cat docs/02-ESPECIFICACIONES/wireframes-F[X].md
$ cat src/theme/design-tokens.json | jq

# SOFI - Terminal Claude Code
$ cat skills/database.md
$ cat docs/04-BACKEND/F[X]-modelo-datos.md
$ cat docs/04-BACKEND/MODELO-DATOS.md
```

**En Slack:**

```
🟦 [JORDY] Frontend spec leído ✓
🟣 [MELI] Testing spec leído ✓
🟢 [CAMI] Design spec leído ✓
🟡 [SOFI] DB spec leído ✓
```

---

### **09:30 - GENERAR PLANES (15 min)**

**EN PARALELO - Cada uno en su Claude Code:**

```bash
# JORDY (Frontend)
PROMPT:
"PROYECTO: Argüello Infancias Mobile
 FEATURE: F[X] - [Nombre]
 TAREA: Crear plan frontend
 
 LEE ESTOS ARCHIVOS:
 1. AGENTS.md (§ Frontend)
 2. skills/design.md
 3. docs/F[X]-especificaciones.md
 4. docs/criterios-aceptacion-F[X].md
 5. docs/wireframes-F[X].md
 
 CREA PLAN EN: prompts/F[X]-frontend-plan.md
 
 PLAN DEBE INCLUIR:
 - Archivos a crear
 - Componentes específicos (nombre, props, responsabilidades)
 - Hooks (lógica, estados)
 - Integración APIs
 - Design tokens usados
 - Validación TypeScript
 - Cómo cumple criterios de aceptación
 
 NO IMPLEMENTES AÚN, SOLO PLAN.
 ESPERA APROBACIÓN."

# MELI (Testing)
PROMPT:
"PROYECTO: Argüello Infancias Mobile
 FEATURE: F[X] - [Nombre]
 TAREA: Crear plan testing
 
 LEE:
 1. AGENTS.md (§ Testing)
 2. skills/testing.md
 3. docs/criterios-aceptacion-F[X].md
 
 CREA PLAN EN: prompts/F[X]-testing-plan.md
 
 PLAN DEBE INCLUIR:
 - Test cases por criterio (CA-1 a CA-N)
 - Mocks de data
 - Edge cases
 - Performance expectations
 - Cobertura esperada
 
 ESPERA APROBACIÓN."

# CAMI (Design)
PROMPT:
"PROYECTO: Argüello Infancias Mobile
 FEATURE: F[X] - [Nombre]
 TAREA: Crear plan design
 
 LEE:
 1. skills/design.md
 2. docs/wireframes-F[X].md
 3. src/theme/design-tokens.json
 
 CREA PLAN EN: prompts/F[X]-design-plan.md
 
 PLAN DEBE INCLUIR:
 - Componentes UI a crear/modificar
 - Design tokens (colores, tipografía, espaciado)
 - Estados visuales (normal, hover, error, loading)
 - Responsive design
 - Updates a Figma
 
 ESPERA APROBACIÓN."

# SOFI (Backend)
PROMPT:
"PROYECTO: Argüello Infancias Mobile
 FEATURE: F[X] - [Nombre]
 TAREA: Crear plan backend
 
 LEE:
 1. skills/database.md
 2. docs/F[X]-modelo-datos.md
 3. docs/MODELO-DATOS.md (existente)
 
 CREA PLAN EN: prompts/F[X]-backend-plan.md
 
 PLAN DEBE INCLUIR:
 - DDL (nuevas tablas si aplica)
 - Índices y constraints
 - Relaciones entre tablas
 - RLS policies
 - APIs (GET/POST/PUT/DELETE)
 - Validación (zod schemas)
 - Performance considerations
 
 ESPERA APROBACIÓN."
```

**En Slack:**

```
09:32 🟦 [JORDY] Plan frontend generado, revisando...
09:33 🟣 [MELI] Plan testing generado, revisando...
09:34 🟢 [CAMI] Plan design generado, revisando...
09:35 🟡 [SOFI] Plan backend generado, revisando...
```

---

### **09:45 - REVISAR PLANES (15 min)**

**Individual (no sincronizado):**

Cada persona revisa SU PROPIO plan generado por Claude Code.

**Checklist de revisión:**

```
JORDY (Frontend):
- [ ] Componentes bien divididos (no monolíticos)
- [ ] Hooks claros y reutilizables
- [ ] APIs correctas (GET/POST/PUT/DELETE)
- [ ] Design tokens aplicados
- [ ] TypeScript tipado (interfaces claras)
- [ ] Criterios de aceptación cubiertos
- [ ] Componentes son reutilizables

Si TODO OK → "✓ Aprobado"
Si problemas → "✕ Cambiar X, Y, Z"

MELI (Testing):
- [ ] Test cases por cada criterio
- [ ] Mocks de data específicos
- [ ] Edge cases identificados
- [ ] Performance expectations claras
- [ ] Cobertura objetivo definido
- [ ] Criterios de éxito en cada test

Si TODO OK → "✓ Aprobado"
Si problemas → "✕ Cambiar X, Y, Z"

CAMI (Design):
- [ ] Componentes UI claros
- [ ] Design tokens (colores, tipografía, espaciado)
- [ ] Estados visuales (normal, hover, error, loading)
- [ ] Responsive design considerado
- [ ] Figma updates específicas
- [ ] WCAG AA considerado

Si TODO OK → "✓ Aprobado"
Si problemas → "✕ Cambiar X, Y, Z"

SOFI (Backend):
- [ ] DDL correcto (sin errores SQL)
- [ ] Índices para queries principales
- [ ] RLS policies bien definidas
- [ ] APIs con validación (zod)
- [ ] Relaciones entre tablas
- [ ] Performance considerations
- [ ] Migration file ready

Si TODO OK → "✓ Aprobado"
Si problemas → "✕ Cambiar X, Y, Z"
```

**En Slack:**

```
09:47 🟦 [JORDY] ✓ Plan frontend aprobado
09:48 🟣 [MELI] ✓ Plan testing aprobado
09:49 🟢 [CAMI] ✓ Plan design aprobado
09:50 🟡 [SOFI] ✓ Plan backend aprobado

🟦 [JORDY] Adelante con implementación! 🚀
```

---

### **10:00 - IMPLEMENTAR (120 min)**

**EN PARALELO - Cada uno implementa SU módulo:**

```bash
# JORDY (Frontend)
$ # Claude Code escribe en src/components/
$ npm run build    # Build after each component
$ npm run typecheck   # Verify types

# MELI (Testing)
$ # Claude Code escribe en test/
$ npm run test     # Run tests after each suite
$ npm run test:coverage   # Coverage report

# CAMI (Design)
$ # Crea/actualiza en Figma
$ # Exporta assets a design/
$ # Verifica design tokens

# SOFI (Backend)
$ # Claude Code escribe en src/api/, db/
$ npm run typecheck   # Verify types
$ npm run test:api    # API tests
```

**Regla de oro:**

```
SI ALGUIEN ESTÁ BLOQUEADO:
├─ NO esperes a otros
├─ MOCKEA lo que falta
├─ CONTINÚA tu trabajo
└─ Swap mocks por real cuando esté listo

Ejemplo:
Jordy espera POST /api/comentarios de Sofi
Jordy crea mock:
  export const createComment = async (data) => ({
    id: "mock-1",
    contenido: data.contenido,
    usuario_id: "mock-user"
  });
Jordy implementa componente con mock
Sofi implementa API real
Swap: import { createComment } from '@/api/comments';
```

**En Slack (cada 30 min):**

```
10:30 🟦 [JORDY] 3/4 componentes listos
10:30 🟣 [MELI] 8/12 tests listos
10:30 🟢 [CAMI] Figma actualizado, assets listos
10:30 🟡 [SOFI] 2/4 APIs listas

11:00 🟦 [JORDY] Componentes + hooks listos
11:00 🟣 [MELI] Todos los tests listos
11:00 🟢 [CAMI] UI polish completado
11:00 🟡 [SOFI] APIs completas, DB migration ready
```

---

### **11:30 - CHEQUEOS LOCALES (30 min)**

**Cada uno verifica SU código:**

```bash
# JORDY
$ npm run build           # Full build
$ npm run lint            # ESLint
$ npm run typecheck       # TypeScript
$ npm run test:unit       # Unit tests components
# Esperado: ✅ PASS

# MELI
$ npm run test            # All tests
$ npm run test:coverage   # Coverage report
# Esperado: ✅ PASS, >80% coverage

# CAMI
$ # En Figma: verifica
  - Componentes creados ✓
  - Design tokens aplicados ✓
  - Estados visuales ✓
  - Responsive preview ✓

# SOFI
$ npm run typecheck       # TypeScript
$ npm run test:api        # API tests
$ npm run db:validate     # Schema validation
# Esperado: ✅ PASS
```

**En Slack:**

```
11:35 🟦 [JORDY] ✅ Build + lint + typecheck OK
11:36 🟣 [MELI] ✅ Tests: 12/12 passing
11:36 🟢 [CAMI] ✅ UI ready
11:36 🟡 [SOFI] ✅ APIs + DB validated
```

---

### **12:00 - INTEGRACIÓN (30 min)**

```bash
# Todos en paralelo (no sincronizado)
$ git status
$ git add [mis cambios]
$ git commit -m "feat(F[X]): [Mi parte específica] - [Nombre]"
# Ejemplos:
# - "feat(F7): Create comment components - Jordy"
# - "feat(F7): Add comment tests - Meli"
# - "feat(F7): Design comment UI - Cami"
# - "feat(F7): Implement comment APIs - Sofi"

$ git push origin feature/F[X]-nombre

# Sofi ejecuta migration
$ npm run db:migrate
$ # Verifica: tablas creadas, índices OK

# Jordy conecta APIs
$ # Actualiza useComments → import APIs reales
$ npm run build

# Meli corre integration tests
$ npm run test:integration
$ # Esperado: 100% passing
```

**En Slack:**

```
12:05 🟡 [SOFI] Migrations ejecutadas ✅
12:10 🟦 [JORDY] APIs conectadas ✅
12:15 🟣 [MELI] Integration tests: 6/6 PASS ✅
```

---

### **12:30 - VERIFICACIÓN FINAL (30 min)**

```bash
# FULL PIPELINE CHECK
$ npm run build         # Full build
$ npm run test          # All tests (prev + nuevos)
$ npm run typecheck     # No errors
$ npm run lint          # No linting issues

# Resultado esperado:
# ✅ Build: PASS
# ✅ Tests: 180/180 PASS (includes 12 nuevos)
# ✅ TypeCheck: PASS
# ✅ Lint: PASS

# EN GITHUB:
# 1. Jordy abre PR: feature/F[X] → main
# 2. Meli revisa + comenta ✓
# 3. Cami revisa + comenta ✓
# 4. Sofi revisa + comenta ✓
# 5. Todos aprueban (APPROVED)
# 6. Jordy mergea: squash or regular merge
# 7. Rama feature deletea
```

**En Slack:**

```
12:35 🟦 [JORDY] PR abierto #42
12:40 🟣 [MELI] ✓ Aprobado (QA)
12:42 🟢 [CAMI] ✓ Aprobado (UI)
12:44 🟡 [SOFI] ✓ Aprobado (Backend)
12:50 🟦 [JORDY] 🚀 MERGEADO A MAIN

✅ F[X] COMPLETADA
Criterios: N/N ✓
Bugs: 0 ✓
Tiempo: 3.5 horas ✓
Status: PRODUCTION-READY ✅
```

---

### **13:00 - CIERRE Y SIGUIENTE FEATURE**

```
Retrospectiva rápida (5 min):
- ¿Qué salió bien?
- ¿Qué salió mal?
- ¿Qué mejorar?

Planning siguiente:
- Feature F[X+1]
- Criterios
- Asignación roles
- Inicio estimado

Almuerzo (1.5h)

14:30 - Siguiente feature comienza
```

---

## 🚨 RESOLUCIÓN DE PROBLEMAS COMUNES

### **Problema 1: Bloqueador de API**

```
Situación: Jordy espera API que Sofi está haciendo

SOLUCIÓN:
1. Jordy pide a Sofi: "¿ETA?"
2. Si > 15 min: Sofi crea STUB (respuesta mockada)
3. Jordy implementa con stub
4. Sofi implementa real
5. Jordy swappea import

CÓDIGO STUB (Sofi rápido):
export const createComment = async (data: ICommentInput) => ({
  id: `mock-${Date.now()}`,
  contenido: data.contenido,
  usuario_id: "mock-user",
  fecha_creacion: new Date().toISOString()
});

SWAP DESPUÉS (Jordy):
// import { createComment } from '@/lib/mocks/comments';
import { createComment } from '@/api/comments'; // ← REAL
```

### **Problema 2: TypeScript error**

```
Situación: Componente no compila

ERROR: Property 'avatar' does not exist on type 'Autor'

SOLUCIÓN:
1. Cami: "¿Cuál es el tipo correcto?"
2. Sofi: "Está en src/types/index.ts línea 45"
3. Cami importa tipo + recompila
4. ✅

PREVENCIÓN:
- Tipos centralizados en src/types/
- Sofi mantiene tipos de BD
- Jordy mantiene tipos de componentes
- AGENTS.md documenta interfaces principales
```

### **Problema 3: Merge conflict**

```
Situación: Dos personas modifican mismo archivo

PREVENCIÓN (Vibe Engineering):
- Cada persona módulo DIFERENTE
- Nunca dos en src/components/CommentCard.tsx

SI PASA:
$ git merge --abort
Quien llegó primero: merge normal
Quien llegó después: rebase + resuelve conflictos

COMUNICACIÓN:
# #f7-timeline-comentarios (canal privado de feature)
🟦 [JORDY] Tengo merge conflict en useComments
🟡 [SOFI] Mir, yo lo resolvi
🟦 [JORDY] Gracias, me tomas tu versión
```

### **Problema 4: Test falla**

```
Situación: Test de Meli falla en código de Jordy

TEST FAIL:
$ npm run test
FAIL test/comments.test.ts
  ✓ CA-1: Mostrar lista comentarios
  ✗ CA-2: Form nuevo comentario
    Expected "true" but got "false"

SOLUCIÓN:
1. Meli: "CA-2 falla en componente CommentForm"
2. Jordy: "Miro el test..."
3. Jordy: "Era validación de campo vacío"
4. Jordy arregla ComponentForm.tsx
5. Meli rerun tests
6. ✅ PASS

COMUNICACIÓN:
# #f7-timeline-comentarios
🟣 [MELI] CA-2 falla: https://bit.ly/test-fail
🟦 [JORDY] Revisando...
🟦 [JORDY] Era validación, arreglado
🟣 [MELI] ✅ Todos los tests pasando ahora
```

---

## ✅ CHECKLIST DE CALIDAD

Antes de mergear a main:

```
CÓDIGO:
- [ ] npm run build → PASS
- [ ] npm run lint → 0 errors
- [ ] npm run typecheck → 0 errors
- [ ] npm run test → 100% passing

UI (Cami):
- [ ] Colores Argüello aplicados (#007AFF, #7C3AED)
- [ ] Tipografía Poppins correcta
- [ ] Espaciado scale correcto (4px, 8px, 12px, 16px...)
- [ ] Estados visuales (hover, focus, error, loading)
- [ ] Responsive design OK
- [ ] WCAG AA compliant

TESTING (Meli):
- [ ] N/N criterios cubiertos
- [ ] Cobertura > 80%
- [ ] Tests manual ejecutados
- [ ] Edge cases validados
- [ ] Performance < 200ms

BD (Sofi):
- [ ] Índices creados
- [ ] RLS policies activas
- [ ] Soft deletes si aplica
- [ ] Audit log si aplica
- [ ] Migration file clean

DOCUMENTACIÓN:
- [ ] AGENTS.md actualizado (si aplica)
- [ ] README.md actualizado
- [ ] Comentarios en código claros
- [ ] Tipos documentados

PR:
- [ ] Titulo claro: "feat(F[X]): [Descripción]"
- [ ] Descripción: feature + criterios cumplidos
- [ ] Link a branch: feature/F[X]-[nombre]
- [ ] 4 aprobaciones (Jordy, Meli, Cami, Sofi)
```

---

## 💡 TIPS Y TRUCOS

### **1. Claude Code es copiloto, no driver**

```
❌ NO hacer:
Cliff, writes the CommentCard component
$ claude-code "Haz comment card"
# Esperar resultado

✅ SÍ hacer:
$ cat prompts/F7-frontend-plan.md
# Revisar plan
$ # "✓ Aprobado"
# Claude Code implementa basado en plan

Diferencia: Plan primero = menos errors
```

### **2. Meli = Primera persona en escribir código**

```
Orden correcto:
1. Meli crea tests (plan testing + test files)
2. Jordy implementa componentes (tests guían)
3. Cami pulsa UI (tests verifican visual)
4. Sofi implementa APIs (tests validan)
5. Todos: green tests = feature lista

Orden INCORRECTO:
1. Jordy implementa
2. Meli intenta testear (difícil)
3. Bugs + refactorings
```

### **3. AGENTS.md es Talmud**

```
AGENTS.md es:
✅ Single source of truth
✅ Lo que Claude Code lee para entender proyecto
✅ Contiene: Principios, arquitectura, criterios
✅ Actualizado DESPUES de cada ciclo (no durante)

❌ NO es:
❌ Un checklist que cambias durante dev
❌ Lugar para guardar planes (→ prompts/)
❌ Lugar para código (→ src/)
```

### **4. Git commits = Atomic**

```
BUEN COMMIT:
$ git commit -m "feat(F7): Create CommentCard component - Jordy"
# Un cambio, una razón, un autor

MALO COMMIT:
$ git commit -m "fixed stuff and added components"
# Demasiados cambios, poco claro

REGLA: Un commit = Alguien puede entender SU trabajo
```

### **5. Slack channels = Organized**

```
#desarrollo-general
├─ Standups diarios
├─ Decisiones importantes
├─ Bloqueadores globales

#f7-timeline-comentarios (privado)
├─ Planes generados
├─ Aprobaciones
├─ Issues específicos
├─ Prueba manual

#codigo-reviews
├─ PRs abiertas
├─ Comentarios review
├─ Aprobaciones
```

### **6. Documentación = Inglés o Español (consistente)**

```
Elige UNO para TODO el proyecto:
✅ AGENTS.md + skills/ + docs/ → Español
✅ Código + tests + comentarios → Inglés

NO MIX:
❌ Docs español + código inglés
❌ Inconsistencia = confusión
```

---

## 📊 MÉTRICAS ESPERADAS

### **Por Feature (4 personas):**

| Métrica | Target | Realidad |
|---------|--------|----------|
| Tiempo | 3-4h | 3.5h ✅ |
| Criterios | 100% | 100% ✅ |
| Bugs críticos | 0 | 0 ✅ |
| Tests | 100% pass | 100% pass ✅ |
| Build | < 30s | 25s ✅ |
| Coverage | > 80% | 92% ✅ |
| Performance | < 200ms | 145ms ✅ |

### **Por Semana:**

| Semana | Features | Criterios | Status |
|--------|----------|-----------|--------|
| 1 | 2 | 10-12 | Aprendiendo |
| 2 | 3 | 15-18 | Fluyendo |
| 3+ | 3-5 | 18-25 | Máxima |

**Con 51 criterios MVP:**
- Semana 1-2: Setup + 2-3 features
- Semana 3-6: 3-5 features/semana
- **Total: 5-6 semanas** para MVP completo

---

## 🎯 CONCLUSIÓN: LA FÓRMULA

```
Documentación Clara
        ↓
Vibe Engineering (8 pasos)
        ↓
Claude Code (genera planes)
        ↓
4 Analistas Paralelo (cada uno su módulo)
        ↓
Testing Automático Exhaustivo
        ↓
PR Review por 4 personas
        ↓
Merge a main
        ↓
= FEATURE PRODUCTION-READY EN 3-4 HORAS
= 0 BUGS CRÍTICOS
= CÓDIGO TYPESAFE Y TESTADO
= EQUIPO FELIZ Y RÁPIDO

SIN esto:
= 8-12 horas
= 2-4 bugs
= Debugging infinito
= Team frustrado
```

---

**¡Esto es tu flujo de oro! Síguelo al pie de la letra y tendrás éxito garantizado.**

