# PLAN 05 — Gradientes: hero card de "Turno de hoy" en Inicio

**Fecha:** 2026-09-14
**Autor:** Claude (ingeniero principal)
**Estado:** ⏳ Pendiente de aprobación
**Origen:** `AUDITORIA-UNIDADES-REACT-NATIVE.md`, Unidad II — "Manejo de imágenes y gradientes". Imágenes ya está cubierto (`expo-image`); este plan cierra la parte de gradientes con una funcionalidad real, no decorativa.

---

## 1. Qué construye y por qué acá

La pantalla **Inicio** (`(tabs)/inicio.tsx`) es lo primero que ve un educador al abrir la app — hoy la tarjeta "Turno de hoy" es un cuadro plano (`bg-surface`, borde gris) que no comunica de un vistazo si el turno está **por iniciar / activo / finalizado**.

Propuesta: convertir esa tarjeta en un **hero card con gradiente**, con el color del gradiente cambiando según `data.shift.status` — el gradiente pasa a ser información, no decoración:

| Estado | Gradiente | Lectura |
|---|---|---|
| `activo` | `arguello.blue` → `arguello.purple` (los 2 colores de marca — `skills/design.md` los define como "Argüello theme: azul + púrpura", hoy ningún lugar de la UI los combina) | "estás de turno ahora" — el caso que más importa ver a simple vista |
| `por_iniciar` | `arguello.blue` → `neutral.surface` (gradiente suave, casi plano) | Todavía no arrancó |
| `finalizado` | `neutral.textDisabled` → `neutral.surface` (gris) | Ya cerró |

Texto e información existente (horario, cantidad de NNA/tareas) se mantienen igual — solo cambia el fondo de la tarjeta y el color de los textos para que contrasten.

---

## 2. Alcance

### Dentro
1. Instalar `expo-linear-gradient` (librería oficial de Expo para gradientes — no hay que elegir entre alternativas, es la que documenta Expo para RN).
2. `src/theme/colors.ts`: no hace falta agregar nada — ya expone `arguelloBlue`/`arguelloPurple`/`textDisabled`/`surface`.
3. Componente nuevo `src/components/ui/GradientCard.tsx`: wrapper delgado sobre `LinearGradient` (colores, `start`/`end`, `children`) — reutilizable si en el futuro otra pantalla necesita un gradiente (no atado a la lógica de turno).
4. `(tabs)/inicio.tsx`: reemplazar el `View` de "Turno de hoy" por `GradientCard` con los 3 gradientes de la tabla de arriba según `data.shift.status`; ajustar color de texto (blanco/alto contraste) para que se lea sobre el gradiente.

### Fuera (a propósito)
- ❌ Gradientes en otras pantallas — un solo lugar bien hecho, no gradientes "porque se puede" repartidos por toda la app.
- ❌ Tocar `data.shift`/`useShiftInfo` — sigue siendo mock (F5, issue #14), este plan solo cambia cómo se pinta, no de dónde sale el dato.
- ❌ Corregir el texto "N NNA a cargo" (asume asignación individual, ya descartada por la decisión #2) — es contenido de F5, no de este plan de UI.
- ❌ Overlay de gradiente sobre la foto del residente en el detalle (`[id].tsx`) — quedó evaluado como una mejora posible a futuro, pero agrega alcance sin necesidad real hoy (la mayoría de los NNA todavía no tiene `foto_url` cargada).

---

## 3. Archivos

### Crear
```
src/components/ui/GradientCard.tsx
```

### Modificar
```
package.json                    (+ expo-linear-gradient)
src/app/(tabs)/inicio.tsx        (tarjeta de turno -> GradientCard)
src/components/index.ts          (+ export GradientCard)
```

---

## 4. Diseño

### `GradientCard.tsx`
```tsx
import { LinearGradient } from 'expo-linear-gradient';
import type { ViewProps } from 'react-native';

export type GradientCardProps = ViewProps & {
  colors: [string, string, ...string[]];
};

export function GradientCard({ colors, className, children, ...rest }: GradientCardProps) {
  return (
    <LinearGradient
      colors={colors}
      start={{ x: 0, y: 0 }}
      end={{ x: 1, y: 1 }}
      className={`gap-2 rounded-lg p-4 ${className ?? ''}`}
      {...rest}>
      {children}
    </LinearGradient>
  );
}
```
(`LinearGradient` de `expo-linear-gradient` soporta `className` de NativeWind directo — no hace falta envolverlo en un `View` extra.)

### `inicio.tsx`
```tsx
const SHIFT_GRADIENT: Record<ShiftStatus, [string, string]> = {
  activo: [colors.arguelloBlue, colors.arguelloPurple],
  por_iniciar: [colors.arguelloBlue, colors.surface],
  finalizado: [colors.textDisabled, colors.surface],
};
```
La tarjeta pasa de `<View className="... bg-surface ...">` a `<GradientCard colors={SHIFT_GRADIENT[data.shift.status]}>`, con los `Text` internos en blanco (o `text-ink` cuando el gradiente es claro, caso `por_iniciar`/`finalizado`) para mantener contraste legible (WCAG AA, ya es un requisito documentado en `skills/design.md`).

---

## 5. Validaciones

```bash
npx tsc --noEmit
npm run lint
```
Manual: `npx expo start`, abrir Inicio con los 3 valores posibles de `data.shift.status` (se puede forzar temporalmente en `src/data/turno.ts` para probar los 3 sin esperar el horario real) y confirmar que el texto se lee bien sobre cada gradiente.

---

## 6. Criterios de aceptación

| # | Criterio |
|---|---|
| D-01 | `GradientCard` reutilizable, no atado a la lógica de turno |
| D-02 | Los 3 estados de turno muestran un gradiente distinto y correcto |
| D-03 | Texto legible (contraste suficiente) en los 3 casos |
| D-04 | `npx tsc --noEmit`/`npm run lint` sin errores |
| D-05 | Nada más de la pantalla Inicio cambia de comportamiento |

---

## 7. Tiempo estimado
~30 min.

---

**Aprobación:** _(esperando "✓ Aprobado" o "✕ Cambiar X")_
