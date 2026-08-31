# Emulador de Android en la PC

Setup hecho por CLI (opción sin abrir Android Studio). Estado: **listo**.

## Qué quedó instalado

| Componente | Ruta / valor |
|---|---|
| Android SDK | `%LOCALAPPDATA%\Android\Sdk` |
| `cmdline-tools` | `…\Sdk\cmdline-tools\latest` (v12) |
| `platform-tools` (adb) | `…\Sdk\platform-tools` |
| `emulator` | `…\Sdk\emulator` |
| System image | `system-images;android-35;google_apis;x86_64` (Android 15) |
| Plataforma | `platforms;android-35` |
| AVD | **`arguello_pixel7`** (perfil Pixel 7) |
| JDK usado | el que trae Android Studio: `C:\Program Files\Android\Android Studio\jbr` |

## Variables de entorno (ya seteadas en el usuario)

```
ANDROID_HOME       = %LOCALAPPDATA%\Android\Sdk
ANDROID_SDK_ROOT   = %LOCALAPPDATA%\Android\Sdk
PATH  += %LOCALAPPDATA%\Android\Sdk\platform-tools
        %LOCALAPPDATA%\Android\Sdk\emulator
        %LOCALAPPDATA%\Android\Sdk\cmdline-tools\latest\bin
```

> Si abriste una terminal antes de este setup, **cerrala y abrí una nueva** para que
> tome las variables.

## Uso diario

### Arrancar el emulador

```powershell
emulator -avd arguello_pixel7
```

Dejá esa ventana abierta. Para ver los AVD disponibles: `emulator -list-avds`.

### Correr la app en el emulador

Con el emulador ya abierto, en otra terminal dentro de `mobile/`:

```
npx expo start   # y presionás  a
```

Expo instala Expo Go en el emulador y carga la app. Login: `usuario@test.com` / `password123`.

### Correr la APK standalone (el build de EAS) en el emulador

```
adb install ruta\al\arguello.apk
```

o arrastrás el `.apk` sobre la ventana del emulador.

## Problemas comunes

- **`adb` no se reconoce:** terminal abierta antes del setup → abrí una nueva.
- **El emulador no arranca / va lento:** activá la virtualización (VT-x/AMD-V) en la
  BIOS y, en Windows, "Plataforma de máquina virtual" / WHPX en *Características de Windows*.
- **`expo start` dice "no emulators":** arrancá primero `emulator -avd arguello_pixel7`
  y esperá a que cargue el launcher de Android; después presioná `a`.
- **Borrar/recrear el AVD:**
  ```
  avdmanager delete avd -n arguello_pixel7
  avdmanager create avd -n arguello_pixel7 -k "system-images;android-35;google_apis;x86_64" -d pixel_7
  ```

## Alternativa recomendada para el día a día

Tu **teléfono Android físico** con Expo Go sobre la misma Wi-Fi: `npx expo start` y
escaneás el QR. Anda más fluido que el emulador y no consume RAM de la PC.
