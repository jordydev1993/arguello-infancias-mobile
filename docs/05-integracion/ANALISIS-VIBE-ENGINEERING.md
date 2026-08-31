# 🔍 ANÁLISIS: Tu Trabajo Actual vs Vibe Engineering

**Fecha:** 31 de Agosto 2026  
**Documento:** Guía de Vibe Engineering (extracto analizado)

---

## 📋 RESUMEN EJECUTIVO

Después de revisar la guía de Vibe Engineering, aquí está la realidad:

```
✅ ALINEADO (70%):
   - SDD: Especificación exhaustiva ✓
   - AGENTS.md: Modelo de datos ✓
   - Documentación base ✓

⚠️ NO ALINEADO (30%):
   - Ciclo de Vibe: No implementado
   - Prompts para Claude Code: No optimizados
   - Revisión de PLAN antes de implementar: No
   - Aprobación explícita de prompts: No
   - AGENTS.md como documento único: Fragmen­tado
```

---

## 🔄 EL CICLO DE VIBE ENGINEERING (Lo que FALTA)

Según la guía, el ciclo es:

```
1. Escribir reglas UNA VEZ en AGENTS.md + skills
2. Enviar prompt CORTO apuntando a esas reglas
3. IA escribe PLAN y guarda prompt en prompts/
4. TÚ REVISAS el plan (¡PASO CRÍTICO!)
5. APRUEBAS con un "sí"
6. IA CONSTRUYE
7. IA corre chequeos
8. TÚ VERIFICAS → siguiente funcionalidad
```

---

## ✅ LO QUE YA EXISTE (BIEN HECHO)

### 1. **AGENTS.md Centralizado** ✅

**Tienes:**
```
AGENTS-MOBILE-UNIFICADO-FINAL.md
├─ Rol: SDD + Vibe Engineering Developer
├─ Flujo: 8 pasos por Feature
├─ Stack: Expo + React Native + TypeScript
└─ Reglas: Bien documentadas
```

**Falta completar:**
```
AGENTS.md (raíz) con:
├─ Dentro de alcance / Fuera de alcance
├─ Arquitectura exacta
├─ Stack + prohibiciones explícitas
├─ Contratos de API
└─ Modelo de datos (tienes, pero fragmen­tado)
```

### 2. **Especificación Detallada** ✅

```
✅ 51 criterios de aceptación (AGENTE confía en esto)
✅ 15 wireframes especificados
✅ Flujos de navegación claros
✅ Modelo de datos validado
```

### 3. **Skills/Herramientas Documentadas** ✅

```
✅ DESIGN-SYSTEM-ARGUELLO-MOBILE.md (Design Skills)
✅ CORRECCIONES-MODELO-DATOS-ARGUELLO.md (DB Skills)
✅ REUSABLE-LINGUA-PARA-ARGUELLO.md (Reutilización Skills)
```

---

## ⚠️ LO QUE FALTA (CRÍTICO PARA VIBE)

### 1. **AGENTS.md ÚNICO Y CENTRALIZADO** 🔴

**Tienes fragmentado en:**
- `AGENTS-MOBILE-UNIFICADO-FINAL.md` (móvil)
- `DESIGN-SYSTEM-ARGUELLO-MOBILE.md` (diseño)
- `VALIDACION-MODELO-DATOS-ARGUELLO.md` (BD)

**Deberías tener:**
```
arguello-mobile/
├── AGENTS.md (ESTE ES EL COMANDANTE)
│   ├── [1] ROL + FLUJO DE TRABAJO
│   ├── [2] PRODUCTO: dentro/fuera de alcance
│   ├── [3] ARQUITECTURA (UI, API, server)
│   ├── [4] STACK + PROHIBICIONES
│   ├── [5] MODELO DE DATOS
│   ├── [6] CONTRATOS DE API
│   └── [7] CHEQUEOS Y VALIDACIONES
├── skills/ (herramientas/contexto)
│   ├── design.md (colores, componentes)
│   ├── database.md (tablas, índices)
│   └── testing.md (51 criterios)
└── prompts/ (AQUÍ LA IA ESCRIBE SUS PROPIOS PROMPTS)
    ├── 01-feature-1-plan.md
    ├── 01-feature-1-implementation.md
    └── ...
```

### 2. **Carpeta `prompts/` para Planes** 🔴

**Falta:** La IA debe escribir su PLAN en `prompts/01-feature-nombre-plan.md`

**Flujo correcto:**
```
Tú:      "Construir F1: Consultar residentes"
         (prompt corto)
            ↓
IA:      Lee AGENTS.md + skills/
         Escribe plan → prompts/01-consultar-residentes-plan.md
         Escribe prompt → prompts/01-consultar-residentes-impl.md
            ↓
TÚ:      Revisas el PLAN
         ✓ Apruebas
         o ✕ Pides cambios
            ↓
IA:      Ejecuta el prompt de implementación
         Corre chequeos
         Sube código
            ↓
TÚ:      Verificas el resultado
```

### 3. **Prompts Optimizados para Claude Code** 🔴

**Falta:** Prompts que diga "Eres un ingeniero nivel senior..."

**Lo que tienes ahora:**
```
"Construir F1: Consultar residentes"
```

**Lo que DEBES tener:**
```
"Eres ingeniero nivel senior con 10+ años.
Para esta solicitud:
1. Lee arguello-mobile/AGENTS.md (reglas del proyecto)
2. Lee arguello-mobile/skills/design.md (tokens visuales)
3. Lee arguello-mobile/skills/database.md (modelo datos)
4. Inspecciona arguello-mobile/src/app/(tabs)/residentes.tsx
5. Escribe un PLAN en prompts/01-plan.md
6. Espera APROBACIÓN (una palabra: ✓)
7. Implementa según el plan
8. Corre todos los chequeos
9. Comparte pasos exactos para testear"
```

### 4. **Aprobación Explícita de Planes** 🔴

**No existe:** El workflow dice "tú revisas y apruebas"

**Debes implementar:**
```
IA escribe plan
   ↓
[PAUSA] Tú lees el plan completo
   ↓
Tú respondes: "✓ Aprobado" o "✕ Cambiar X"
   ↓
IA prosigue o reescribe
```

---

## 🎯 LO QUE VIBE ENGINEERING ESPERA

### **AGENTS.md (El Documento Único)**

```markdown
# AGENTS.md - Argüello Infancias Mobile

## [1] ROL + FLUJO
Eres ingeniero principal. Para cada funcionalidad:
- Lee este archivo
- Escribe un plan (prompts/XX-feature-plan.md)
- Espera aprobación
- Implementa
- Chequea
- Reporta

## [2] PRODUCTO
Línea 1: Qué estamos construyendo
Línea 2: En qué se diferencia

### Dentro de alcance
- F1: Consultar residentes
- F2: Registrar novedades
- F3: Consultar historial
- F4: Registrar actividades
- F5: Consultar turno
- F6: Situación crítica

### Fuera de alcance
- NO comentarios en novedades
- NO multimedia (solo foto estática)
- NO notificaciones push (MVP)
- NO offline (MVP)
- NO compartir en redes

## [3] ARQUITECTURA
UI (Expo/React Native)
  ↓ (fetch/mutate)
API (Express serverless)
  ↓ (select/insert)
DB (Supabase PostgreSQL)

Regla: Secretos NUNCA en cliente

## [4] STACK + PROHIBICIONES
Usar:
- Expo 50+
- React Native
- TypeScript (strict)
- Zustand (state)
- Supabase (auth + DB)
- NativeWind + Tailwind

NO usar:
- Redux
- Context API
- Any other auth (Clerk, Firebase)
- Axios (usa fetch)

## [5] MODELO DATOS
residentes:
  - id (UUID)
  - nombre (VARCHAR, obligatorio)
  - foto_url (TEXT)
  - fecha_nacimiento (DATE)
  - [... más campos]

novedades:
  - id (UUID)
  - residente_id (FK → residentes)
  - usuario_id (FK → perfiles_usuarios)
  - tipo_novedad (CHECK: 6 tipos)
  - descripcion (TEXT, obligatorio)
  - fecha_hora (TIMESTAMPTZ, auto)

[... otras tablas]

Restricción crítica:
  - Nunca guardar novedad sin descripción
  - Nunca guardar sin timestamp
  - Nunca eliminar residente (soft delete)

## [6] CONTRATOS API
POST /api/residentes
  input: filter (opcional)
  output: { residentes: [...] }

POST /api/novedades
  input: { residente_id, tipo, descripcion }
  output: { id, fecha_hora }
  error: 400 si falta descripcion

[... más rutas]

## [7] CHEQUEOS
Después de CADA implementación:
- [ ] npm run typecheck (sin errores)
- [ ] npm run lint (sin warnings)
- [ ] expo start (compila)
- [ ] Navegación funciona
- [ ] Datos guardados en BD
- [ ] Auditoría registra cambios
```

---

## 🚀 TU CHECKLIST HIVE-ALIGNED

### HOY (31/08) - IMPLEMENTAR VIBE

#### PASO 1: Consolidar AGENTS.md (1 hora)
```
[ ] Copiar structure de arriba
[ ] Integrar:
    - De AGENTS-MOBILE-UNIFICADO-FINAL.md
    - De DESIGN-SYSTEM-ARGUELLO-MOBILE.md
    - De VALIDACION-MODELO-DATOS-ARGUELLO.md
    - De RECOMENDACIONES-MODELO-DATOS.md
[ ] Resultado: 1 archivo AGENTES.md comprimido
[ ] Guardar: arguello-mobile/AGENTS.md
```

#### PASO 2: Crear carpeta skills/ (30 min)
```
[ ] arguello-mobile/skills/design.md
    - Colores, tipografía, componentes
    - Estilos Poppins
    - Breakpoints
    
[ ] arguello-mobile/skills/database.md
    - 7 tablas completas
    - Restricciones
    - Índices
    
[ ] arguello-mobile/skills/testing.md
    - Los 51 criterios
    - Casos de prueba
```

#### PASO 3: Reescribir prompts para Claude Code (1 hora)
```
[ ] BRIEF-CLAUDE-CODE.md (reescrito)
    - Añadir: "Lee arguello-mobile/AGENTS.md"
    - Añadir: "Escribe planes antes de código"
    - Añadir: aprobación explícita

[ ] Prompt DAILY (para cada Feature)
    - Template estándar
    - Siempre lee AGENTS.md
    - Siempre escribe plan
    - Siempre espera ✓
```

#### PASO 4: Crear carpeta prompts/ (ya hecha, pero vacía)
```
[ ] arguello-mobile/prompts/ (vacía al inicio)
    - Aquí la IA escribirá:
      - 01-feature-1-plan.md ← TÚ REVISAS
      - 01-feature-1-implementation.md
      - 02-feature-2-plan.md
      - etc.
```

---

## 📊 COMPARATIVA: AHORA vs VIBE-ALIGNED

### AHORA (Tu enfoque actual)
```
1. Especificación detallada (✓ bien)
2. Envías prompt a Claude Code
3. Claude Code implementa directo
4. TÚ revisas el CÓDIGO (❌ demasiado tarde)
   → Si hay problemas, reescribir
   → Alto costo de iteración
```

### VIBE-ALIGNED (Lo que deberías hacer)
```
1. AGENTS.md + skills/ (especificación comprimida)
2. Envías prompt CORTO a Claude Code
3. Claude Code escribe PLAN en prompts/
4. TÚ REVISAS el PLAN (✓ temprano)
   → Si hay problemas, ajustar PLAN
   → Claude Code implementa confirmado
5. Claude Code corre chequeos
6. TÚ VERIFICAS resultado (superficial)
   → Alto éxito, bajo costo de iteración
```

---

## 💡 VENTAJAS DE HACER ESTO YA

1. **Reduce iteraciones:** Si el plan es malo, se fija antes de codificar
2. **AGENTS.md reutilizable:** Vale para todos los Features
3. **Skills modulares:** Otras personas (Meli, Cami, Sofi) pueden leer skills/ sin leer 20 archivos
4. **Prompts cortos:** "Construir F1 usando AGENTS.md" (vs "aquí va toda la especificación")
5. **Histórico de decisiones:** Los prompts en `prompts/` quedan como registro

---

## 🎯 PRÓXIMOS PASOS (ORDEN)

### HOY (31/08) - 3 horas de refactor
1. **Consolidar AGENTS.md** (1 hora)
   - Archivo único, comprimido, listo para la IA

2. **Crear skills/** (30 min)
   - design.md, database.md, testing.md

3. **Reescribir prompts de Claude Code** (1 hora)
   - Template de "eres ingeniero nivel principal"
   - Flujo: plan → aprobación → implementación

4. **Crear prompts/ciclo.md** (30 min)
   - Template estándar para cada Feature
   - Checklist de chequeos

### MAÑANA (01/09) - Usar VIBE para F1 y F2

**Prompt a Claude Code:**
```
"Eres ingeniero principal.

Para F1 (Consultar residentes):

1. Lee arguello-mobile/AGENTS.md (contexto del proyecto)
2. Lee arguello-mobile/skills/design.md (diseño tokens)
3. Lee arguello-mobile/skills/database.md (modelo datos)
4. Lee 04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md (CA-01 a CA-07)
5. Inspecciona app/(tabs)/residentes.tsx actual

ESCRIBE UN PLAN en prompts/01-consultar-residentes-plan.md:
- ¿Qué archivos modificas?
- ¿Qué APIs usas?
- ¿Qué datos trae la BD?
- ¿Cómo validas contra los 7 criterios?
- ¿Chequeos a correr?

NO implementes todavía.
Espera mi aprobación (responde: '✓ Aprobado' o '✕ Cambiar X')"
```

**Tú revisas el plan en prompts/01-consultar-residentes-plan.md**

**Tú respondes: "✓ Aprobado"**

**Claude Code implementa:**
```
"Ejecuta según el plan aprobado.
Cuando termines: corre todos los chequeos.
Comparte pasos EXACTOS para probar F1."
```

---

## ✅ CONCLUSIÓN

Tu documentación es **excepcional** (10/10).  
Tu approach de Vibe Engineering es **incompleto** (5/10).

**No es un fallo, es una oportunidad.**

**Consolida AGENTS.md + skills/ hoy → mañana Vibe funciona perfecto.**

---

**¿Empezamos con el refactor de AGENTS.md?** 

Puedo ayudarte a consolidar todo en 1 archivo limpio.

