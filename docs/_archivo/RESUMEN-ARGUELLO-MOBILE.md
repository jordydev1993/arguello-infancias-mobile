> ⚠️ **ARCHIVADO (2026-08-31).** Previo a la reorganización de `docs/`. Referencia actual: [`../00-INDICE.md`](../00-INDICE.md). Las rutas de archivos citadas acá ya no son válidas.

# 📱 Argüello Infancias Mobile — Resumen de Documentación

## ¿Qué es Argüello Infancias Mobile?

Aplicación móvil para **acompañamiento diario de NNA en residencias** bajo protección judicial. 

Complemento del sistema web institucional — enfocado en educadores y operadores convivenciales.

---

## 📚 Documentación Completa (6 archivos)

### 1. **01-documento-alcance.md**
- Descripción general del proyecto
- Alcance, objetivos, contexto
- Requisitos funcionales y no funcionales

### 2. **02-arquitectura.md**
- Stack técnico (Expo, React Native, TypeScript, Supabase)
- Componentes de la arquitectura
- Modelos de datos
- Seguridad y autenticación

### 3. **03-ARGUELLO-MOBILE-FEATURES.md** ✅ NUEVO
**6 Features (capacidades concretas del usuario):**
1. **F1** — Consultar información de residentes
2. **F2** — Registrar novedades del turno
3. **F3** — Consultar historial de seguimiento
4. **F4** — Registrar actividades diarias
5. **F5** — Consultar novedades y tareas del turno
6. **F6** — Reportar situación crítica

### 4. **04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md** ✅ NUEVO
**51 criterios de aceptación** (DADO-CUANDO-ENTONCES)
- 7 criterios para F1
- 10 criterios para F2
- 7 criterios para F3
- 8 criterios para F4
- 8 criterios para F5
- 11 criterios para F6

**Un criterio = Una prueba verificable**

### 5. **05-ARGUELLO-MOBILE-WIREFRAMES.md** ✅ NUEVO
**15 wireframes** (soporte visual, no Features adicionales)
- WF-01 Login
- WF-02 Inicio/Dashboard
- WF-03 Listado de residentes
- WF-04 Detalle del residente
- WF-05 Registrar novedad
- WF-06 Confirmar novedad
- WF-07 Historial de seguimiento
- WF-08 Detalle del historial
- WF-09 Actividades del residente
- WF-10 Registrar/actualizar actividad
- WF-11 Mi turno
- WF-12 Detalle de novedad/tarea
- WF-13 Advertencia de situación crítica
- WF-14 Registrar situación crítica
- WF-15 Confirmar situación crítica

### 6. **06-ARGUELLO-MOBILE-FLUJOS-NAVEGACION.md** ✅ NUEVO
**Flujos de usuario** entre pantallas
- Flujo general de la app
- Flujos por Feature (F1-F6)
- Flujos de error
- Navegación por gesto
- Estados de navegación
- Mapa completo

---

## 🎨 Sobre el Link de Figma

**Link:** https://www.figma.com/make/aNsVGJfJ7GpEOX9hinqSmd/Generador-de-paletas-de-colores?...

⚠️ **No puedo acceder a URLs externas**, pero aquí está lo que necesitas hacer:

### Para obtener el diseño/paleta de colores:

1. **Abre el link en tu navegador**
2. **Copia la paleta de colores** (colores primario, secundario, crítica, éxito, error, etc.)
3. **Pega los colores en un archivo** (ej: `PALETA-COLORES.md`)
4. **Incluye en tu brief** al equipo de diseño o Claude Code

### O pasos alternativos:

```
1. Genera la paleta en Figma
2. Exporta como JSON/CSS variables
3. Crea archivo: docs/design-tokens.json
4. Usa esos tokens en toda la app (Tailwind, NativeWind)
```

---

## 🚀 Próximos Pasos para Claude Code

Tienes TODO listo para implementar:

### OPCIÓN A: Envía a Claude Code (inmediato)

```
Tengo documentación completa de Argüello Infancias Mobile:
- 01-documento-alcance.md
- 02-arquitectura.md
- 03-FEATURES.md (6 features)
- 04-CRITERIOS-ACEPTACION.md (51 criterios)
- 05-WIREFRAMES.md (15 wireframes)
- 06-FLUJOS-NAVEGACION.md (flujos usuario)

¿Generas los siguientes archivos de proyecto?
- Estructura carpetas (app/, components/, etc.)
- Configuración Expo + TypeScript
- Schemas Zod para validación
- Types para 6 Features
- Primeras 2-3 pantallas (mockup)
```

### OPCIÓN B: Primero obtén paleta de colores, luego a Claude Code

```
1. Abre Figma → copia paleta
2. Crea docs/PALETA-COLORES.md
3. Agrega a tu brief para Claude Code:
   - 6 archivos .md de funcionalidad
   - Paleta de colores específica
   - Incluye AGENTS-MOBILE.md (si usas)
4. Ask Claude Code a generar proyecto completo
```

---

## ✅ Checklist: Documentación Lista

- [x] Alcance documentado (archivo 01)
- [x] Arquitectura definida (archivo 02)
- [x] 6 Features claras (archivo 03)
- [x] 51 criterios verificables (archivo 04)
- [x] 15 wireframes diseñados (archivo 05)
- [x] Flujos de navegación (archivo 06)
- [ ] Paleta de colores (obtener de Figma)
- [ ] Setup inicial Expo (generar con Claude Code)
- [ ] Primeras pantallas (generar con Claude Code)

---

## 📊 Estadísticas

| Elemento | Cantidad |
|----------|----------|
| Features | 6 |
| Criterios de aceptación | 51 |
| Wireframes | 15 |
| Flujos documentados | 7 (principal + F1-F6) |
| Pantallas funcionales | ~12 únicas |
| Archivos .md | 6 (completos) |

---

## 🎯 Para Claude Code

**Cuando envíes los archivos a Claude Code, incluye:**

```markdown
# Brief: Argüello Infancias Mobile v1

## Documentación

1. **01-documento-alcance.md** — Alcance y requisitos
2. **02-arquitectura.md** — Stack técnico
3. **03-FEATURES.md** — 6 Features concretas
4. **04-CRITERIOS-ACEPTACION.md** — 51 criterios (usar para tests)
5. **05-WIREFRAMES.md** — 15 wireframes (referencia visual)
6. **06-FLUJOS-NAVEGACION.md** — Flujos usuario

## Tarea

Genera:
- Proyecto Expo con estructura recomendada
- Types para 6 Features
- Schemas Zod para validaciones
- Componentes reutilizables (ResidentCard, ActivityCard, etc.)
- Primeras 2-3 pantallas (mock data)

## Paleta de Colores

[Si tienes: pega aquí]

## Notas Importantes

- No son 15 Features, son 15 wireframes para soportar 6 Features
- Educadores solo tienen acceso a residentes asignados (RBAC)
- Situación crítica debe estar diferenciada visualmente (rojo/naranja)
- Offline sync requerido (AsyncStorage)
- Auditoría de todas las acciones
```

---

## 💾 Descargar Todo

**Tienes 6 archivos .md listos:**

1. ✅ `01-documento-alcance.md`
2. ✅ `02-arquitectura.md`
3. ✅ `03-ARGUELLO-MOBILE-FEATURES.md` (creado hoy)
4. ✅ `04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md` (creado hoy)
5. ✅ `05-ARGUELLO-MOBILE-WIREFRAMES.md` (creado hoy)
6. ✅ `06-ARGUELLO-MOBILE-FLUJOS-NAVEGACION.md` (creado hoy)

**Bonus:**
- `AGENTS-MOBILE.md` (si necesitas metodología de desarrollo)

---

## 🎓 Regla de Oro

> **Documentación completa → Cero ambigüedad → Implementación clara → MVP rápido**

Cada archivo que tienes es **prescriptivo, no sugestivo**. Claude Code puede ir directo a implementar sin preguntar.

---

**¿Qué sigue?**

1. Obtén paleta de colores de Figma (2 min)
2. Crea `PALETA-COLORES.md` (1 min)
3. Arma brief para Claude Code (incluye los 6 .md + paleta)
4. Claude Code genera proyecto Expo completo (30-60 min)

🚀 **¡Listo!**
