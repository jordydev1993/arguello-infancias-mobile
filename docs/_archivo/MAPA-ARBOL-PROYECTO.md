# Mapa / Árbol del Proyecto — Argüello Infancias Mobile

> Snapshot: 2026-08-31, tras la reorganización de estructura (`prompts/00-correccion-estructura-plan.md`).
> Este archivo es un snapshot en `_archivo/`; se regenera con cada reorg. Índice vivo: [`../00-INDICE.md`](../00-INDICE.md).

```
mobile/
├── AGENTS.md                     # Reglas del proyecto (rol, flujo, arquitectura, modelo de datos, APIs)
├── CLAUDE.md                     # Re-exporta AGENTS.md
├── README.md
├── LICENSE
│
├── app.json / eas.json           # Config Expo + perfiles EAS
├── package.json / package-lock.json
├── tsconfig.json · babel.config.js · metro.config.js · eslint.config.js
├── tailwind.config.js · design-tokens.json · nativewind-env.d.ts
├── skills-lock.json · .env.example · .gitignore
│
├── .claude/settings.json · .vscode/
├── .agents/skills/               # Skills de referencia Expo/EAS (upgrade, tailwind, data-fetching, …)
│
├── assets/
│   ├── fonts/                    # Poppins (Regular, Medium, SemiBold, Bold)
│   ├── images/                   # Iconos, splash, mascotas, ilustraciones
│   └── expo.icon/
│
├── scripts/reset-project.js
│
├── skills/                       # ⭐ NUEVO · fuente de verdad única (AGENTS.md §5/§8/§9)
│   ├── README.md
│   ├── design.md                 # Design system (ex docs/DESIGN-SYSTEM-ARGUELLO-MOBILE.md)
│   ├── testing.md                # 51 criterios CA-01…CA-51 (ex docs/04-…-CRITERIOS-ACEPTACION.md)
│   └── database.md               # Modelo de datos validado (ex docs/modelo de datos/VALIDACION-…)
│
├── prompts/                      # ⭐ NUEVO · historial de PLANes (flujo Vibe Engineering)
│   └── 00-correccion-estructura-plan.md
│
├── docs/
│   ├── 00-INDICE.md              # Índice vivo (enlaces verificados)
│   ├── 01-proyecto/
│   │   ├── BRIEF-CLAUDE-CODE.md
│   │   ├── 01-documento-alcance.md
│   │   └── 02-arquitectura.md
│   ├── 02-especificaciones/
│   │   ├── 03-ARGUELLO-MOBILE-FEATURES.md
│   │   ├── 04-ARGUELLO-MOBILE-CRITERIOS-ACEPTACION.md   # puntero → /skills/testing.md
│   │   ├── 05-ARGUELLO-MOBILE-WIREFRAMES.md
│   │   └── 06-ARGUELLO-MOBILE-FLUJOS-NAVEGACION.md
│   ├── 03-diseno/
│   │   └── README.md             # puntero → /skills/design.md
│   ├── 04-backend/
│   │   ├── README.md             # puntero → /skills/database.md
│   │   └── modelo-de-datos/      # material de trabajo del modelado
│   │       ├── 00-INDICE-ARCHIVOS-GENERADOS.md
│   │       ├── CORRECCIONES-MODELO-DATOS-ARGUELLO.md
│   │       ├── RECOMENDACIONES-MODELO-DATOS.md
│   │       └── RESUMEN-SESION-MODELO-DATOS.md
│   ├── 05-integracion/
│   │   ├── WORKFLOW-VIBE-ENGINEERING-31-08.md
│   │   ├── ANALISIS-VIBE-ENGINEERING.md
│   │   ├── VIBE-ENGINEERING-QUICK-START.txt
│   │   ├── REUSABLE-LINGUA-PARA-ARGUELLO.md
│   │   └── UNIFICACION-AGENTS-MOBILE.md
│   ├── 06-operativo/
│   │   ├── ESTADO-SCAFFOLD.md
│   │   ├── EMULADOR-ANDROID.md
│   │   └── EAS-COMPARTIR.md
│   └── _archivo/                 # superado, se conserva por trazabilidad
│       ├── INDEX-COMPLETO.md
│       ├── RESUMEN-ARGUELLO-MOBILE.md
│       ├── MAPA-ARBOL-PROYECTO.md            # (este archivo)
│       └── arbol-plan-original/              # plan de estructura original (superado)
│
└── src/
    ├── global.css
    ├── app/                      # Rutas (Expo Router)
    │   ├── _layout.tsx · index.tsx
    │   ├── (auth)/               # _layout.tsx · login.tsx        · F0 Login
    │   ├── (tabs)/               # _layout.tsx · inicio · residentes · turno · critica · perfil
    │   └── residentes/[id].tsx   # F1/F2/F3/F4 · Ficha de residente + timeline
    ├── components/
    │   ├── index.ts · ResidentCard · ActivityCard · AlertCard
    │   ├── common/               # EmptyState · ErrorState · LoadingState
    │   └── ui/                   # PrimaryButton · SecondaryButton · CriticalButton · FormField · ScreenHeader · StatusBadge
    ├── hooks/                    # useAuth · useResidents · useObservations · useActivities · useShiftInfo · use-color-scheme(.web)
    ├── store/                    # Zustand · authStore · residentStore · uiStore
    ├── lib/                      # supabase · query-client · storage (SecureStore) · validation (zod)
    ├── data/                     # mock/capa de datos · residentes · novedades · actividades · turno · usuarios
    ├── types/                    # index · user · resident · observation · activity · history · shift · task · critical
    └── utils/                    # constants · formatters
```

## Referencia rápida por Feature

| Feature | Descripción | Archivos principales |
|---|---|---|
| F1 | Consultar residentes asignados | `app/(tabs)/residentes.tsx`, `app/residentes/[id].tsx`, `hooks/useResidents.ts`, `components/ResidentCard.tsx` |
| F2 | Registrar novedades | `app/residentes/[id].tsx`, `hooks/useObservations.ts`, `lib/validation.ts` |
| F3 | Historial de seguimiento (timeline) | `app/residentes/[id].tsx`, `hooks/useObservations.ts`, `types/history.ts` |
| F4 | Registrar actividades diarias | `hooks/useActivities.ts`, `components/ActivityCard.tsx`, `types/activity.ts` |
| F5 | Turno y tareas de hoy | `app/(tabs)/inicio.tsx`, `app/(tabs)/turno.tsx`, `hooks/useShiftInfo.ts` |
| F6 | Reportar situación crítica | `app/(tabs)/critica.tsx`, `components/ui/CriticalButton.tsx`, `types/critical.ts` |

## Cambios de esta reorg (2026-08-31)

- **Nuevo:** `skills/` (design.md, testing.md, database.md) + `prompts/` — requeridos por `AGENTS.md`.
- **Borrado:** `arguello-mobile/` (19 carpetas vacías de un script viejo), `src/constants/` (vacía; el real es `src/utils/constants.ts`).
- **`docs/` plano → 6 subcarpetas** temáticas + `_archivo/`. Nombres de archivo sin cambios.
- **Sin duplicados:** design/testing/database viven solo en `skills/`; en `docs/` quedan punteros de 1 línea.
- **`src/` sin tocar** (reorg de componentes/hooks pospuesta a v2).
