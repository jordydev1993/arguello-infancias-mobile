# PLAN 01 — Consolidar Design System base (tokens TS + SelectField/TextAreaField)

**Fecha:** 2026-09-01
**Autor:** Claude (ingeniero principal)
**Estado:** ✅ Implementado 2026-09-02
**Basado en:** `PLAN-IMPLEMENTACION-DESIGN-SYSTEM.md` (raíz de `assets tesis/`), ajustado tras inspeccionar el código actual — ver §0.

---

## 0. Qué ajusté respecto al documento original

Leí `PLAN-IMPLEMENTACION-DESIGN-SYSTEM.md` e inspeccioné el repo real antes de escribir este plan (`AGENTS.md` §[1] paso 2). Su diagnóstico de fondo es correcto (falta `src/theme/*.ts`, falta `SelectField`/`TextAreaField`), pero tres cosas quedaron desactualizadas o son over-engineering para el alcance actual:

1. **Referencia rota:** cita `docs/DESIGN-SYSTEM-ARGUELLO-MOBILE.md` — ese archivo ya no existe con ese nombre; el Plan 00 (31/08) lo movió a `skills/design.md`. Uso ese como fuente canónica.
2. **`src/components/states/` — lo descarto.** El doc pide crear esa carpeta y mover `EmptyState`/`ErrorState`/`LoadingState` desde `common/` con re-exports de compatibilidad. Ya están en `common/`, ya funcionan, ya están exportados en el barrel, y **ya tienen** las props genéricas que el doc pedía agregar (`title`, `description`, `actionLabel`, `onAction` en `EmptyState`; `onRetry` en `ErrorState`; `message` en `LoadingState`). Mover carpetas solo para que el nombre coincida con una propuesta externa no aporta nada funcional y contradice la regla que el propio Plan 00 ya fijó: "minimizar cambios arquitectónicos".
3. **`npm run typecheck` no existe** en `package.json` (los scripts reales son `start`, `android`, `ios`, `web`, `lint`, `build/update:preview`). Uso `npx tsc --noEmit` directo en las validaciones.

Storybook queda descartado, como ya recomendaba el propio documento (no bloqueante para el MVP).

Con estos ajustes, el trabajo real son **2 tareas**, no las 6 del documento original (las otras 4 ya están resueltas o se descartan).

---

## 1. Por qué este plan

1. **Tokens sin capa TS.** `design-tokens.json` + `tailwind.config.js` cubren `className` (View/Text), pero **no** el prop `color` de `Ionicons`/`ActivityIndicator`, que necesita un string hex. Hoy esos hex están sueltos y hardcodeados en 4 componentes:
   - `EmptyState.tsx` → `color="#9CA3AF"`
   - `ErrorState.tsx` → `color="#DC3545"`
   - `LoadingState.tsx` → `color="#007AFF"`
   - `FormField.tsx` → `color="#6B7280"` (icono mostrar/ocultar contraseña) y `placeholderTextColor="#9CA3AF"`

   Verifiqué que los 4 valores coinciden hoy con `design-tokens.json` (`textDisabled`, `error`, `arguello.blue`, `textSecondary`) — no hay ninguna divergencia que arreglar, pero si mañana cambia un color en el token, estos 4 quedan desincronizados sin que nada avise. Eso es lo que corrige `src/theme/`.

2. **`SelectField` y `TextAreaField` no existen.** F2 (novedades: `tipo_novedad` es un select de 6 valores fijos, `descripcion` es texto libre largo) y F4 (actividades: `tipo_actividad` select, `descripcion` textarea) los van a necesitar. Construirlos ahora, sobre el patrón ya validado de `FormField`, evita que F2/F4 tengan que inventar su propio input a mitad de esa implementación.

---

## 2. Alcance

### Dentro
1. `src/theme/colors.ts`, `typography.ts`, `spacing.ts`, `index.ts` — wrapper TS de `design-tokens.json` (reexporta, no duplica valores).
2. Reemplazar los 4 hex hardcodeados de §1.1 por referencias a `src/theme/colors.ts`.
3. `src/components/ui/SelectField.tsx` — mismas props base que `FormField` (`label`, `error`, `required`, `disabled`) + `options: {label, value}[]`, `value`, `onChange`.
4. `src/components/ui/TextAreaField.tsx` — mismas props base + `numberOfLines`/`maxLength` opcionales, sin `secure`.
5. Exportar ambos en `src/components/index.ts`.

### Fuera (de este plan)
- ❌ `src/components/states/` — ver §0.2.
- ❌ Storybook.
- ❌ Conectar `SelectField`/`TextAreaField` en pantallas reales de F2/F4 — esas features todavía no están planificadas ni aprobadas; este plan entrega solo los componentes de UI base.
- ❌ Tocar `PrimaryButton`, `SecondaryButton`, `CriticalButton`, `ScreenHeader`, `StatusBadge` — ya usan `className` de Tailwind, no tienen hex sueltos, no hace falta tocarlos.
- ❌ Agregar el script `typecheck` a `package.json` — lo dejo como nota, no como tarea de este plan.

---

## 3. Archivos

### Crear
```
src/theme/colors.ts
src/theme/typography.ts
src/theme/spacing.ts
src/theme/index.ts
src/components/ui/SelectField.tsx
src/components/ui/TextAreaField.tsx
```

### Modificar
```
src/components/common/EmptyState.tsx     (hex → theme)
src/components/common/ErrorState.tsx     (hex → theme)
src/components/common/LoadingState.tsx   (hex → theme)
src/components/ui/FormField.tsx          (hex → theme)
src/components/index.ts                  (+2 exports)
```

---

## 4. Diseño de cada pieza

### 4.1 `src/theme/*`
- `colors.ts`: importa `design-tokens.json` y reexporta su objeto `color` con nombres planos en camelCase (`arguelloBlue`, `textSecondary`, `error`, etc.) — mismos valores que ya consume `tailwind.config.js`, una sola fuente real (`design-tokens.json`).
- `typography.ts`: reexporta `tokens.font` unificado con los `lineHeight` ya definidos en `tailwind.config.js` (no se reinventan valores nuevos).
- `spacing.ts`: reexporta `tokens.spacing`.
- `index.ts`: re-exporta los tres.

### 4.2 `SelectField`
Mismo contenedor visual que `FormField` (mismo borde/radius/colores). Al tocarlo abre un modal simple con la lista de `options`. Sin dependencias nuevas: el proyecto no tiene picker nativo instalado y no hace falta uno para listas fijas de 3-6 valores (los `CHECK` del modelo de datos).

### 4.3 `TextAreaField`
Mismo contenedor que `FormField`, `TextInput multiline`, sin el toggle de `secure`. Mismo look que `SelectField`/`FormField` para que F2/F4 se vean consistentes entre sí.

---

## 5. Validaciones
```bash
npx tsc --noEmit     # sin errores
npm run lint          # sin warnings nuevos
npx expo start        # abre; revisar login (usa FormField) y residentes (usa EmptyState)
```

---

## 6. Criterios de aceptación

| # | Criterio |
|---|---|
| D-01 | `src/theme/{colors,typography,spacing,index}.ts` existen y no duplican valores de `design-tokens.json` |
| D-02 | Cero hex hardcodeado nuevo en los 4 componentes tocados — todos importan de `src/theme` |
| D-03 | `SelectField` y `TextAreaField` compilan, props tipadas, calzan visualmente con `FormField` |
| D-04 | `src/components/index.ts` exporta los 2 componentes nuevos |
| D-05 | `npx tsc --noEmit` sin errores |
| D-06 | La app abre y navega igual que antes — `src/app/` no cambia en este plan |

---

## 7. Tiempo estimado
~1h30 (theme: 20 min · refactor de los 4 componentes: 20 min · SelectField: 25 min · TextAreaField: 15 min · validación: 10 min).

---

## 8. Decisiones que necesito antes de implementar

Ninguna bloqueante de negocio — es solo UI base, sin ambigüedad funcional. Si estás de acuerdo con lo que se descarta en §0/§2, respondé "✓ Aprobado" e implemento.

---

**Aprobación:** ✓ Aprobado (2026-09-02)

## 9. Resultado

Implementado tal como diseñado en §2-4. Validaciones corridas:
- `npx tsc --noEmit` → sin errores.
- `npm run lint` → sin errores.
- `npx expo start` (D-06, revisión visual de login/residentes) → pendiente de verificación manual del usuario; no se ejecutó un servidor Expo de larga duración en esta sesión.

Criterios de aceptación: D-01 a D-05 verificados. D-06 pendiente de confirmación manual (ver arriba).
