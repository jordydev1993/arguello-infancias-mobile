# Compartir Argüello Infancias Mobile con el equipo (EAS)

## Estado actual (hecho)

- **Proyecto EAS:** `@dev2026js-team/arguello-infancias-mobile`
  - ID: `2c36f903-8f68-43b2-8787-9f3d3da1f3ca`
  - Dashboard: https://expo.dev/accounts/dev2026js-team/projects/arguello-infancias-mobile
- **EAS Update configurado:** `updates.url` en `app.json`, `runtimeVersion` = `appVersion` (1.0.0)
- **Primer update publicado** en la rama/canal `preview` ("scaffold + F1 (datos mock)")
- **Canales** (`eas.json`): `development` / `preview` / `production`; perfil `preview` = **APK** en Android
- `expo-updates` instalado
- **Build Android (APK) listo** — perfil `preview`, canal `preview`:
  - Página para compartir (QR + Install): https://expo.dev/accounts/dev2026js-team/projects/arguello-infancias-mobile/builds/58289357-db9c-462b-b063-414f5bac723a
  - APK directo: https://expo.dev/artifacts/eas/0huNQL2P3EM0WgK6PPKg8ix93r7AGFZ5R9do54iVyQc.apk

---

## Paso 1 — Invitar al equipo a la organización

En https://expo.dev/accounts/dev2026js-team/settings/members → invitar por email.
Cada persona necesita una cuenta gratis de expo.dev. Así ven proyecto, builds y updates.

---

## Paso 2 — Cómo lo abre cada persona

### Android — APK por link (recomendado, sin Expo Go ni cuenta)

1. Abrir en el teléfono la [página del build](https://expo.dev/accounts/dev2026js-team/projects/arguello-infancias-mobile/builds/58289357-db9c-462b-b063-414f5bac723a) (o escanear su QR).
2. **Install** → permitir "instalar apps de orígenes desconocidos" → abrir.
3. Login en la app: `usuario@test.com` / `password123` (datos mock).

Regenerar la APK: `npm run build:preview`.

### iPhone — Expo Go (sin cuenta de Apple Developer)

Apple no permite instalar una `.ipa` desde un link. Con el plan gratuito, el camino
es **Expo Go** (funciona porque el scaffold no tiene código nativo propio):

1. La persona se crea cuenta en expo.dev y vos la invitás a `dev2026js-team` (Paso 1).
2. Instala **Expo Go** del App Store.
3. Inicia sesión en Expo Go con esa cuenta.
4. En la home de Expo Go → sección **Projects** → `arguello-infancias-mobile` → tap.
   Carga el update de la rama `preview`.
5. Login en la app: `usuario@test.com` / `password123`.

Alternativa: desde la página del update en el dashboard hay un QR/link "Preview";
al abrirlo en el iPhone lanza Expo Go en esa versión.

La UI es idéntica a la app instalada; solo corre dentro de Expo Go.

### iPhone — con cuenta de Apple Developer ($99/año)

- **Ad hoc (internal distribution):** registrar cada iPhone una vez y luego compilar
  una `.ipa` instalable por link:
  ```
  npx eas-cli device:create        # cada tester abre el link e instala el perfil
  npm run build:preview:all        # build iOS + Android
  ```
- **TestFlight:** `eas build --platform ios` + `npx eas-cli submit --platform ios`;
  los testers usan la app **TestFlight**. Más prolijo para una defensa formal.

---

## Paso 3 — Publicar cambios sin recompilar (EAS Update)

Cuando el equipo ya tiene la app (APK instalada o Expo Go), cada cambio de JS/UI:

```
npm run update:preview "descripción del cambio"
```

- La APK instalada (canal `preview`) toma el update al reabrir la app.
- Expo Go toma la última versión de la rama `preview` al abrir el proyecto.
- **Solo** hace falta un build nuevo si cambian dependencias nativas o sube `version`.

---

## Scripts (`package.json`)

| Script | Qué hace |
|---|---|
| `npm run update:preview "<msg>"` | publica update JS en la rama/canal `preview` |
| `npm run build:preview` | build APK Android (perfil `preview`) |
| `npm run build:preview:all` | build iOS + Android (perfil `preview`) |

---

## Notas

- **Plan gratuito EAS:** updates prácticamente ilimitados para poco tráfico; builds
  con cola compartida (suficiente para tesis). https://expo.dev/pricing
- **Seguridad:** el bundle publicado es JS con **datos mock** únicamente. `.env` está
  en `.gitignore` y `EXPO_PUBLIC_*` está vacío. Al conectar Supabase usar solo la
  **anon key** (RLS), nunca `service_role`.
- **runtimeVersion `appVersion`:** un update solo llega a builds con la misma `version`
  de `app.json` (hoy `1.0.0`). Si subís la versión → rebuild + nuevo update.
- **Canal ↔ rama:** canal `preview` conectado a la rama `preview`.
- **Credenciales Android:** keystore generado y guardado por EAS en la nube (no hay
  que gestionarlo localmente).
