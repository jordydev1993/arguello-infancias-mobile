# Estado del Scaffold — Argüello Infancias Mobile

> Generado el 2026-08-31. Punto de partida: `docs/BRIEF-CLAUDE-CODE.md`.
> Alcance acordado: **solo scaffold** (10 entregables del BRIEF) + **F1 navegable con mock**.
> Estilos: **NativeWind v4 estable**. Template Expo demo: **reemplazado**.
>
> **Actualización 2026-09-03:** migrado a **Expo SDK 57** (RN 0.86, React 19.2) porque
> Expo Go de tienda dejó de abrir proyectos SDK 54. Ver `prompts/02-migracion-sdk-57-plan.md`.
> `app.json` → `version` `1.1.0` (separa los updates OTA de la nueva SDK).

---

## 1. Resumen

El proyecto `mobile/` pasó de ser el template starter de Expo (SDK 54) al **andamiaje de
Argüello Infancias Mobile**. Arranca en `npx expo start`, muestra login → tabs (Inicio · Residentes ·
Mi turno · Crítica · Perfil) y la **Feature F1 (consultar residentes)** funciona de punta a
punta sobre **datos mock**. F2–F6 tienen su lugar en tipos, validación y navegación pero
todavía no están implementadas.

| Feature | Estado |
|---|---|
| F1 — Consultar residentes | ✅ navegable (mock): listado con RBAC + detalle + tabs |
| F2 — Registrar novedades | ⬜ pendiente — tipos + Zod listos; vista de sólo lectura visible |
| F3 — Consultar historial | 🟡 timeline de sólo lectura visible; alta de registros pendiente |
| F4 — Registrar actividades | ⬜ pendiente — tipos + Zod listos; `ActivityCard` y lista visibles |
| F5 — Consultar turno | 🟡 pantalla "Mi turno" con resumen mock (turno, novedades 24 h, tareas) |
| F6 — Situación crítica | 🟡 pantalla de advertencia (WF-13) diferenciada; formulario WF-14/15 pendiente |

---

## 2. Configuración

### Dependencias añadidas

`nativewind`, `tailwindcss`, `zustand`, `zod`, `@tanstack/react-query`,
`@react-native-async-storage/async-storage`, `@supabase/supabase-js`, `expo-secure-store`,
`@expo/vector-icons`, `babel-preset-expo` (dev).

### Archivos de configuración nuevos / modificados

| Archivo | Rol |
|---|---|
| `tailwind.config.js` | Paleta (`arguello`, `critical`, `success`…), escala tipográfica y familias Poppins. Lee `design-tokens.json`. |
| `babel.config.js` | `babel-preset-expo` con `jsxImportSource: 'nativewind'` + `nativewind/babel`. |
| `metro.config.js` | `withNativeWind(config, { input: './src/global.css' })`. |
| `src/global.css` | Directivas `@tailwind` + variables de fuente. |
| `nativewind-env.d.ts` | Tipos de `className`. |
| `design-tokens.json` | Fuente única de la paleta / tipografía (design system §2). |
| `app.json` | `name` "Argüello Infancias Mobile", `scheme` `arguelloinfanciasmobile`, `bundleIdentifier`/`package` `com.arguello.infancias.mobile`, splash azul, `userInterfaceStyle: light`. **Se quitó `experiments.reactCompiler`** (incompatible con `jsxImportSource: nativewind`). |
| `.env.example` | `EXPO_PUBLIC_SUPABASE_URL`, `EXPO_PUBLIC_SUPABASE_ANON_KEY`. |
| `eas.json` | Perfiles `development` / `preview` / `production`. |
| `.gitignore` | Se agregó `.env`. |
| `AGENTS.md` | Apunta a docs de Expo **v54** y describe el contexto Argüello Infancias. |
| `README.md` | Reescrito: qué es, stack, cómo correr, credenciales, estructura, próximos pasos. |

### Decisiones técnicas

- **Expo SDK 57** (RN 0.86, React 19.2). El proyecto nació bajándose a SDK 54; el 2026-09-03
  se volvió a subir a 57 porque Expo Go de App Store / Play Store dejó de abrir SDK 54.
- **NativeWind v4** (Tailwind v3): sigue estable en SDK 57 (4.2.6, sin cambios de config).
- **Zustand sin `zustand/middleware`**: el barrel incluye código `import.meta.env` del middleware
  `devtools` que rompe el bundle web con Metro. Persistencia manual con `src/lib/storage.ts`
  (`AsyncStorage` para cache no sensible, `SecureStore` para tokens a futuro) + `hydrate()` en
  los stores, llamado desde el root layout.
- **Supabase configurado pero sin usar**: `src/lib/supabase.ts` crea el cliente con las env;
  los hooks son queries de React Query que hoy resuelven contra `src/data/`.
- Poppins se carga con `useFonts` en `src/app/_layout.tsx` (claves `Poppins-Regular`…-`Bold`).

---

## 3. Estructura de carpetas

```
src/
  app/
    _layout.tsx            QueryClient + SafeArea + fuentes + <Stack>
    index.tsx              <Redirect> login | inicio según sesión
    (auth)/
      _layout.tsx          redirige a (tabs) si ya hay sesión
      login.tsx            WF-01 — login mock + validación Zod
    (tabs)/
      _layout.tsx          Tabs: Inicio · Residentes · Mi turno · Crítica (rojo) · Perfil
      inicio.tsx           WF-02 — saludo, resumen de turno, accesos, botón crítico
      residentes.tsx       WF-03 — listado F1 (FlatList + EmptyState)
      turno.tsx            WF-11 — resumen del turno (mock)
      critica.tsx          WF-13 — advertencia diferenciada; formulario = F6
      perfil.tsx           datos del usuario + logout
    residentes/[id].tsx    WF-04 — detalle F1 con tabs Info/Novedades/Historial/Actividades
  components/
    ui/                    PrimaryButton, SecondaryButton, CriticalButton, StatusBadge,
                           FormField, ScreenHeader
    ResidentCard.tsx  ActivityCard.tsx  AlertCard.tsx
    common/               LoadingState, EmptyState, ErrorState
    index.ts              barrel
  hooks/
    useAuth.ts            sesión (envuelve authStore)
    useResidents.ts       F1 — listado + detalle con RBAC
    useObservations.ts    F2/F3 — novedades por residente
    useActivities.ts      F4 — actividades por residente
    useShiftInfo.ts       F5 — resumen del turno
  lib/
    supabase.ts           cliente Supabase (stub, no usado)
    validation.ts         schemas Zod: Login, Observation, Activity, CriticalIncident, TaskUpdate
    storage.ts            cache (AsyncStorage) + secure (SecureStore/memoria en web)
    query-client.ts       QueryClient compartido
  store/
    authStore.ts          user, hydrate(), login(mock), logout()
    residentStore.ts      residente seleccionado
    uiStore.ts            preferencia de tema (light)
  types/
    resident · observation · activity · critical · task · shift · user · history · index
  data/
    usuarios.ts           EDUCADOR_MOCK + credenciales demo
    residentes.ts         5 NNA (1 asignado a otro educador → prueba RBAC)
    novedades.ts  actividades.ts  turno.ts
  utils/
    constants.ts          enums + labels (categorías, tipos, estados)
    formatters.ts         edad, fecha/hora es-AR, agrupar por día, iniciales
design-tokens.json
```

### Eliminado del template

`src/app/explore.tsx`, `src/components/{animated-icon*, app-tabs*, external-link, hint-row,
web-badge, themed-text, themed-view, ui/collapsible}`, `src/hooks/use-theme.ts`,
`src/constants/theme.ts`, y assets demo (`expo-logo`, `logo-glow`, `react-logo*`, `tabIcons/`,
`tutorial-web`, `expo-badge*`).

---

## 4. Credenciales de demostración

```
usuario@test.com
password123
```

Usuario: **Lucía Fernández**, rol educador (`src/data/usuarios.ts`).

---

## 5. Verificación realizada

| Check | Resultado |
|---|---|
| `npx tsc --noEmit` | ✅ 0 errores |
| `npx expo lint` | ✅ 0 |
| `npx expo-doctor` | ✅ 18/18 |
| `npx expo install --check` | ✅ sin drift |
| Bundle iOS / Android / Web | ✅ HTTP 200 |
| Prueba manual (web) | ✅ login → inicio → residentes → detalle (Info/Novedades/Historial) → atrás → turno → crítica → perfil, sin errores de consola. Sesión persiste al recargar. RBAC: Valentina Ruiz (otro educador) no aparece en el listado. |

---

## 6. Próximos pasos

1. **F2 — Registrar novedad** (WF-05/06): mutación `useCreateObservation`, formulario con
   `ObservationSchema`, pantalla de confirmación, mensaje de éxito. Criterios CA-08 a CA-17.
2. **Conectar Supabase**:
   - `cp .env.example .env` y completar las variables.
   - En cada `src/hooks/use*.ts`, cambiar el `queryFn` mock por la llamada real.
   - En `src/store/authStore.ts`, cambiar `login` por `auth.signInWithPassword`.
   - Si reaparece el error `import.meta` desde `@supabase/supabase-js` en web, es un issue
     conocido con Metro (transform aparte).
3. Continuar F3 → F6 según el orden de `AGENTS.md` / `docs/03-...FEATURES.md`.
4. Tests para los 51 criterios (`docs/04-...CRITERIOS-ACEPTACION.md`).
