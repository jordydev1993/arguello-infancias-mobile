# PLAN 07 — Paginación y scroll infinito en el listado de residentes (F1)

**Fecha:** 2026-09-14
**Autor:** Claude (ingeniero principal)
**Estado:** ⏳ Pendiente de aprobación
**Origen:** `AUDITORIA-UNIDADES-REACT-NATIVE.md`, Unidad IV — "Paginación y scroll infinito".

---

## 1. Dónde y por qué acá

El único listado real (conectado a Supabase, no mock) es `useResidents()` → `(tabs)/residentes.tsx` (F1, ya conectado en el plan 04). Es el candidato correcto: paginar un mock no demuestra nada real contra una base, y F2/F3/F4 todavía son de solo lectura sobre mock.

Con **5 NNA de ejemplo hoy**, nunca se va a "sentir" la paginación en la demo — el plan lo dice explícito para que no sea sorpresa: la corrección técnica se puede verificar leyendo el código y con un page size chico en la verificación manual (§6), no esperando a tener cientos de NNA reales.

---

## 2. Alcance

### Dentro
1. `useResidents()` pasa de `useQuery` a **`useInfiniteQuery`** (TanStack Query) — la misma librería que ya usa todo el proyecto, no una nueva.
2. Paginación por `.range()` de Supabase (offset real contra la base, no "traigo todo y corto en el cliente").
3. `residentes.tsx`: `FlatList` con `onEndReached` + indicador de carga al pie mientras trae la página siguiente.

### Fuera (a propósito)
- ❌ `useResident(id)` (detalle, singular) — no aplica, no es una lista.
- ❌ Paginar las tabs de F2/F3/F4 — mock, fuera de este plan.
- ❌ Paginación "cursor" (keyset por `id`) — con `apellido` como orden y sin miles de filas, offset (`.range()`) alcanza; si el dataset real crece mucho y aparecen problemas de páginas duplicadas/salteadas por inserciones concurrentes, ahí se justifica migrar a cursor — no antes.

---

## 3. Archivos a modificar (ninguno nuevo)

```
src/hooks/useResidents.ts        useResidents(): useQuery -> useInfiniteQuery
src/app/(tabs)/residentes.tsx    FlatList: onEndReached + footer de carga
```

---

## 4. Diseño

### `useResidents.ts`
```ts
const PAGE_SIZE = 20;

export function useResidents() {
  const { user } = useAuth();
  return useInfiniteQuery({
    queryKey: ['residents'],
    enabled: Boolean(user),
    initialPageParam: 0,
    queryFn: async ({ pageParam }) => {
      const from = pageParam * PAGE_SIZE;
      const { data, error } = await getSupabase()
        .from('nnya')
        .select(RESIDENT_FIELDS)
        .eq('estado_actual', 'En residencia')
        .order('apellido')
        .range(from, from + PAGE_SIZE - 1);
      if (error) throw error;
      return (data ?? []).map((n) => ({ ...n, contacto_emergencia: null }) as Resident);
    },
    getNextPageParam: (lastPage, allPages) => (lastPage.length < PAGE_SIZE ? undefined : allPages.length),
  });
}
```
`useResident(id)` (detalle) no cambia.

### `residentes.tsx`
```tsx
const { data, isLoading, isError, refetch, fetchNextPage, hasNextPage, isFetchingNextPage } = useResidents();
const items = data?.pages.flat() ?? [];

<FlatList
  data={items}
  onEndReached={() => { if (hasNextPage) fetchNextPage(); }}
  onEndReachedThreshold={0.4}
  ListFooterComponent={isFetchingNextPage ? <LoadingState message="Cargando más…" /> : null}
  // resto igual
/>
```

---

## 5. Validaciones

```bash
npx tsc --noEmit
npm run lint
```

## 6. Verificación manual

Con 5 NNA en la base no se ve el efecto real. Para verificarlo de verdad:
1. Bajar `PAGE_SIZE` a `2` **temporalmente** en el propio dispositivo/emulador (no commitear ese cambio) y confirmar que:
   - La primera pantalla trae 2 NNA.
   - Al llegar al final de la lista, aparece el indicador de "Cargando más…" y se agregan 2 más.
   - Cuando ya no quedan más, no vuelve a pedir (`hasNextPage` en `false`).
2. Volver `PAGE_SIZE` a `20` antes de subir el cambio.

---

## 7. Criterios de aceptación

| # | Criterio |
|---|---|
| D-01 | `useResidents` pagina contra Supabase con `.range()`, no trae todo de una vez |
| D-02 | `FlatList` pide la página siguiente al acercarse al final (`onEndReached`) |
| D-03 | Se muestra un indicador mientras carga la página siguiente |
| D-04 | Deja de pedir páginas cuando no quedan más (verificado con `PAGE_SIZE` bajo, ver §6) |
| D-05 | `npx tsc --noEmit`/`npm run lint` sin errores |
| D-06 | El detalle de residente (`useResident`) sigue funcionando sin cambios |

---

## 8. Tiempo estimado
~30 min.

---

**Aprobación:** _(esperando "✓ Aprobado" o "✕ Cambiar X")_
