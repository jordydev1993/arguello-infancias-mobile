# Argüello Infancias Mobile

Aplicación móvil para el **acompañamiento diario de NNA** en residencias bajo protección
judicial. Es el complemento móvil del sistema web institucional "Argüello Infancias" y está pensada
para **educadores y operadores convivenciales** durante el turno.

> Trabajo Final / Tesis — Aplicación Móvil mediante Aprendizaje Basado en Proyectos (ABP).

## Estado actual: scaffold + F1

Este repositorio contiene el **andamiaje del MVP** con la **Feature F1 (consultar residentes)**
navegable sobre **datos mock**. Las Features F2–F6 tienen su lugar en la estructura (tipos,
schemas, navegación) pero todavía no están implementadas.

| Feature | Estado |
|---|---|
| F1 — Consultar residentes | ✅ navegable (mock) |
| F2 — Registrar novedades | ⬜ pendiente (tipos + Zod listos) |
| F3 — Consultar historial | ⬜ pendiente (vista de sólo lectura ya visible) |
| F4 — Registrar actividades | ⬜ pendiente (tipos + Zod listos) |
| F5 — Consultar turno | 🟡 vista de resumen con mock |
| F6 — Situación crítica | 🟡 pantalla de advertencia (WF-13); formulario pendiente |

## Stack

- **Expo SDK 54** + React Native 0.81 + TypeScript (strict)
- **Expo Router** (file-based, typed routes)
- **NativeWind v4** (Tailwind CSS) + tipografía **Poppins**
- **Zustand** (estado global) + **React Query** (data fetching)
- **AsyncStorage** (cache) / **expo-secure-store** (tokens, a futuro)
- **Zod** (validación)
- **Supabase** (`@supabase/supabase-js`) — configurado pero aún **sin usar** (mock data)

## Cómo correr

```bash
npm install
npx expo start
```

Abrí la app en **Expo Go (SDK 54)** escaneando el QR, o presioná `w` (web) / `a` (Android) / `i` (iOS).

### Credenciales de demostración

```
usuario@test.com
password123
```

### Verificaciones

```bash
npx tsc --noEmit     # tipos
npx expo lint        # lint
npx expo-doctor      # salud del proyecto
```

## Estructura

```
src/
  app/                 # rutas (Expo Router)
    (auth)/login.tsx   # WF-01
    (tabs)/            # Inicio · Residentes · Mi turno · Crítica · Perfil
    residentes/[id]    # WF-04 detalle del residente
  components/          # UI reutilizable (botones, cards, estados)
  hooks/               # useResidents, useObservations, useActivities, useShiftInfo, useAuth
  lib/                 # validation (Zod), storage, supabase (stub), query-client
  store/               # Zustand: auth, resident, ui
  types/               # modelos de las 6 Features
  data/                # datos mock (residentes, novedades, actividades, turno, usuarios)
  utils/               # constants (enums), formatters (fechas, edad)
design-tokens.json     # paleta + tipografía (consumido por tailwind.config.js)
docs/                  # documentación prescriptiva (features, criterios, wireframes, flujos)
```

## Conectar Supabase (paso siguiente)

1. `cp .env.example .env` y completá `EXPO_PUBLIC_SUPABASE_URL` / `EXPO_PUBLIC_SUPABASE_ANON_KEY`.
2. En cada `src/hooks/use*.ts`, reemplazá el `queryFn` mock por la llamada real
   (`getSupabase().from(...)` o el endpoint del backend).
3. En `src/store/authStore.ts`, cambiá `login` por `auth.signInWithPassword`.

## Documentación

Ver `docs/`: `03-...FEATURES.md` (6 Features), `04-...CRITERIOS-ACEPTACION.md` (51 CA),
`05-...WIREFRAMES.md` (15 WF), `06-...FLUJOS-NAVEGACION.md`, `DESIGN-SYSTEM-ARGUELLO-MOBILE.md`.
Metodología de desarrollo en `AGENTS.md`.
