# 🚀 GUÍA COMPLETA: Implementar Estructura de Proyecto

**Argüello Infancias Mobile**  
**Tiempo total: 30 minutos**  
**Fecha: 31 de Agosto 2026**

---

## 📋 ÍNDICE

1. [ANTES DE EMPEZAR](#antes-de-empezar)
2. [FASE 1: Crear estructura de carpetas](#fase-1-crear-estructura-de-carpetas-5-min)
3. [FASE 2: Copiar archivos de referencia](#fase-2-copiar-archivos-10-min)
4. [FASE 3: Crear AGENTS.md + README](#fase-3-crear-agentsmd--readme-5-min)
5. [FASE 4: Validar estructura](#fase-4-validar-estructura-5-min)
6. [FASE 5: Git commit & push](#fase-5-git-commit--push-5-min)
7. [CHECKLIST FINAL](#checklist-final)

---

## ✅ ANTES DE EMPEZAR

### Requisitos

```bash
# Verificar que tienes todo instalado
git --version        # Git debe estar configurado
node --version       # Node.js 20+ instalado
npm --version        # npm disponible

# Verificar que estás en la rama main
cd arguello-mobile
git status
# Debe decir: "On branch main"
```

### Preparación

```bash
# 1. Actualizar tu rama
git pull origin main

# 2. Verificar estado limpio
git status
# No debe haber cambios sin comitear

# 3. Crear una rama de feature (opcional pero recomendado)
git checkout -b refactor/vibe-engineering-structure
```

---

## FASE 1: Crear estructura de carpetas (5 min)

### Opción A: Script automático

```bash
# Ejecutar el script que crea todas las carpetas
bash 01-SETUP-ESTRUCTURA-COMPLETO.sh

# Output esperado:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ✅ IMPLEMENTACIÓN COMPLETADA
# ✅ Carpetas creadas: skills/, prompts/, docs/, ...
# ✅ Archivos creados: docs/00-INDICE.md, .structure-check.sh
# ✅ ¡Estructura implementada correctamente!
```

### Opción B: Comandos manuales

```bash
cd arguello-mobile

# Crear carpetas raíz
mkdir -p skills prompts docs

# Crear subcarpetas de docs
mkdir -p docs/{01-PROYECTO,02-ESPECIFICACIONES,03-DISEÑO,04-BACKEND,05-INTEGRACION,06-OPERATIVO}

# Crear subcarpetas de components
mkdir -p src/components/{cards,forms,states}

# Crear subcarpetas de hooks
mkdir -p src/hooks/{auth,features,common}

# Crear .gitkeep en carpetas inicialmente vacías
touch prompts/.gitkeep
touch src/components/cards/.gitkeep
touch src/components/forms/.gitkeep
touch src/components/states/.gitkeep
touch src/hooks/auth/.gitkeep
touch src/hooks/features/.gitkeep
touch src/hooks/common/.gitkeep
touch docs/*/.gitkeep

echo "✅ Estructura de carpetas creada"
```

### Verificar

```bash
# Ver la estructura creada
tree -L 2 .

# O con ls
ls -la | grep "^d"
ls -la docs/
ls -la src/components/
ls -la src/hooks/
```

---

## FASE 2: Copiar archivos de referencia (10 min)

### Archivos que necesitas tener

Antes de copiar, verifica que tienes estos archivos en tu directorio de trabajo o en `/mnt/user-data/outputs/`:

```
- DESIGN-SYSTEM-ARGUELLO-MOBILE.md
- VALIDACION-MODELO-DATOS-ARGUELLO.md
- 04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md
- 01-documento-alcance.md
- 02-arquitectura.md
- 03-ARGUELLO-MOBILE-FEATURES.md
- 05-ARGUELLO-MOBILE-WIREFRAMES.md
- 06-ARGUELLO-MOBILE-FLUJOS-NAVEGACION.md
- REUSABLE-LINGUA-PARA-ARGUELLO.md
- WORKFLOW-VIBE-ENGINEERING-31-08.md
```

### Copiar archivos

```bash
cd arguello-mobile

# 1. Copiar a skills/
cp ../DESIGN-SYSTEM-ARGUELLO-MOBILE.md skills/design.md
cp ../VALIDACION-MODELO-DATOS-ARGUELLO.md skills/database.md
cp ../04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md skills/testing.md

# 2. Copiar a docs/01-PROYECTO/
cp ../01-documento-alcance.md docs/01-PROYECTO/
cp ../02-arquitectura.md docs/01-PROYECTO/

# 3. Copiar a docs/02-ESPECIFICACIONES/
cp ../03-ARGUELLO-MOBILE-FEATURES.md docs/02-ESPECIFICACIONES/04-ARGUELLO-FEATURES.md
cp ../04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md docs/02-ESPECIFICACIONES/05-CRITERIOS-ACEPTACION.md
cp ../05-ARGUELLO-MOBILE-WIREFRAMES.md docs/02-ESPECIFICACIONES/06-WIREFRAMES.md
cp ../06-ARGUELLO-MOBILE-FLUJOS-NAVEGACION.md docs/02-ESPECIFICACIONES/07-FLUJOS-NAVEGACION.md

# 4. Copiar a docs/03-DISEÑO/
cp ../DESIGN-SYSTEM-ARGUELLO-MOBILE.md docs/03-DISEÑO/DESIGN-SYSTEM.md

# 5. Copiar a docs/04-BACKEND/
cp ../VALIDACION-MODELO-DATOS-ARGUELLO.md docs/04-BACKEND/MODELO-DATOS.md

# 6. Copiar a docs/05-INTEGRACION/
cp ../REUSABLE-LINGUA-PARA-ARGUELLO.md docs/05-INTEGRACION/LINGUA-REUTILIZABLE.md
cp ../WORKFLOW-VIBE-ENGINEERING-31-08.md docs/05-INTEGRACION/WORKFLOW-VIBE.md
```

### Verificar copias

```bash
# Verificar skills/
ls -la skills/
# ✅ design.md, database.md, testing.md

# Verificar docs/
find docs -name "*.md" -type f | wc -l
# ✅ Debe tener 20+ archivos

# Contar archivos
echo "Total archivos .md:"
find . -name "*.md" -type f | wc -l
```

---

## FASE 3: Crear AGENTS.md + README (5 min)

### A. Copiar AGENTS.md a raíz

```bash
cd arguello-mobile

# Copiar AGENTS.md
cp ../AGENTS.md .

# O si AGENTS.md está en outputs/
cp /mnt/user-data/outputs/AGENTS.md .

# Verificar
ls -la AGENTS.md
wc -l AGENTS.md
# ✅ Debe tener ~537 líneas
```

### B. Crear README.md

```bash
cd arguello-mobile

# Crear README.md (ver archivo 03-CREAR-AGENTS-Y-REFERENCIA.sh)
# O copiar el archivo generado
cp /mnt/user-data/outputs/README-GENERADO.md README.md

# O crear manualmente
cat > README.md << 'EOFREADME'
# 📱 Argüello Infancias Mobile

Sistema móvil para acompañamiento diario de menores en residencias bajo protección judicial.

## 🚀 Inicio Rápido

```bash
git clone <repo>
cd arguello-mobile
npm install
cp .env.example .env.local
# Editar .env.local
expo start
```

## 📚 Documentación

- **Primero:** [`docs/00-INDICE.md`](docs/00-INDICE.md)
- **Arquitectura:** [`docs/01-PROYECTO/`](docs/01-PROYECTO/)
- **Features:** [`docs/02-ESPECIFICACIONES/`](docs/02-ESPECIFICACIONES/)
- **Implementar:** [`docs/05-INTEGRACION/WORKFLOW-VIBE.md`](docs/05-INTEGRACION/WORKFLOW-VIBE.md)

## 📋 Stack

- Frontend: Expo 50+ + React Native + TypeScript
- Backend: Node.js 20+ + Express.js
- Database: Supabase PostgreSQL 15+
- UI: NativeWind 2.x + Tailwind CSS

## 👥 Equipo

- Jordy (Producto)
- Meli (QA)
- Cami (UI/UX)
- Sofi (Backend)

EOFREADME

# Verificar
ls -la README.md
head -20 README.md
```

### C. Crear docs/00-INDICE.md

```bash
cd arguello-mobile

# Crear el índice principal
cat > docs/00-INDICE.md << 'EOFINDICE'
# 📚 ÍNDICE — Documentación de Argüello Infancias Mobile

**Última actualización:** 31 de Agosto 2026

## 📖 Navegación Rápida

### 👋 Nuevo en el proyecto
1. Lee [`01-PROYECTO/01-documento-alcance.md`](01-PROYECTO/01-documento-alcance.md)
2. Lee [`01-PROYECTO/02-arquitectura.md`](01-PROYECTO/02-arquitectura.md)
3. Sigue [`06-OPERATIVO/SETUP-LOCAL.md`](06-OPERATIVO/SETUP-LOCAL.md)

### 🎨 Voy a implementar una Feature
1. Lee [`02-ESPECIFICACIONES/04-ARGUELLO-FEATURES.md`](02-ESPECIFICACIONES/04-ARGUELLO-FEATURES.md)
2. Lee criterios en [`02-ESPECIFICACIONES/05-CRITERIOS-ACEPTACION.md`](02-ESPECIFICACIONES/05-CRITERIOS-ACEPTACION.md)
3. Lee [`03-DISEÑO/DESIGN-SYSTEM.md`](03-DISEÑO/DESIGN-SYSTEM.md)
4. Lee [`04-BACKEND/MODELO-DATOS.md`](04-BACKEND/MODELO-DATOS.md)
5. Sigue [`05-INTEGRACION/WORKFLOW-VIBE.md`](05-INTEGRACION/WORKFLOW-VIBE.md)

### 🐛 Tengo un problema
Consulta [`06-OPERATIVO/TROUBLESHOOTING.md`](06-OPERATIVO/TROUBLESHOOTING.md)

## 📁 Estructura

- **01-PROYECTO/** - Alcance, Arquitectura, Stack
- **02-ESPECIFICACIONES/** - Features, Criterios, Wireframes
- **03-DISEÑO/** - Design System, Componentes
- **04-BACKEND/** - Datos, APIs, Seguridad
- **05-INTEGRACION/** - Lingua, Vibe Workflow
- **06-OPERATIVO/** - Setup, Emulador, Troubleshooting

EOFINDICE

# Verificar
ls -la docs/00-INDICE.md
```

---

## FASE 4: Validar estructura (5 min)

### Opción A: Script de validación

```bash
cd arguello-mobile

# Ejecutar script de validación
bash .structure-check.sh

# Output esperado:
# 🔍 Validando estructura del proyecto...
# 
# 📁 Verificando carpetas...
# [todas las carpetas validadas]
# 
# ✅ Estructura validada correctamente
```

### Opción B: Validación manual

```bash
cd arguello-mobile

echo "Validando estructura..."

# Verificar carpetas principales
[ -d "skills" ] && echo "✅ skills/" || echo "❌ skills/"
[ -d "prompts" ] && echo "✅ prompts/" || echo "❌ prompts/"
[ -d "docs" ] && echo "✅ docs/" || echo "❌ docs/"
[ -d "src/components/cards" ] && echo "✅ src/components/cards/" || echo "❌ src/components/cards/"
[ -d "src/hooks/auth" ] && echo "✅ src/hooks/auth/" || echo "❌ src/hooks/auth/"

# Verificar archivos
[ -f "AGENTS.md" ] && echo "✅ AGENTS.md" || echo "❌ AGENTS.md"
[ -f "README.md" ] && echo "✅ README.md" || echo "❌ README.md"
[ -f "docs/00-INDICE.md" ] && echo "✅ docs/00-INDICE.md" || echo "❌ docs/00-INDICE.md"

echo ""
echo "✅ Validación completada"
```

---

## FASE 5: Git commit & push (5 min)

### Paso 1: Ver cambios

```bash
cd arguello-mobile

git status

# Esperado: Untracked files:
# AGENTS.md
# README.md
# skills/
# prompts/
# docs/
# ...
```

### Paso 2: Agregar archivos

```bash
git add AGENTS.md README.md skills/ prompts/ docs/ .structure-check.sh
```

### Paso 3: Hacer commit

```bash
git commit -m "refactor: implement Vibe Engineering + SDD project structure

- Add AGENTS.md (537 lines) - project master file
- Add skills/ with design.md, database.md, testing.md
- Add prompts/ folder for AI-generated plans
- Reorganize docs/ with 6 thematic subfolders
- Add project README.md
- Add structure validation script

This aligns the project to Vibe Engineering methodology:
- Centralized rules in AGENTS.md
- Reference tools in skills/
- Plan history in prompts/
- Organized specification in docs/"
```

### Paso 4: Hacer push

```bash
git push origin main
# O si estás en rama de feature:
git push origin refactor/vibe-engineering-structure

# Crear pull request en GitHub si estás en rama de feature
```

### Paso 5: Verificar

```bash
git log --oneline -3

# Verificar en GitHub
# https://github.com/tuusuario/arguello-mobile
```

---

## ✅ CHECKLIST FINAL

### Antes de terminar, verifica:

```
ESTRUCTURA
  ☐ skills/ existe (design.md, database.md, testing.md)
  ☐ prompts/ existe (vacía, con .gitkeep)
  ☐ docs/ reorganizado (6 subcarpetas)
  ☐ src/components/ con subcarpetas (cards, forms, states)
  ☐ src/hooks/ con subcarpetas (auth, features, common)

ARCHIVOS
  ☐ AGENTS.md en raíz (537 líneas)
  ☐ README.md en raíz
  ☐ docs/00-INDICE.md existe
  ☐ .structure-check.sh existe

GIT
  ☐ git status = limpio
  ☐ Commits hechos (log muestra cambios)
  ☐ Push completado (rama actualizada en GitHub)

VALIDACIÓN
  ☐ bash .structure-check.sh = ✅ Estructura validada
  ☐ tree -L 2 = muestra estructura completa
  ☐ find . -name "*.md" = 20+ archivos .md
```

---

## 🎉 ¡COMPLETADO!

Estructura de proyecto implementada correctamente.

**Próximos pasos:**

1. **Copiar documentación:** Asignar tareas a Meli, Cami, Sofi
2. **Crear componentes:** Empezar con src/components/ui/
3. **Implementar Features:** Usar workflow Vibe Engineering

Ver: `docs/05-INTEGRACION/WORKFLOW-VIBE.md`

---

**Hora inicio:** [tu hora]  
**Hora fin:** [tu hora]  
**Tiempo total:** ~30 minutos

**Implementado por:** Jordy + Equipo  
**Fecha:** 31 de Agosto 2026

