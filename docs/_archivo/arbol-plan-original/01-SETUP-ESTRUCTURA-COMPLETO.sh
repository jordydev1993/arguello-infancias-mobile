#!/bin/bash

################################################################################
#                                                                              #
#  SCRIPT DE IMPLEMENTACIÓN: ESTRUCTURA DE PROYECTO CORREGUIDA               #
#  Argüello Infancias Mobile                                                  #
#                                                                              #
#  Fecha: 31 de Agosto 2026                                                   #
#  Tiempo estimado: 10 minutos                                                #
#  Permisos: Ejecutar con: bash 01-SETUP-ESTRUCTURA-COMPLETO.sh              #
#                                                                              #
################################################################################

set -e  # Salir si hay error

# COLORES PARA OUTPUT
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# FUNCIONES AUXILIARES
print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# OBTENER DIRECTORIO DEL PROYECTO
if [ -z "$PROJECT_DIR" ]; then
    PROJECT_DIR="./arguello-mobile"
    print_warning "PROJECT_DIR no definido. Usando: $PROJECT_DIR"
    print_info "Para cambiar: export PROJECT_DIR=/ruta/a/proyecto"
fi

# VERIFICAR QUE EXISTE EL DIRECTORIO
if [ ! -d "$PROJECT_DIR" ]; then
    print_error "Directorio $PROJECT_DIR no existe"
    echo "Crea el proyecto primero con: npx create-expo-app arguello-mobile"
    exit 1
fi

print_header "IMPLEMENTACIÓN DE ESTRUCTURA DE PROYECTO - VIBE ENGINEERING"

echo "📁 Directorio base: $PROJECT_DIR"
echo "🕐 Hora inicio: $(date '+%H:%M:%S')"
echo ""

################################################################################
# FASE 1: CREAR ESTRUCTURA DE CARPETAS
################################################################################

print_header "FASE 1: Crear estructura de carpetas (Paso 1/5)"

# Carpetas raíz
print_info "Creando carpetas raíz..."
mkdir -p "$PROJECT_DIR/skills"
mkdir -p "$PROJECT_DIR/prompts"
mkdir -p "$PROJECT_DIR/docs"
print_success "Carpetas raíz creadas"

# Subcarpetas de docs
print_info "Creando subcarpetas de documentación..."
mkdir -p "$PROJECT_DIR/docs/01-PROYECTO"
mkdir -p "$PROJECT_DIR/docs/02-ESPECIFICACIONES"
mkdir -p "$PROJECT_DIR/docs/03-DISEÑO"
mkdir -p "$PROJECT_DIR/docs/04-BACKEND"
mkdir -p "$PROJECT_DIR/docs/05-INTEGRACION"
mkdir -p "$PROJECT_DIR/docs/06-OPERATIVO"
print_success "Subcarpetas de docs creadas"

# Subcarpetas de src/components
print_info "Creando subcarpetas de componentes..."
mkdir -p "$PROJECT_DIR/src/components/cards"
mkdir -p "$PROJECT_DIR/src/components/forms"
mkdir -p "$PROJECT_DIR/src/components/states"
mkdir -p "$PROJECT_DIR/src/components/ui"
print_success "Subcarpetas de componentes creadas"

# Subcarpetas de src/hooks
print_info "Creando subcarpetas de hooks..."
mkdir -p "$PROJECT_DIR/src/hooks/auth"
mkdir -p "$PROJECT_DIR/src/hooks/features"
mkdir -p "$PROJECT_DIR/src/hooks/common"
print_success "Subcarpetas de hooks creadas"

################################################################################
# FASE 2: CREAR ARCHIVOS .gitkeep
################################################################################

print_header "FASE 2: Crear archivos .gitkeep (Paso 2/5)"

# Archivos .gitkeep para carpetas inicialmente vacías
touch "$PROJECT_DIR/prompts/.gitkeep"
touch "$PROJECT_DIR/src/components/cards/.gitkeep"
touch "$PROJECT_DIR/src/components/forms/.gitkeep"
touch "$PROJECT_DIR/src/components/states/.gitkeep"
touch "$PROJECT_DIR/src/hooks/auth/.gitkeep"
touch "$PROJECT_DIR/src/hooks/features/.gitkeep"
touch "$PROJECT_DIR/src/hooks/common/.gitkeep"

print_success "Archivos .gitkeep creados"

################################################################################
# FASE 3: VALIDAR ESTRUCTURA CREADA
################################################################################

print_header "FASE 3: Validar estructura creada (Paso 3/5)"

# Función para verificar si carpeta existe
verify_folder() {
    if [ -d "$1" ]; then
        print_success "✓ $1"
        return 0
    else
        print_error "✗ $1"
        return 1
    fi
}

print_info "Verificando carpetas creadas...\n"

# Carpetas raíz
verify_folder "$PROJECT_DIR/skills"
verify_folder "$PROJECT_DIR/prompts"
verify_folder "$PROJECT_DIR/docs"

# Subcarpetas docs
verify_folder "$PROJECT_DIR/docs/01-PROYECTO"
verify_folder "$PROJECT_DIR/docs/02-ESPECIFICACIONES"
verify_folder "$PROJECT_DIR/docs/03-DISEÑO"
verify_folder "$PROJECT_DIR/docs/04-BACKEND"
verify_folder "$PROJECT_DIR/docs/05-INTEGRACION"
verify_folder "$PROJECT_DIR/docs/06-OPERATIVO"

# Subcarpetas components
verify_folder "$PROJECT_DIR/src/components/cards"
verify_folder "$PROJECT_DIR/src/components/forms"
verify_folder "$PROJECT_DIR/src/components/states"

# Subcarpetas hooks
verify_folder "$PROJECT_DIR/src/hooks/auth"
verify_folder "$PROJECT_DIR/src/hooks/features"
verify_folder "$PROJECT_DIR/src/hooks/common"

################################################################################
# FASE 4: CREAR ARCHIVOS BASE DE REFERENCIA
################################################################################

print_header "FASE 4: Crear archivos base de referencia (Paso 4/5)"

# Crear .gitkeep en cada subcarpeta de docs
print_info "Creando archivos de índice en docs..."

for folder in "$PROJECT_DIR/docs"/*/; do
    touch "${folder}.gitkeep"
done

# Crear archivo de índice principal
cat > "$PROJECT_DIR/docs/00-INDICE.md" << 'EOFINDICE'
# 📚 ÍNDICE — Documentación de Argüello Infancias Mobile

**Última actualización:** 31 de Agosto 2026

---

## 📖 Estructura de Documentación

Bienvenido a la documentación de Argüello Infancias Mobile.

Esta documentación está organizada en 6 secciones temáticas:

### 1️⃣ **01-PROYECTO/**
Alcance, arquitectura y stack técnico

- `01-documento-alcance.md` — Qué estamos construyendo
- `02-arquitectura.md` — Componentes y capas
- `03-stack-tecnico.md` — Tecnologías exactas

### 2️⃣ **02-ESPECIFICACIONES/**
Features, criterios y wireframes

- `04-ARGUELLO-FEATURES.md` — 6 Features detallados
- `05-CRITERIOS-ACEPTACION.md` — 51 criterios de aceptación
- `06-WIREFRAMES.md` — 15 wireframes especificados
- `07-FLUJOS-NAVEGACION.md` — Flujos de usuario
- `08-HISTORIAS-USUARIO.md` — Historias de usuario

### 3️⃣ **03-DISEÑO/**
Design system y componentes

- `DESIGN-SYSTEM.md` — Colores, tipografía, espaciado
- `COMPONENTES.md` — Especificación de componentes
- `UI-PATTERNS.md` — Patrones de diseño

### 4️⃣ **04-BACKEND/**
Base de datos, APIs y seguridad

- `MODELO-DATOS.md` — 7 tablas, restricciones, índices
- `APIS.md` — Contratos HTTP exactos (GET, POST, PATCH)
- `AUTENTICACION.md` — JWT + Supabase Auth
- `RLS-POLICIES.md` — Row Level Security por rol

### 5️⃣ **05-INTEGRACION/**
Reutilización e integración

- `LINGUA-REUTILIZABLE.md` — Qué copiar de Lingua
- `WORKFLOW-VIBE.md` — Ciclo Vibe Engineering
- `CHECKLIST-IMPLEMENTACION.md` — Checklist por fase

### 6️⃣ **06-OPERATIVO/**
Operaciones y troubleshooting

- `SETUP-LOCAL.md` — Cómo comenzar como developer
- `EMULADOR-ANDROID.md` — Configurar emulador
- `EAS-COMPARTIR.md` — Compartir preview con EAS
- `TROUBLESHOOTING.md` — Problemas comunes y soluciones

---

## 🔍 Cómo navegar

**Si eres nuevo en el proyecto:**
1. Lee `01-PROYECTO/01-documento-alcance.md`
2. Lee `01-PROYECTO/02-arquitectura.md`
3. Sigue `06-OPERATIVO/SETUP-LOCAL.md`

**Si necesitas implementar una Feature:**
1. Lee `02-ESPECIFICACIONES/04-ARGUELLO-FEATURES.md`
2. Lee los criterios relevantes en `02-ESPECIFICACIONES/05-CRITERIOS-ACEPTACION.md`
3. Lee `03-DISEÑO/DESIGN-SYSTEM.md`
4. Lee `04-BACKEND/MODELO-DATOS.md`
5. Sigue el workflow en `05-INTEGRACION/WORKFLOW-VIBE.md`

**Si tienes problemas:**
1. Consulta `06-OPERATIVO/TROUBLESHOOTING.md`
2. Lee `06-OPERATIVO/EMULADOR-ANDROID.md` (si es del emulador)

---

## 📁 Archivos principales (raíz del proyecto)

- **AGENTS.md** — El archivo maestro (Vibe Engineering)
- **README.md** — Intro rápida al proyecto
- **skills/design.md** — Design tokens (referencia)
- **skills/database.md** — Modelo datos (referencia)
- **skills/testing.md** — 51 criterios (referencia)

---

## 🔄 Ciclo Vibe Engineering

1. Lee AGENTS.md (reglas)
2. Lee skills/ (herramientas)
3. Escribe PLAN en prompts/
4. Espera aprobación (✓)
5. Implementa código
6. Corre chequeos
7. Verifica resultado

---

**Última actualización:** 31 de Agosto 2026
EOFINDICE

print_success "Archivo 00-INDICE.md creado"

################################################################################
# FASE 5: CREAR ARCHIVO DE VALIDACIÓN
################################################################################

print_header "FASE 5: Crear archivo de validación (Paso 5/5)"

cat > "$PROJECT_DIR/.structure-check.sh" << 'EOFCHECK'
#!/bin/bash

echo "🔍 Validando estructura del proyecto..."

ERRORS=0

# Función para verificar
check_folder() {
    if [ ! -d "$1" ]; then
        echo "❌ FALTA: $1"
        ((ERRORS++))
    fi
}

check_file() {
    if [ ! -f "$1" ]; then
        echo "❌ FALTA: $1"
        ((ERRORS++))
    fi
}

# Verificar estructura
echo ""
echo "📁 Verificando carpetas..."

# Raíz
check_folder "skills"
check_folder "prompts"
check_folder "docs"

# Docs
check_folder "docs/01-PROYECTO"
check_folder "docs/02-ESPECIFICACIONES"
check_folder "docs/03-DISEÑO"
check_folder "docs/04-BACKEND"
check_folder "docs/05-INTEGRACION"
check_folder "docs/06-OPERATIVO"

# Components
check_folder "src/components/cards"
check_folder "src/components/forms"
check_folder "src/components/states"
check_folder "src/components/ui"

# Hooks
check_folder "src/hooks/auth"
check_folder "src/hooks/features"
check_folder "src/hooks/common"

# Archivos
echo ""
echo "📄 Verificando archivos..."
check_file "AGENTS.md"
check_file "docs/00-INDICE.md"

if [ $ERRORS -eq 0 ]; then
    echo ""
    echo "✅ Estructura validada correctamente"
    exit 0
else
    echo ""
    echo "❌ Se encontraron $ERRORS errores"
    exit 1
fi
EOFCHECK

chmod +x "$PROJECT_DIR/.structure-check.sh"
print_success "Script de validación creado"

################################################################################
# RESUMEN FINAL
################################################################################

print_header "IMPLEMENTACIÓN COMPLETADA"

echo "📊 RESUMEN:"
echo ""
echo "✅ Carpetas creadas:"
echo "   • skills/"
echo "   • prompts/"
echo "   • docs/ (6 subcarpetas)"
echo "   • src/components/ (4 subcarpetas)"
echo "   • src/hooks/ (3 subcarpetas)"
echo ""
echo "✅ Archivos creados:"
echo "   • docs/00-INDICE.md"
echo "   • .structure-check.sh"
echo ""
echo "🕐 Hora fin: $(date '+%H:%M:%S')"
echo ""
echo "📋 PRÓXIMOS PASOS:"
echo "   1. Validar con: bash $PROJECT_DIR/.structure-check.sh"
echo "   2. Copiar AGENTS.md a $PROJECT_DIR/AGENTS.md"
echo "   3. Copiar skills a $PROJECT_DIR/skills/"
echo "   4. Reorganizar docs/"
echo "   5. Git commit & push"
echo ""
echo -e "${GREEN}¡Estructura implementada correctamente!${NC}"

exit 0
