# Argüello Infancias Mobile

Aplicación móvil para el **acompañamiento diario de NNyA** en la residencia bajo protección
judicial. Es el complemento móvil del sistema web "Argüello Infancias": **comparte con él la base
de datos (Supabase), las cuentas y los roles** (`Admin` y `Equipo Tecnico`).

> Trabajo Final / Tesis — Aplicación Móvil mediante Aprendizaje Basado en Proyectos (ABP).

## Estado actual

| Feature | Estado |
|---|---|
| F1 — Consultar residentes | Conectada a Supabase (`nnya`, `nnya_tutores`) |
| F2 — Registrar novedades | Conectada a Supabase (`novedades`) |
| F3 — Consultar historial | Conectada a Supabase (`novedades`, `incidentes`, `actividades`) |
| F4 — Registrar actividades | Conectada a Supabase (`actividades`) |
| F5 — Consultar turno | Parcial: novedades y actividades reales; el **horario del turno y las notas del turno anterior son datos de ejemplo** (`src/data/turno.ts`, `turnos_personal` está vacía) |
| F6 — Situación crítica | Conectada a Supabase (`incidentes`); requiere que el NNyA tenga un legajo activo |

Pendiente: MFA, rate limiting, timeout de sesión, tests automatizados. Detalle en `AGENTS.md`.

## Stack

- **Expo ~57** + React Native 0.86 + TypeScript (strict)
- **Expo Router** (file-based, typed routes)
- **NativeWind 4** (Tailwind CSS 3.4) + tipografía **Poppins**
- **Zustand** (estado de cliente) + **TanStack Query 5** (datos del servidor)
- **Zod 4** (validación) · **expo-secure-store** (sesión) · **AsyncStorage** (cache no sensible)
- **Supabase** (`@supabase/supabase-js`): Auth + PostgreSQL con RLS. **No hay backend propio.**

## Cómo correr

```bash
npm install
cp .env.example .env    # completar EXPO_PUBLIC_SUPABASE_URL y EXPO_PUBLIC_SUPABASE_ANON_KEY
npm start               # Expo; abrir en Expo Go, o w (web) / a (Android) / i (iOS)
```

Se necesita una **cuenta real** con rol `Admin` o `Equipo Tecnico` (no hay usuario de prueba fijo).
Sin las variables de Supabase el login muestra "Falta configurar Supabase". Usar solo la **anon key**,
nunca la `service_role`.

### Verificaciones

```bash
npm run typecheck    # tsc --noEmit
npm run lint         # expo lint
npx expo-doctor      # salud del proyecto
```

## Estructura

```
src/
  app/                 # rutas (Expo Router)
    (auth)/login.tsx
    (tabs)/            # Inicio · Residentes · Mi turno · Crítica · Perfil
    residentes/[id]    # detalle del residente
    nueva-novedad, nueva-actividad, situacion-critica, historial-detalle
  components/          # UI reutilizable
  hooks/               # un hook por operación: useResidents, useObservations, useActivities,
                       # useCriticalIncidents, useShiftInfo, useAuth
  lib/                 # supabase, storage (SecureStore/AsyncStorage), validation (Zod), query-client
  store/               # Zustand: auth, resident, ui
  types/               # modelos de las 6 Features
  data/                # datos de ejemplo que aún quedan (turno, usuarios, novedades)
  utils/               # constants (enums), formatters (fechas, edad)
design-tokens.json     # paleta + tipografía (consumido por tailwind.config.js)
skills/                # design, testing (criterios de aceptación), database (modelo que consume mobile)
docs/                  # documentación de especificación (ver docs/00-INDICE.md)
```

## Documentación

- Reglas y flujo de trabajo: `AGENTS.md` (y `../AGENTS.md` para el contexto general).
- Modelo de datos: `skills/database.md` y las migraciones de `../arguello-infancias/supabase/migrations/`.
- Uso por funcionalidad: `USO-APP-MOBILE-POR-FEATURE.md`.
- Especificaciones históricas (features, wireframes, flujos): `docs/`. Algunas describen el modelo
  anterior a la alineación con la web; ver la nota al inicio de `docs/00-INDICE.md`.

## Compartir con el equipo

EAS Update + build de preview configurados. Ver `docs/06-operativo/EAS-COMPARTIR.md`:
Android por link (APK), iPhone por Expo Go, y `npm run update:preview "<msg>"` para publicar
cambios sin recompilar.
