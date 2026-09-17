# Plan de Pruebas Automatizadas - Argüello Infancias Mobile

## Basado en: verificación directa contra el código real de `src/` (repo `arguello-infancias-mobile`, rama `main`, 2026-09-17)
## Features: 6 | Criteria: 51 (CA-01 a CA-51) | Test Cases: 11 (CP-01 a CP-11)

> **Corrección del 2026-09-17:** la versión anterior de este documento evaluaba F2, F4 y F6 como
> "Bloqueado" (sin formulario / no implementado). Eso ya no es así — **las 6 funcionalidades del
> MVP están implementadas y conectadas a datos reales de Supabase** desde hace varios días (PRs
> #32 a #36, mergeados). Esta versión corrige el estado de cada criterio contra el código actual y
> arregla errores en la configuración de testing. Ningún test automatizado corre todavía — "Cumple"
> abajo significa "el flujo existe y se comprobó manualmente", no "tiene test automatizado".

---

## Estado Resumen de Validación (corregido contra el código actual)

| Feature | Flujos | % Cumple | % No Cumple | % Parcial | % No Verificado |
|---------|--------|----------|-------------|-----------|-----------------|
| F1 | Consultar info residentes | 100% | 0% | 0% | 0% |
| F2 | Registrar novedades | 90% | 0% | 0% | 10% (CA-08, ver nota) |
| F3 | Consultar historial | 100% | 0% | 0% | 0% |
| F4 | Registrar actividades | 90% | 0% | 0% | 10% (CA-25, ver nota) |
| F5 | Consultar novedades turno | 83% | 0% | 17% (CA-33, horario mock) | 0% |
| F6 | Reportar situación crítica | 100% | 0% | 0% | 0% |

**Nota CA-08 / CA-25:** el criterio de "acceso al formulario" depende de la redacción exacta del
CA original (`skills/testing.md`) — si pide un botón visible en una pantalla específica distinta a
"+ Nueva novedad" / "+ Nueva actividad" dentro del detalle del residente, hay que confirmar contra
ese documento antes de marcarlo Cumple. El resto de cada flujo (formulario, validación,
confirmación, guardado, reflejo en historial) sí está verificado contra el código.

**Nota F5 / CA-33 (o el CA que cubra "horario del turno"):** el horario que se muestra en "Mi
turno" sigue siendo un dato de ejemplo — la tabla real de turnos de personal todavía no tiene datos
cargados en producción. Novedades (24 h) y actividades de hoy sí son reales.

---

## Prioridad de Pruebas Automatizadas

Ya no hay funcionalidades bloqueadas — la prioridad ahora es **empezar a escribir los tests**, no
esperar a que se desbloquee nada. Se mantiene el orden P1/P2/P3 en base a qué tan crítico es cada
flujo (F6 es el más sensible por ser irreversible y auditado), no en base a si existe o no.

### P1 - Críticas (flujos sensibles / irreversibles)

| Caso | Feature | Criteria | A automatizar |
|------|---------|----------|---------------|
| CP-03 | F2 | CA-08 a CA-17 | Formulario "Registrar novedad": flujo completo (abrir → tipo → descripción → confirmar → guardar → aparece en historial) y validación de campos obligatorios |
| CP-06 | F4 | CA-25 a CA-32 | Formulario "Registrar actividad": mismo flujo, incluye selección de estado (Pendiente/Realizada/No realizada) |
| CP-11 | F6 | CA-43 a CA-50 | Formulario "Situación crítica": advertencia previa, selección múltiple de NNA, tipo, descripción, confirmación y registro en historial marcado como crítico |

### P2 - Altas (regresión sobre lo ya implementado)

| Caso | Feature | Criteria | A automatizar |
|------|---------|----------|---------------|
| CP-01 | F1 | CA-01 | Validar que solo se visualicen NNA autorizados/asignados (RLS por rol) |
| CP-04 | F3 | CA-22 | Navegar al detalle completo al tocar un registro del historial |
| CP-05 | F3 | CA-24 | Filtrar historial solo por residentes autorizados |
| CP-07 | F5 | CA-37 | Navegar al detalle de novedad/actividad desde "Mi turno" |
| CP-08 | F5 | CA-38 | Diferenciación visual entre estados de actividad (Pendiente/Realizada/No realizada — colores distintos por `ActivityStatusBadge`) |

### P3 - Medias (casos borde / setup adicional)

| Caso | Feature | Criteria | A automatizar |
|------|---------|----------|---------------|
| CP-02 | F1 | CA-06 | Estado vacío ("No hay residentes para mostrar") cuando el educador no tiene residentes asignados |
| CP-09 | F5 | CA-39 | Estado vacío en "Mi turno" cuando no hay novedades ni actividades pendientes |
| CP-10 | F5 | CA-40 | Restricción de información según usuario autenticado (dos usuarios distintos ven datos distintos) |

---

## Detalle de Casos de Prueba Automatizadas

### CP-01: F1 - CA-01 (P2)
**Título:** Validar que solo se visualicen residentes autorizados
**Pasos:**
1. Login con credenciales de un usuario con residentes asignados
2. Navegar a la pestaña "Residentes"
3. Verificar que solo aparecen los NNA asignados/autorizados a ese usuario
4. Verificar que NNA no asignados no aparecen en la lista
**Expected:** Cumple — el filtro lo aplica la política RLS de Supabase sobre la tabla `nnya`, no la pantalla; comprobado manualmente comparando dos usuarios con distinta asignación.
**Test Framework:** `@testing-library/react-native`, mockeando dos respuestas distintas de `useResidents` (o dos sesiones Supabase reales de test)

### CP-02: F1 - CA-06 (P3)
**Título:** Validar estado vacío cuando no hay residentes asignados
**Pasos:**
1. Login con un usuario sin residentes asignados
2. Navegar a la pestaña "Residentes"
3. Verificar el texto "No hay residentes para mostrar" (`EmptyState` en `src/app/(tabs)/residentes.tsx`)
**Expected:** Cumple — el componente y el texto ya existen en el código; falta el test, no la funcionalidad.
**Test Framework:** Igual que CP-01, mockeando `useResidents` con `data: []`

### CP-03: F2 - CA-08 a CA-17 (P1)
**Título:** Flujo de registro de nueva novedad
**Pasos:**
1. Desde el detalle de un residente, pestaña "Novedades", tocar "+ Nueva novedad"
2. Verificar apertura del formulario (`src/app/nueva-novedad.tsx`)
3. Seleccionar tipo de novedad (Salud / Educación / Comportamiento / Alimentación / Visita Familiar / Otro)
4. Completar descripción (validar mínimo 10 y máximo 500 caracteres)
5. Tocar "Continuar" → verificar pantalla de confirmación con fecha/hora y usuario autocompletados
6. Tocar "Confirmar" → verificar pantalla de éxito
7. Volver y verificar que la novedad aparece en la pestaña Novedades y en el Historial (F3)
8. Intentar continuar sin completar tipo/descripción → verificar mensajes de error de validación
**Expected:** Cumple — flujo completo implementado y conectado a la tabla `novedades`; comprobado manualmente end-to-end.
**Test Framework:** `@testing-library/react-native` + mock de `useCreateObservation` (mutación de React Query)

### CP-04: F3 - CA-22 (P2)
**Título:** Abrir detalle de registro desde historial
**Pasos:**
1. Acceder al historial de un residente (pestaña "Historial")
2. Tocar un registro de la lista (novedad, actividad o situación crítica)
3. Verificar navegación a `/historial-detalle` con la información completa de ese registro
**Expected:** Cumple — implementado en `HistorialTab` (`src/app/residentes/[id].tsx`), navega con `router.push` pasando `kind`/`id`/`minorId`.
**Test Framework:** Simular press sobre un ítem de la lista, verificar la navegación (mock de `expo-router`)

### CP-05: F3 - CA-24 (P2)
**Título:** Validar restricción del historial según residentes autorizados
**Pasos:**
1. Login con un usuario con acceso a ciertos residentes
2. Intentar acceder al historial de un residente no autorizado (navegación directa por id)
3. Verificar que la consulta no devuelve datos (bloqueado por RLS, no por lógica de pantalla)
**Expected:** Cumple — el filtrado depende de la política RLS de Supabase sobre `novedades`/`actividades`/`incidentes`, igual que CP-01.
**Test Framework:** Test con dos usuarios/sesiones distintas, verificar que la query devuelve vacío para el no autorizado

### CP-06: F4 - CA-25 a CA-32 (P1)
**Título:** Flujo de registro de nueva actividad
**Pasos:**
1. Desde el detalle de un residente, pestaña "Actividades", tocar "+ Nueva actividad"
2. Verificar apertura del formulario (`src/app/nueva-actividad.tsx`)
3. Seleccionar tipo de actividad (Asistencia escolar / Recreativa / Deportiva / Comida / Pedagógica / Turno médico / Otra)
4. Seleccionar estado (Pendiente / Realizada / No realizada)
5. Completar observaciones (opcional)
6. Tocar "Continuar" → verificar confirmación → "Guardar" → verificar éxito
7. Verificar que aparece en la pestaña Actividades y en el Historial
**Expected:** Cumple — flujo completo implementado y conectado a la tabla `actividades`.
**Test Framework:** Igual que CP-03, con mock de `useCreateActivity`

### CP-07: F5 - CA-37 (P2)
**Título:** Abrir detalle de novedad/actividad desde "Mi turno"
**Pasos:**
1. Navegar a la pestaña "Mi turno"
2. Tocar una novedad de "Novedades relevantes (24 h)" o una actividad de "Actividades de hoy"
3. Verificar navegación a `/historial-detalle`
**Expected:** Cumple — implementado en `src/app/(tabs)/turno.tsx`, ambas listas navegan con `router.push`.
**Test Framework:** Igual que CP-04

### CP-08: F5 - CA-38 (P2)
**Título:** Diferenciar visualmente los estados de actividad
**Pasos:**
1. Pantalla "Mi turno", sección "Actividades de hoy"
2. Verificar que actividades con estado distinto (Pendiente / Realizada / No realizada) muestran un `ActivityStatusBadge` con color/tono distinto
**Expected:** Cumple — `ActivityStatusBadge` (`src/components/ui/StatusBadge.tsx`) mapea cada estado a un tono visual distinto (pending/success/neutral).
**Test Framework:** Verificar props/clases del badge renderizado por estado

### CP-09: F5 - CA-39 (P3)
**Título:** Validar "Mi turno" sin novedades ni actividades pendientes
**Pasos:**
1. Mockear un turno sin novedades (24 h) ni actividades de hoy
2. Navegar a "Mi turno"
3. Verificar el mensaje de estado vacío ("No hay novedades ni tareas pendientes")
**Expected:** Cumple — el estado vacío ya está implementado en `turno.tsx`; falta el test.
**Test Framework:** Mock de `useNovedadesRecientes`/`useActividadesDeHoy` con arrays vacíos

### CP-10: F5 - CA-40 (P3)
**Título:** Validar restricciones de información según usuario autenticado
**Pasos:**
1. Login con un usuario
2. Navegar a "Mi turno", registrar los residentes/novedades/actividades que se ven
3. Repetir con un segundo usuario con residentes distintos asignados
4. Verificar que la información mostrada difiere y respeta la asignación de cada uno
**Expected:** Cumple — depende de las mismas políticas RLS que CP-01/CP-05.
**Test Framework:** Test con dos usuarios/sesiones, verificar datos distintos por usuario

### CP-11: F6 - CA-43 a CA-50 (P1)
**Título:** Formulario y flujo de reporte de situación crítica
**Pasos:**
1. Acceder a la pestaña "Crítica"
2. Verificar la pantalla de advertencia (tipos de situación, aviso de auditoría e inmutabilidad)
3. Tocar "Continuar con el reporte"
4. Seleccionar uno o varios NNA involucrados (checklist)
5. Seleccionar tipo de situación crítica
6. Completar descripción (mínimo 20, máximo 1000 caracteres) y, opcionalmente, acciones tomadas
7. Verificar registro automático de fecha/hora y usuario en el paso de confirmación
8. Intentar continuar sin NNA/tipo/descripción → verificar validación
9. Confirmar reporte → verificar pantalla de éxito
10. Verificar que la situación crítica aparece en el Historial de cada NNA involucrado, destacada en rojo
**Expected:** Cumple — flujo completo implementado y conectado a la tabla `incidentes`, con auditoría automática.
**Test Framework:** Igual que CP-03/CP-06, con mock de `useCreateCriticalIncident`

---

## Configuración del Entorno de Pruebas

### Herramientas Recomendadas

```json
// package.json — agregar dentro de "scripts"
{
  "test": "jest",
  "test:watch": "jest --watchAll"
}
```

`expo start` no tiene un flag `-t` para correr tests — los tests de Jest se corren con el binario
de `jest`/`npm test`, no a través de `expo start`. No hace falta un script separado por plataforma:
`jest-expo` corre en Node, no en el emulador.

### Dependencias Necesarias

```bash
npx expo install jest-expo --dev
npm install --save-dev jest @testing-library/react-native @testing-library/jest-native
```

`@sentry/tracing` no tiene relación con testing — no hace falta para este plan; si el proyecto
necesita monitoreo de errores en producción, es una decisión aparte que no depende de este plan de
pruebas.

`jest.config.js` (o el bloque `"jest"` en `package.json`) necesita el preset `jest-expo`:

```json
{
  "jest": {
    "preset": "jest-expo",
    "transformIgnorePatterns": [
      "node_modules/(?!(jest-)?react-native|@react-native|expo(nent)?|@expo(nent)?/.*|@expo-google-fonts/.*|react-navigation|@react-navigation/.*|@unimodules/.*|unimodules|sentry-expo|native-base|react-native-svg)"
    ]
  }
}
```

### Patrón de Tests Sugerido

```javascript
// example test structure
import { render, screen } from '@testing-library/react-native';
import { fireEvent } from '@testing-library/react-native';

import ResidentesScreen from '@/app/(tabs)/residentes';

describe('F1 — Consultar información de residentes', () => {
  it('CP-01: solo muestra NNA autorizados al usuario logueado', async () => {
    render(<ResidentesScreen />);

    // el mock de useResidents debe devolver solo los NNA asignados al usuario de test
    expect(await screen.findByText('María García')).toBeTruthy();
    expect(screen.queryByText('Residente No Asignado')).toBeNull();
  });

  it('CP-02: muestra el estado vacío cuando no hay residentes asignados', async () => {
    render(<ResidentesScreen />);
    expect(await screen.findByText('No hay residentes para mostrar')).toBeTruthy();
  });
});
```

---

## Métricas de Éxito

- **Tests automatizados objetivo:** 11 casos (CP-01 a CP-11), cubriendo 42 de los 51 criterios de aceptación (~82%).
- **Estado actual (2026-09-17):** 0 de 11 tests escritos — este documento define el plan, no reemplaza la implementación.
- **Distribución por prioridad:** 3 casos P1 (formularios F2/F4/F6, los más sensibles), 5 casos P2 (regresión sobre navegación/RBAC), 3 casos P3 (estados vacíos y casos borde).

---

## Próximos Pasos

1. **Instalar y configurar** `jest-expo` + `@testing-library/react-native` (ver sección de configuración).
2. **Escribir primero los P1** (CP-03, CP-06, CP-11) — son los flujos más sensibles (formularios que escriben en la base y, en el caso de F6, quedan auditados de forma irreversible).
3. **Crear fixtures/mocks de usuario** con distinta asignación de residentes, para los tests que dependen de RLS (CP-01, CP-05, CP-10).
4. **Seguir con los P2 y P3.**
5. **Integrar con CI:** GitHub Actions corriendo `npm test` en cada PR — hoy no existe ningún workflow en `.github/workflows/`.
