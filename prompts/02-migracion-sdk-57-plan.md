# Plan 02 — Migración Expo SDK 54 → SDK 57

**Fecha:** 3 de Septiembre 2026
**Motivo:** Expo Go (App Store / Play Store) ya va por **SDK 57**. El proyecto está en **SDK 54**, así que ni Android ni iPhone pueden abrirlo con Expo Go ("Project is incompatible with this version of Expo Go"). Migrar a 57 arregla los dos y deja el `expo start` + Expo Go como flujo normal para el equipo (Meli/Sofi), sin builds ni cuenta de Apple.

---

## [1] Estado actual (inspección)

| Paquete | Ahora (SDK 54) | Objetivo (SDK 57) |
|---|---|---|
| `expo` | `~54.0.37` | `~57.0.19` |
| `react` / `react-dom` | `19.1.0` | `19.2.3` |
| `react-native` | `0.81.5` | `0.86.3` |
| `react-native-reanimated` | `~4.1.1` | `4.5.1` |
| `react-native-worklets` | `0.5.1` | `0.10.1` |
| `react-native-screens` | `~4.16.0` | `~4.26.0` |
| `react-native-safe-area-context` | `~5.6.0` | `~5.7.0` |
| `react-native-gesture-handler` | `~2.28.0` | `~2.32.0` |
| `react-native-web` | `~0.21.0` | `~0.21.0` (igual) |
| `expo-router` | `~6.0.24` | `~57.0.18` |
| `expo-*` (constants, font, image, secure-store, splash-screen, status-bar, updates, device, linking, web-browser, symbols, system-ui, glass-effect) | `~18/14/3/15/31/3/29/8/8/15/1/6/0.1` | `~57.x` (los alinea `expo install --fix`) |
| `@expo/ui` | `~0.2.0-beta.9` | `~57.0.15` |
| `@expo/vector-icons` | `^15.0.3` | `^15.0.2` (ya OK) |
| `babel-preset-expo` | `~54.0.10` | `~57.0.10` |
| `eslint-config-expo` | `~10.0.0` | `~57.0.2` |
| `@types/react` | `~19.1.10` | `~19.2.0` |
| `typescript` | `~5.9.2` | `~5.9.2` (igual) |
| `nativewind` | `^4.2.6` | `^4.2.6` (última; sin cambio) |
| `tailwindcss` | `^3.4.17` | `^3.4.17` (igual) |
| `zod` `zustand` `@supabase/supabase-js` `@tanstack/react-query` `@react-native-async-storage/async-storage` `@react-navigation/native` | — | sin cambio (JS puro / ya compatibles; `async-storage` ya está en `2.2.0` = el pin de SDK 57) |

- **Node local:** v22.16.0 → cumple el mínimo de RN 0.86 (Node ≥ 20.19.4 / 22.x). OK.
- **Superficie nativa real en `src/`** (grep de imports): solo `expo-font`, `expo-status-bar`, `expo-splash-screen`, `expo-image`, `expo-secure-store`, `react-native-gesture-handler`, `react-native-safe-area-context`, `expo-router`, `@expo/vector-icons`, `@react-native-async-storage/async-storage`. **No hay uso directo de Reanimated, Worklets, expo-file-system, ni `@expo/ui`.** Riesgo de migración bajo: es un scaffold con datos mock.
- `src/app/_layout.tsx` usa `SplashScreen.preventAutoHideAsync()` / `hideAsync()` → API estable en SDK 57, sin cambio.
- Configs: `babel.config.js` (`babel-preset-expo` + `nativewind/babel`), `metro.config.js` (`withNativeWind`), `tailwind.config.js` (preset nativewind), `tsconfig.json` (`expo/tsconfig.base` + paths `@/*`). Ninguna requiere reescritura estructural.

---

## [2] Archivos que se modifican / crean

| Archivo | Cambio |
|---|---|
| `package.json` | Versiones de la tabla [1]. Agregar script `"typecheck": "tsc --noEmit"` (lo pide AGENTS.md §7 y hoy no existe). |
| `package-lock.json` | Regenerado por `npm install`. |
| `app.json` | `expo.version` `"1.0.0"` → `"1.1.0"` (con `runtimeVersion.policy: "appVersion"` esto separa los updates OTA de SDK 57 de los viejos de SDK 54; evita servir un bundle 0.86 a un binario 0.81 o viceversa). `versionCode`/`buildNumber` los maneja EAS (`appVersionSource: remote`). |
| `babel.config.js` | Solo si `expo-doctor` o el arranque lo piden: añadir `'react-native-worklets/plugin'` al final del array de plugins (debe ir **último**). `babel-preset-expo` de SDK 57 suele inyectarlo solo; se confirma en el paso de checks. |
| `.nvmrc` (opcional, nuevo) | `22` — para fijar Node del equipo. Lo dejo fuera salvo que lo pidas. |
| `eas.json` | Sin cambios (perfil `preview` = APK interno sigue sirviendo). |
| `src/**` | **Sin cambios previstos.** Si `tsc`/lint marcan algo tras el bump (p. ej. tipos de RN 0.86 más estrictos en `style`), se corrige puntualmente y se lista en el reporte. |
| `docs/03-mobile/...` o `docs/01-proyecto/RESUMEN-AVANCE-PROYECTO.md` | Nota de una línea: "migrado a SDK 57 el 03/09/2026". |

**No toco:** lógica de features, stores Zustand, data mock, design system (`src/theme/`, componentes `ui/`), contratos de API, modelo de datos.

---

## [3] APIs / comandos que se ejecutan (en orden)

```bash
# 0. Rama de trabajo + respaldo
git checkout -b chore/upgrade-sdk-57
git stash list            # (hay cambios sin commitear del design system; se commitean o stashean antes)

# 1. Subir expo y alinear todo el resto al SDK 57
npx expo install expo@^57.0.0
npx expo install --fix           # alinea react, react-native, expo-*, RN libs conocidas

# 2. Paquetes que expo install no cubre por nombre → fijar a mano si quedaron viejos
npx expo install @types/react eslint-config-expo babel-preset-expo

# 3. Reinstalación limpia
rm -rf node_modules package-lock.json
npm install

# 4. Diagnóstico
npx expo-doctor                  # 0 issues esperado
npx expo install --check         # todas las versiones "up to date"

# 5. Editar app.json (version 1.1.0) y package.json (script typecheck) — manual

# 6. Arranque con caché limpia
npx expo start -c
```

**No se llama ninguna API de red del proyecto** (Supabase/Express) en esta tarea: la app corre con datos mock (`src/data/*`). La BD no se toca, así que los checks de `audit_log` / `SELECT COUNT(*)` de AGENTS.md §7 no aplican a esta migración (no hay cambios de datos ni de esquema).

---

## [4] Cómo se cumplen los criterios

- **Arranca en Expo Go SDK 57 (Android + iPhone):** al terminar, `npx expo start` y escanear el QR desde Expo Go de tienda (sin instalar nada especial). El banner de incompatibilidad desaparece.
- **App para el equipo (Android):** `npm run build:preview` genera APK nuevo con runtime `1.1.0`; el link se comparte igual que antes.
- **iPhone del tesista/jurado:** Expo Go de la App Store + `expo start` en la misma red, o `eas update` sobre un build si más adelante hay cuenta de Apple. Ya no hace falta build ad hoc para "verlo".
- **Sin regresiones visuales:** NativeWind 4.2.6 y `tailwind.config.js` quedan igual; se verifica navegando las 5 tabs + login + detalle de residente.
- **Sin regresiones de tipos:** `npm run typecheck` en verde.

---

## [5] Chequeos posteriores (AGENTS.md §7)

```bash
npm run typecheck          # tsc --noEmit → 0 errores
npm run lint               # expo lint → 0 warnings
npx expo-doctor            # 0 issues
npx expo start -c          # abre, y en Expo Go SDK 57:
  # ✓ Login se renderiza
  # ✓ Navego entre las 5 tabs (inicio, residentes, turno, critica, perfil)
  # ✓ Datos mock se muestran (ResidentCard, ActivityCard, etc.)
  # ✓ Detalle de residente [id] abre
  # ✓ Fuentes Poppins cargan (sin flash de fuente del sistema)
npm run build:preview      # (opcional, si querés APK nuevo ya) → build finished
```

`npx expo build` de AGENTS.md §7 está deprecado; se reemplaza por `expo-doctor` + `build:preview` (EAS), que es lo que ya usa el proyecto.

---

## [6] Riesgos y mitigación

| Riesgo | Prob. | Mitigación |
|---|---|---|
| `babel-preset-expo` 57 no auto-inyecta el plugin de worklets y Reanimated rompe el arranque | Baja | Añadir `'react-native-worklets/plugin'` como último plugin en `babel.config.js`; `expo start -c`. |
| NativeWind 4.2.6 con RN 0.86 tira warnings de Reanimated/CSS interop | Media-baja | 4.2.6 es la última publicada y soporta SDK 57; si aparece, revisar issue tracker de NativeWind y fijar `react-native-worklets` al pin exacto (`0.10.1`). |
| `expo-router` 6→57: cambia el tipado de rutas (`experiments.typedRoutes`) | Baja | Regenera `.expo/types` en el primer `expo start`; corregir imports de `Href` si `tsc` lo marca. |
| Tipos más estrictos de RN 0.86 en props `style` | Baja | Correcciones puntuales, se listan en el reporte. |
| OTA viejo (SDK 54) se sirve al build nuevo | Nula si se hace [2] | Bump `version` → `1.1.0` cambia `runtimeVersion`, aislando canales. |
| `@react-navigation/native` ^7 desalineado | Baja | `expo install --fix` lo ajusta; expo-router 57 trae su propio core de navegación. |

**Rollback:** todo en la rama `chore/upgrade-sdk-57`. Si algo se rompe sin arreglo rápido → `git checkout main` y el APK actual (SDK 54) + Expo Go viejo por APK en Android siguen funcionando.

---

## [7] Reporte final (lo que entrego)

1. Diff de `package.json` / `app.json` / `babel.config.js`.
2. Salida de `expo-doctor`, `typecheck`, `lint`.
3. Pasos exactos para probar en Android y iPhone con Expo Go de tienda.
4. (Si lo pedís) link del APK `preview` nuevo.
5. Nota de avance en `docs/`.

---

**¿Apruebo?** → respondé `✓ Aprobado` o `✕ Cambiar X`.
