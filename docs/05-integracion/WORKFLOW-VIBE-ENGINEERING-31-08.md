# 🔄 WORKFLOW VIBE ENGINEERING — 31 de Agosto 2026

**Cómo trabaja tu equipo alineado a Vibe Engineering**

---

## 📊 CAMBIOS PRINCIPALES

### ANTES (Sin Vibe)
```
Jordy: "Construir F1: Consultar residentes"
    ↓
Claude Code: Código directo
    ↓
Meli: Revisar código (❌ muy tarde)
```

### AHORA (Con Vibe)
```
Jordy: "Construir F1" (+ AGENTS.md + skills/)
    ↓
Claude Code: PLAN en prompts/01-plan.md
    ↓
Meli: Revisar PLAN (✓ tiempo para ajustar)
    ↓
Jordy: "✓ Aprobado"
    ↓
Claude Code: Código del plan
    ↓
Meli: Verificar resultado (superficial)
```

---

## 👥 ROLES (Actualizado)

### **JORDY** (Product + Architecture)
```
Responsabilidades:
✓ Mantener AGENTS.md actualizado
✓ Revisar y APROBAR planes de Claude Code
✓ Decidir si el plan es correcto antes de implementar
✓ Integrar componentes con BD
```

### **MELI** (QA + Requirements)
```
Responsabilidades:
✓ Leer el plan propuesto por Claude Code
✓ Verificar que cumple los criterios (51)
✓ Señalar gaps o riesgos ANTES de código
✓ Probar resultado final
```

### **CAMI** (UI/UX)
```
Responsabilidades:
✓ Mantener skills/design.md actualizado
✓ Crear/refinar componentes
✓ Revisar que plan respeta design system
```

### **SOFI** (Backend + Database)
```
Responsabilidades:
✓ Mantener skills/database.md actualizado
✓ Revisar que plan de BD es correcto
✓ Auditoría y seguridad (RLS policies)
```

---

## 🚀 CICLO DE VIBE (Paso a Paso)

### PASO 1: Preparación (Tu responsabilidad)

Crear estructura de carpetas:
```
arguello-mobile/
├── AGENTS.md                    ← El archivo maestro
├── skills/
│   ├── design.md               ← Componentes, colores, tipografía
│   ├── database.md             ← 7 tablas, restricciones
│   └── testing.md              ← Los 51 criterios
├── prompts/                    ← Aquí la IA escribe sus planes
│   ├── 01-consultar-residentes-plan.md
│   ├── 01-consultar-residentes-impl.md
│   ├── 02-registrar-novedades-plan.md
│   └── ...
├── src/
│   ├── app/
│   ├── components/
│   └── ...
```

---

### PASO 2: Enviar a Claude Code

**Prompt inicial (corto, pero potente):**

```
"Eres ingeniero principal con 10+ años.

Para esta solicitud (F1: Consultar residentes):

1. Lee arguello-mobile/AGENTS.md (reglas del proyecto)
2. Lee arguello-mobile/skills/design.md (componentes)
3. Lee arguello-mobile/skills/database.md (modelo datos)
4. Inspecciona src/app/(tabs)/residentes.tsx (código actual)

ESCRIBE UN PLAN en prompts/01-consultar-residentes-plan.md:
- ¿Qué archivos modificas?
- ¿Qué APIs llamas? (ver AGENTS.md § 6)
- ¿Qué datos trae la BD?
- ¿Cómo cumples CA-01 a CA-07 (ver skills/testing.md)?
- ¿Chequeos a correr?

NO IMPLEMENTES TODAVÍA.
Espera aprobación (responde '✓ Aprobado' o '✕ Cambiar X')."
```

---

### PASO 3: Revisar el Plan (CRÍTICO)

**Meli Lee:** `prompts/01-consultar-residentes-plan.md`

**Meli Valida contra criterios:**
- [ ] ¿Cumple CA-01? (Listar residentes asignados)
- [ ] ¿Cumple CA-02? (Mostrar nombre)
- [ ] ¿Cumple CA-03? (Mostrar edad calculada)
- [ ] ¿Cumple CA-04? (Mostrar foto)
- [ ] ¿Cumple CA-05? (Mostrar alertas)
- [ ] ¿Cumple CA-06? (Filtros)
- [ ] ¿Cumple CA-07? (Refresh)

**Meli Valida contra arquitectura:**
- [ ] ¿APIs definidas en AGENTS.md?
- [ ] ¿Respeta RBAC?
- [ ] ¿BD schema es correcto?
- [ ] ¿Design tokens usados correctamente?

**Meli Decide:**
```
✓ TODO OK  →  "✓ Aprobado"
✕ Problemas  →  "✕ Cambiar: falta endpoint para [X]"
```

---

### PASO 4: Aprobación (Tú respondes)

**Tú (Jordy) lees el plan:**
- ¿Arquitectura tiene sentido?
- ¿Integración con BD es correcta?
- ¿Respeta la "Regla 1" del AGENTS.md?

**Tú respondes en el chat:**

```
Si todo OK:
  "✓ Aprobado"

Si hay problemas:
  "✕ Cambiar: 
   - Endpoint no existe, crearemos /api/residentes
   - Falta JOIN con perfiles_usuarios para RBAC
   - Usar Zustand, no Context"
```

---

### PASO 5: Implementación

Claude Code corre con el plan aprobado:

```
"Plan aprobado. Implementando...

1. Modifico: src/app/(tabs)/residentes.tsx
2. Creo: src/lib/api.ts endpoint GET /api/residentes
3. Actualizo: src/store/residentStore.ts
4. Corro chequeos:
   - ✓ npm run typecheck
   - ✓ npm run lint
   - ✓ expo start (compila)
5. Pasos para probar:"
```

---

### PASO 6: Verificación Final

**Meli testa:** ¿Cumple los 7 criterios?
```
✓ Listar residentes asignados
✓ Mostrar nombre
✓ Mostrar edad calculada
✓ Mostrar foto
✓ Mostrar alertas importantes
✓ Filtros funcionan
✓ Refresh actualiza
```

**Jordy integra:** ¿Se conecta correctamente con BD?
```
✓ Datos llegan de Supabase
✓ RBAC funciona (educador ve solo asignados)
✓ Auditoría registra acceso
```

**Cami valida:** ¿Respeta design system?
```
✓ Colores Argüello
✓ Tipografía Poppins
✓ Espaciado scale
✓ Componentes reutilizados
```

**Sofi verifica:** ¿BD está íntegra?
```
✓ Indices funcionan
✓ RLS policies activas
✓ Audit log registra cambios
```

---

## 📋 CHECKLIST DIARIO (Vibe-Aligned)

### Para Jordy (Comandante)
```
[ ] AGENTS.md actualizado y en repo
[ ] skills/ completos
[ ] He leído el plan antes de aprobarlo
[ ] Aprobé con "✓ Aprobado"
[ ] Integré componentes con BD
```

### Para Meli (QA + Validadora de Planes)
```
[ ] Leí el plan ANTES de que Claude Code code
[ ] Validé contra los 51 criterios
[ ] Verifiqué que cumple CA-01 a CA-07 (o la Feature)
[ ] Señalé gaps en el plan
[ ] Testé el resultado final
```

### Para Cami (UI/Guardia del Diseño)
```
[ ] skills/design.md actualizado
[ ] Componentes listos para usar
[ ] Validé que plan respeta design system
[ ] Colores, tipografía, spacing correctos
```

### Para Sofi (Backend + Security)
```
[ ] skills/database.md actualizado
[ ] BD schema correcto (7 tablas)
[ ] RLS policies funcionan
[ ] Audit log registra cambios
[ ] Secrets en .env, nunca en código
```

---

## 🔄 EJEMPLO REAL: F1 HOY (31/08)

### 09:00 STANDUP
```
Jordy: "Voy a pedir a Claude Code que haga F1"
Meli:  "Yo reviso el plan antes de código"
Cami:  "Yo validar componentes"
Sofi:  "Yo validar BD"
```

### 10:00 PROMPT A CLAUDE CODE
```
[Jordy escribe en Claude Code]

"Eres ingeniero principal.

F1: Consultar residentes

Lee:
- AGENTS.md (contexto)
- skills/design.md (UI tokens)
- skills/database.md (tablas)
- skills/testing.md (7 criterios)

Escribe PLAN en prompts/01-plan.md

NO implementes. Espera ✓"
```

### 10:15 PLAN LISTO
```
[Claude Code escribe en prompts/01-plan.md]

Arquitectura:
- GET /api/residentes (devuelve residentes asignados)
- UI: ResidentCard lista
- Zustand: residentStore.ts
- BD: SELECT * FROM residentes WHERE id IN (...)

Criterios:
✓ CA-01: Listar → SELECT
✓ CA-02: Nombre → Field residentes.nombre
✓ CA-03: Edad → Calcular age(fecha_nacimiento)
✓ CA-04: Foto → foto_url
✓ CA-05: Alertas → alertas_importantes
✓ CA-06: Filtros → query params ?search=
✓ CA-07: Refresh → refetch on focus

Chequeos: typecheck, lint, expo start
```

### 10:30 REVISIÓN DE PLAN
```
[Meli lee el plan]

✓ Cumple todos los criterios
✓ APIs están en AGENTS.md
✓ Design system respetado
✓ BD schema correcto
✓ RBAC implementado

Meli responde: "✓ Aprobado"
```

### 10:35 APROBACIÓN
```
[Jordy lee + aprueba]

Jordy responde en Claude Code: "✓ Aprobado"
```

### 10:40 IMPLEMENTACIÓN
```
[Claude Code implementa el plan]

Modifica:
- src/app/(tabs)/residentes.tsx
- src/lib/api.ts (GET /api/residentes)
- src/store/residentStore.ts
- src/components/ResidentCard.tsx

Corre chequeos:
✓ npm run typecheck
✓ npm run lint
✓ expo start

"Pasos para probar F1:
1. expo start
2. Ir a tab Residentes
3. Debe mostrar 3+ residentes con nombre, foto, edad
4. Filtro busca por nombre
5. Pull to refresh actualiza"
```

### 11:30 VERIFICACIÓN FINAL
```
[Meli testa]
✓ Listar residentes OK
✓ Nombre OK
✓ Edad calculada OK
✓ Foto carga OK
✓ Alertas OK
✓ Filtro OK
✓ Refresh OK

[Cami valida UI]
✓ Colores Argüello
✓ Tipografía Poppins
✓ ResidentCard reutilizado

[Sofi verifica BD]
✓ Query es eficiente (tiene índice)
✓ RBAC funciona
✓ Audit log registra

"F1 ✅ LISTO"
```

### 12:00 → SIGUIENTE FEATURE (F2)
```
Mismo ciclo, pero ahora "Registrar novedades"

[Repetir: plan → aprobación → código → verificación]
```

---

## 🎯 MÉTRICAS DE ÉXITO (Vibe)

### Antes (Sin Vibe)
```
- 3-4 iteraciones por Feature (revisas código, falla, reescribe)
- Plan implícito en tu cabeza
- Claudeno Code hace suposiciones
- Testing al final (caro)
- Documentación dispersa
```

### Ahora (Con Vibe)
```
✅ 1 iteración por Feature (plan OK → código OK)
✅ Plan explícito en prompts/
✅ Claude Code sigue instrucciones exactas
✅ Testing antes de código
✅ Documentación centralizada (AGENTS.md + skills/)
```

---

## 📁 ESTRUCTURA FINAL (Hoy)

```
arguello-mobile/
├── AGENTS.md                    ← ⭐ EL COMANDANTE
│
├── skills/
│   ├── design.md               ← Componentes + colores
│   ├── database.md             ← 7 tablas exactas
│   └── testing.md              ← 51 criterios
│
├── prompts/
│   ├── 01-consultar-residentes-plan.md     ← TÚ REVISAS ESTO
│   ├── 01-consultar-residentes-impl.md     ← IA EJECUTA
│   ├── 02-registrar-novedades-plan.md
│   ├── 02-registrar-novedades-impl.md
│   └── ...
│
├── src/
│   ├── app/
│   ├── components/
│   ├── store/
│   └── lib/
│
└── package.json

```

---

## ✅ CONCLUSIÓN

**Vibe Engineering = Control maximal con mínimo trabajo**

- TÚ defines las reglas una vez (AGENTS.md)
- CLAUDE CODE escribe planes (prompts/)
- TÚ revisas planes (5 min), no código (30 min)
- CLAUDE CODE implementa conforme al plan
- TÚ verificas resultado (15 min)

**Iteración baja, calidad alta.**

---

**Implementar esto hoy (31/08) 9:00-10:00 AM.**

Después de esto, todo Feature sigue el mismo flujo.

**¡Adelante!** 🚀

