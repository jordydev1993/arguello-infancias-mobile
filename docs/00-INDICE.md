# 📚 Índice de documentación — Argüello Infancias Mobile

**Actualizado:** 2026-08-31 · Todos los enlaces de abajo apuntan a archivos que existen.

Reglas del proyecto y contratos → **[`/AGENTS.md`](../AGENTS.md)** (raíz).
Herramientas de referencia → **[`/skills/`](../skills/README.md)**.
Historial de planes → **[`/prompts/`](../prompts/)**.

---

## 01 · Proyecto — [`01-proyecto/`](01-proyecto/)

| Archivo | Qué es |
|---|---|
| [`BRIEF-CLAUDE-CODE.md`](01-proyecto/BRIEF-CLAUDE-CODE.md) | Resumen ejecutivo · empezá acá |
| [`01-documento-alcance.md`](01-proyecto/01-documento-alcance.md) | Alcance, objetivos, casos de uso, stakeholders |
| [`02-arquitectura.md`](01-proyecto/02-arquitectura.md) | Stack compartido, capas, seguridad |

## 02 · Especificaciones — [`02-especificaciones/`](02-especificaciones/)

| Archivo | Qué es |
|---|---|
| [`03-ARGUELLO-MOBILE-FEATURES.md`](02-especificaciones/03-ARGUELLO-MOBILE-FEATURES.md) | 6 Features (F1–F6): objetivo, flujo, datos, validaciones |
| [`04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md`](02-especificaciones/04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md) | Puntero → [`/skills/testing.md`](../skills/testing.md) (51 criterios) |
| [`05-ARGUELLO-MOBILE-WIREFRAMES.md`](02-especificaciones/05-ARGUELLO-MOBILE-WIREFRAMES.md) | Wireframes por pantalla |
| [`06-ARGUELLO-MOBILE-FLUJOS-NAVEGACION.md`](02-especificaciones/06-ARGUELLO-MOBILE-FLUJOS-NAVEGACION.md) | Flujos de navegación de usuario |

## 03 · Diseño — [`03-diseno/`](03-diseno/)

| Archivo | Qué es |
|---|---|
| [`README.md`](03-diseno/README.md) | Puntero → [`/skills/design.md`](../skills/design.md) (design system) |

## 04 · Backend — [`04-backend/`](04-backend/)

| Archivo | Qué es |
|---|---|
| [`README.md`](04-backend/README.md) | Puntero → [`/skills/database.md`](../skills/database.md) (modelo de datos validado) |
| [`modelo-de-datos/`](04-backend/modelo-de-datos/) | Material de trabajo del modelado (correcciones, recomendaciones, resúmenes) |

## 05 · Integración — [`05-integracion/`](05-integracion/)

| Archivo | Qué es |
|---|---|
| [`WORKFLOW-VIBE-ENGINEERING-31-08.md`](05-integracion/WORKFLOW-VIBE-ENGINEERING-31-08.md) | Ciclo Vibe Engineering: PLAN → aprobación → código |
| [`ANALISIS-VIBE-ENGINEERING.md`](05-integracion/ANALISIS-VIBE-ENGINEERING.md) | Análisis de la metodología |
| [`VIBE-ENGINEERING-QUICK-START.txt`](05-integracion/VIBE-ENGINEERING-QUICK-START.txt) | Arranque rápido |
| [`REUSABLE-LINGUA-PARA-ARGUELLO.md`](05-integracion/REUSABLE-LINGUA-PARA-ARGUELLO.md) | Qué reutilizar del proyecto Lingua |
| [`UNIFICACION-AGENTS-MOBILE.md`](05-integracion/UNIFICACION-AGENTS-MOBILE.md) | Cómo se unificó AGENTS.md |

## 06 · Operativo — [`06-operativo/`](06-operativo/)

| Archivo | Qué es |
|---|---|
| [`ESTADO-SCAFFOLD.md`](06-operativo/ESTADO-SCAFFOLD.md) | Estado actual del scaffold |
| [`EMULADOR-ANDROID.md`](06-operativo/EMULADOR-ANDROID.md) | Configurar el emulador de Android |
| [`EAS-COMPARTIR.md`](06-operativo/EAS-COMPARTIR.md) | Compartir preview con EAS Update |

## _archivo — [`_archivo/`](_archivo/)

Documentos superados que se conservan por trazabilidad. **No usar como referencia.**

| Archivo | Por qué está archivado |
|---|---|
| [`INDEX-COMPLETO.md`](_archivo/INDEX-COMPLETO.md) | Índice viejo (rutas planas) → reemplazado por este archivo |
| [`RESUMEN-ARGUELLO-MOBILE.md`](_archivo/RESUMEN-ARGUELLO-MOBILE.md) | Resumen previo a la reorganización |
| [`MAPA-ARBOL-PROYECTO.md`](_archivo/MAPA-ARBOL-PROYECTO.md) | Árbol del proyecto (se regenera con cada reorg) |
| [`arbol-plan-original/`](_archivo/arbol-plan-original/) | Plan de estructura original, superado por [`/prompts/00-correccion-estructura-plan.md`](../prompts/00-correccion-estructura-plan.md) |

---

## Cómo navegar

- **Nuevo en el proyecto:** `01-proyecto/BRIEF-CLAUDE-CODE.md` → `01-documento-alcance.md` → `02-arquitectura.md` → `06-operativo/ESTADO-SCAFFOLD.md`
- **Vas a implementar una Feature:** `AGENTS.md` → `skills/design.md` + `skills/testing.md` + `skills/database.md` → `02-especificaciones/03-…-FEATURES.md` → escribí el PLAN en `prompts/` → esperá `✓`
- **Problemas con el emulador / EAS:** `06-operativo/`
