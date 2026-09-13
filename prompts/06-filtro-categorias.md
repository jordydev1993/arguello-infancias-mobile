# PLAN 06 — Filtro por categoría en Novedades (detalle de residente)

**Fecha:** 2026-09-14
**Autor:** Claude (ingeniero principal)
**Estado:** ⏳ Pendiente de aprobación
**Origen:** `AUDITORIA-UNIDADES-REACT-NATIVE.md`, Unidad IV — "Filtrado por categorías y separación en componentes reutilizables". La parte de separación en componentes ya está cubierta; este plan cierra el filtrado.

---

## 1. Dónde y por qué acá

La tab **Novedades** del detalle de residente (`residentes/[id].tsx` → `NovedadesTab`) ya lista `Observation[]` con una categoría fija por registro (`ObservationCategory`: `conducta`/`emocional`/`educativo`/`sanitario`/`otro`, `src/utils/constants.ts`). Es el único lugar del código que hoy tiene datos categorizados listos para filtrar — `actividades` tiene su propio `tipo` pero esa tab (`ActividadesTab`) es de menor prioridad para esta demostración porque ya tiene menos contenido en el mock.

No es una pantalla nueva de F2 (eso es la tarjeta #11, construir el alta de novedades) — es agregar el filtro a la vista de sólo lectura que **ya existe**.

---

## 2. Alcance

### Dentro
1. Componente nuevo y reutilizable `src/components/ui/CategoryFilterChips.tsx`: fila de chips (`Pressable` + `StatusBadge`-like), una opción "Todas" + una por categoría, resaltando la seleccionada. Genérico — recibe `options`/`value`/`onChange`, no sabe nada de `Observation`.
2. `NovedadesTab` (dentro de `residentes/[id].tsx`): estado local `categoriaFiltro: ObservationCategory | 'todas'`, filtra `items` antes de renderizar, muestra el `CategoryFilterChips` arriba de la lista.
3. `EmptyState` cuando el filtro no tiene resultados (ya existe el componente, solo cambia el mensaje: "No hay novedades de esta categoría" en vez de "No hay novedades registradas").

### Fuera (a propósito)
- ❌ Filtro en `ActividadesTab` — mismo patrón, pero se deja para cuando se construya F4 real (tarjeta #12), no se duplica el trabajo dos veces.
- ❌ Persistir el filtro elegido (ej. en `uiStore`) — se resetea al volver a entrar a la pantalla, es un filtro de sesión de lectura, no una preferencia.
- ❌ Filtro contra la base real — sigue sobre `useObservations` (mock, F2/F3). El filtro es 100% client-side sobre lo que ya trajo el hook.

---

## 3. Archivos

### Crear
```
src/components/ui/CategoryFilterChips.tsx
```

### Modificar
```
src/app/residentes/[id].tsx      (NovedadesTab: estado + filtro + <CategoryFilterChips>)
src/components/index.ts          (+ export CategoryFilterChips)
```

---

## 4. Diseño

### `CategoryFilterChips.tsx`
```tsx
export type CategoryFilterChipsProps<T extends string> = {
  options: { value: T; label: string }[];
  value: T | 'todas';
  onChange: (value: T | 'todas') => void;
};

export function CategoryFilterChips<T extends string>({ options, value, onChange }: CategoryFilterChipsProps<T>) {
  return (
    <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerClassName="gap-2 pb-1">
      <Chip label="Todas" selected={value === 'todas'} onPress={() => onChange('todas')} />
      {options.map((o) => (
        <Chip key={o.value} label={o.label} selected={value === o.value} onPress={() => onChange(o.value)} />
      ))}
    </ScrollView>
  );
}
```
(`Chip` interno: `Pressable` + `Text`, `bg-arguello-blue`/`text-white` si `selected`, `bg-surface`/`text-ink-secondary` si no — mismo lenguaje visual que `StatusBadge`, sin reusar ese componente porque `StatusBadge` no es presionable.)

### `NovedadesTab`
```tsx
function NovedadesTab({ minorId }: { minorId: string }) {
  const { data, isLoading } = useObservations(minorId);
  const [categoria, setCategoria] = useState<ObservationCategory | 'todas'>('todas');
  if (isLoading) return <LoadingState />;
  const items = (data ?? []).filter((o) => categoria === 'todas' || o.category === categoria);

  return (
    <View className="gap-3">
      <PendingFeatureNote feature="F2" />
      <CategoryFilterChips
        options={OBSERVATION_CATEGORIES.map((c) => ({ value: c, label: OBSERVATION_CATEGORY_LABELS[c] }))}
        value={categoria}
        onChange={setCategoria}
      />
      {items.length === 0 ? (
        <EmptyState
          icon="document-text-outline"
          title={categoria === 'todas' ? 'No hay novedades registradas' : 'No hay novedades de esta categoría'}
        />
      ) : (
        items.map((o) => /* igual que hoy */)
      )}
    </View>
  );
}
```

---

## 5. Validaciones

```bash
npx tsc --noEmit
npm run lint
```
Manual: abrir el detalle de un residente con novedades mock de más de una categoría (ej. `r-1` en `data/novedades.ts`), tocar cada chip y confirmar que la lista se filtra, y que "Todas" la restaura.

---

## 6. Criterios de aceptación

| # | Criterio |
|---|---|
| D-01 | `CategoryFilterChips` es genérico (no conoce `Observation`) y reutilizable |
| D-02 | Tocar una categoría filtra la lista a solo esa categoría |
| D-03 | "Todas" restaura la lista completa |
| D-04 | Estado vacío distingue "sin novedades" de "sin novedades de esta categoría" |
| D-05 | `npx tsc --noEmit`/`npm run lint` sin errores |

---

## 7. Tiempo estimado
~25 min.

---

**Aprobación:** _(esperando "✓ Aprobado" o "✕ Cambiar X")_
