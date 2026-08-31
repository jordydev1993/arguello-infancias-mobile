# UNIFICACIÓN AGENTS-MOBILE.md

## ¿Qué se unificó?

Se combinó el **AGENTS-MOBILE.md que subiste** (orientado al contexto académico/educativo) con el que **creé internamente** (orientado al stack técnico/operativo).

---

## 📊 COMPARACIÓN: ANTES vs DESPUÉS

### ANTES (Tu archivo)

✅ Contexto educativo (ABP, materia, proyecto final)  
✅ Justificación de existencia de mobile  
✅ Relación con sistema web  
✅ Descripción general de 6 Features  
❌ Stack técnico incompleto  
❌ Estructura del proyecto  
❌ Types/Schemas para desarrolladores  
❌ Flujos de navegación  
❌ Workflow de desarrollo  

### DESPUÉS (Archivo unificado)

✅ Contexto educativo (todo lo tuyo)  
✅ Justificación y relación con web  
✅ Descripción general de 6 Features  
✅ **Stack técnico completo** (frontend + backend + mobile-specific)  
✅ **Arquitectura mobile** (cliente-servidor)  
✅ **Estructura de carpetas** (cómo organizar proyecto)  
✅ **Tipos y validaciones** (TypeScript + Zod)  
✅ **Flujos principales** (F1-F6)  
✅ **Componentes reutilizables** (ResidentCard, etc.)  
✅ **Principios de desarrollo** (Features vs Pantallas)  
✅ **Workflow Vibe Engineering** (cómo hacer cada Feature)  
✅ **Reglas no negociables** (seguridad, auditoría, RBAC)  
✅ **Checklist antes de empezar**  

---

## 🔄 LO QUE SE AGREGÓ (Fusión)

### 1. Stack Técnico Completo

**FRONTEND MOBILE:**
```
Expo + React Native + TypeScript + Zustand + AsyncStorage + Supabase Client
```

**BACKEND COMPARTIDO:**
```
Node.js + Express + PostgreSQL + JWT + MFA + crypto-js
```

**MOBILE-SPECIFIC:**
```
SecureStore para tokens, timeout sesión, offline sync, certificate pinning
```

### 2. Arquitectura Visual

Diagram de cliente → backend → base de datos con flujos HTTPS + JWT.

### 3. Datos Accesibles en Mobile

✅ Lo que sí se puede ver/modificar  
❌ Lo que NO se toca desde mobile  

**Ej:**
- ✅ Ver medicamentos activos
- ❌ Modificar medicamentos (solo web)
- ✅ Registrar administración de medicamento

### 4. Estructura de Carpetas

```
cielo-mobile/
├── app/ (Expo Router)
├── components/ (reutilizables)
├── hooks/ (lógica compartida)
├── lib/ (Supabase, validación)
├── store/ (Zustand)
├── types/ (TypeScript)
└── utils/ (helpers)
```

### 5. Componentes Reutilizables

- **ResidentCard** → Mostrar NNA
- **ActivityCard** → Mostrar actividad
- **AlertCard** → Alertas/críticas
- **PrimaryButton, SecondaryButton, CriticalButton** → Botones
- **LoadingState, EmptyState, ErrorState** → Estados comunes

### 6. Flujos Principales

Cómo navega el usuario en cada Feature (F1-F6).

### 7. Principios de Desarrollo

**No Pantallas, Sino Features:**
```
❌ "Pantalla de residentes"
✅ "Consultar residentes"
```

**Desarrollo Incremental:**
```
1. F1 — Consultar residentes
2. F2 — Registrar novedades
3. F3 — Consultar historial
4. F4 — Registrar actividades
5. F5 — Consultar turno
6. F6 — Situación crítica
```

### 8. Workflow de Desarrollo (Vibe Engineering)

Para cada Feature:
1. Lee documentación
2. Identifica Feature y flujo
3. Escribe prompt en `prompts/`
4. Obtén aprobación
5. Implementa
6. Valida

### 9. Seguridad & RBAC

```
Educador solo ve:
- NNA asignados (filtro automático)
- Sus turnos
- Datos de su área

NO ve:
- NNA de otros educadores
- Auditoría completa
- Datos sensibles de web
```

### 10. Testing

- Unit tests (Zod, formatters)
- Integration tests (API + BD)
- E2E tests (flujos usuario)
- Coverage de criterios CA-01 a CA-51

### 11. Reglas No Negociables

```
✅ Seguridad > Velocidad
✅ Datos sensibles = Cifrados
✅ Auditoría de todo
✅ RBAC estricto
✅ Código claro
✅ Tests siempre
```

### 12. Git & Commits

```
✅ feat: agregar consulta de residentes
❌ cambios
❌ final
```

---

## 📝 SECCIONES CLAVE

### Tu Contenido (Preservado)

- Proyecto General (ABP, Trabajo Final, contexto educativo)
- Objetivo General (6 Features)
- Propósito Móvil vs Web
- Relación con sistema principal

### Mi Contenido (Agregado)

- Stack Técnico Móvil (Expo, React Native, Supabase)
- Arquitectura Mobile (diagrama cliente-servidor)
- Datos Disponibles (qué sí, qué no)
- Estructura del Proyecto (carpetas, organizacion)
- Componentes Reutilizables
- Flujos Principales (F1-F6)
- Principios de Desarrollo (Features vs Pantallas)
- Workflow Vibe Engineering
- Testing Strategy
- Seguridad & RBAC
- Reglas No Negociables
- Checklist Antes de Empezar

### Fusion: Features

Ambos tenemos las 6 Features, pero ahora están:
- Mejor organizadas (tabla resumen)
- Con wireframes referenciados (WF-03, etc.)
- Con criterios referenciados (CA-01, etc.)
- Con validaciones específicas
- Con datos requeridos exactos

---

## 🎯 RESULTADO FINAL

**Un archivo AGENTS-MOBILE.md que combina:**

1. **Contexto académico** (por qué existe, proyecto final)
2. **Contexto operativo** (cómo funciona, stack, architecture)
3. **Contexto desarrollador** (estructura, componentes, flujos)
4. **Contexto usuario** (qué hace cada Feature)
5. **Contexto qa/testing** (criterios, validaciones, tests)

**= Un documento único de referencia para todo el equipo**

---

## 📋 TABLA: Cambios Principales

| Sección | Original | Unificado | Cambio |
|---------|----------|-----------|--------|
| Contexto ABP | ✅ | ✅ Preservado | Igual |
| 6 Features | ✅ Básico | ✅ Detallado | +Criterios, flujos |
| Stack técnico | ❌ Nada | ✅ Completo | +Agregado |
| Arquitectura | ❌ Nada | ✅ Diagrama | +Agregado |
| Estructura código | ❌ Nada | ✅ Carpetas | +Agregado |
| Componentes | ❌ Nada | ✅ 6 componentes | +Agregado |
| Flujos usuario | ❌ Nada | ✅ 7 flujos | +Agregado |
| Seguridad/RBAC | ✅ Mencionado | ✅ Detallado | +Expandido |
| Testing | ❌ Nada | ✅ Estrategia | +Agregado |
| Workflow desarrollo | ❌ Nada | ✅ Vibe Engineering | +Agregado |
| Reglas oro | ❌ Nada | ✅ 8 reglas | +Agregado |

---

## 🔗 RELACIONAMIENTO CON OTROS ARCHIVOS

**AGENTS-MOBILE.md (este)** ahora referencia:

- **01-documento-alcance.md** → Alcance general
- **02-arquitectura.md** → Arquitectura web (compartida)
- **03-CIELO-MOBILE-FEATURES.md** → Detalle Features (110%)
- **04-CRITERIOS-ACEPTACION.md** → 51 criterios verificables
- **05-WIREFRAMES.md** → 15 wireframes de UI
- **06-FLUJOS-NAVEGACION.md** → Navegación entre pantallas
- **BRIEF-CLAUDE-CODE.md** → Cómo empezar proyecto

**Nota:** No hay duplicación. Cada archivo tiene su propósito:

- AGENTS-MOBILE.md = Qué hacer (Features, principios, workflow)
- 03-FEATURES.md = Descripción extendida de cada Feature
- 04-CRITERIOS.md = Pruebas verificables
- 05-WIREFRAMES.md = Diseño UI/UX
- 06-FLUJOS.md = Navegación entre pantallas

---

## ✅ CHECKLIST: ¿Se unificó correctamente?

- [x] Preservó contexto educativo/académico
- [x] Agregó stack técnico completo
- [x] Agregó estructura del proyecto
- [x] Agregó tipos/schemas TypeScript
- [x] Agregó componentes reutilizables
- [x] Agregó flujos de navegación
- [x] Agregó principios de desarrollo
- [x] Agregó workflow Vibe Engineering
- [x] Agregó reglas no negociables
- [x] Agregó checklist
- [x] No eliminó contenido original
- [x] Mantiene coherencia general
- [x] Referencia archivos relacionados
- [x] Es **documento único de referencia**

---

## 🚀 CÓMO USAR AHORA

**ANTES (Dos versiones):**
```
- Versión académica (tu AGENTS-MOBILE.md)
- Versión técnica (mi AGENTS-MOBILE.md interno)
→ Confusión: ¿cuál uso?
```

**AHORA (Una versión):**
```
- AGENTS-MOBILE.md (Unificado)
  ├─ Contexto académico + operativo
  ├─ Técnico + usuario
  ├─ Features + componentes
  └─ Principios + workflow
→ Claridad: Un archivo, todo lo que necesitas
```

---

## 📍 Ubicación del Archivo

**Archivo unificado:**
```
/mnt/user-data/outputs/AGENTS-MOBILE-UNIFICADO-FINAL.md
```

Usa este archivo como tu **AGENTS-MOBILE.md único**.

---

## 💡 Beneficio de la Unificación

**Antes:** Necesitabas leer 2 documentos + adivinar conflictos  
**Después:** Lees 1 documento + está todo coordinado

**Antes:** Ambigüedad en qué usar  
**Después:** Una "fuente de verdad" clara

**Antes:** Difícil onboarding de nuevos desarrolladores  
**Después:** Documento único que responde todas preguntas

---

**La unificación transforma AGENTS-MOBILE.md en un documento prescriptivo y autosuficiente.** 🎯
