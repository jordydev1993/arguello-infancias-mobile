# Uso de la app — Argüello Infancias Mobile (detallado por funcionalidad)

**Fecha:** 16 de septiembre de 2026
**Repo:** `arguello-infancias-mobile`
**Objetivo de este documento:** guía paso a paso de cómo se usa cada una de las 6 funcionalidades
del MVP, para exponer/demostrar la app (todas conectadas a datos reales de Supabase).

---

## 0. Acceso

1. Abrir la app (Expo Go o build) → pantalla **Login**.
2. Ingresar **correo** y **contraseña** de una cuenta real provista por el equipo (no hay usuario
   de prueba fijo — la autenticación es real contra Supabase).
3. Al ingresar, la sesión queda persistida en el dispositivo (`expo-secure-store`) hasta cerrar
   sesión desde **Perfil**.
4. El acceso a residentes está limitado por rol: un educador solo ve los NNA que tiene asignados;
   un rol con más permisos (Admin / Equipo Técnico) ve todo. Este control lo aplica la base de
   datos (RLS), no la pantalla.

**Navegación principal (tabs):** Inicio · Residentes · Mi turno · Crítica · Perfil.

---

## 1. F1 — Consultar residentes asignados

**Dónde:** tab **Residentes**.

1. Al entrar se lista cada NNA asignado (nombre, foto/inicial, edad) en tarjetas (`ResidentCard`).
2. Tocar una tarjeta abre el **detalle del residente**, con 4 pestañas: **Info · Novedades ·
   Historial · Actividades**.
3. La pestaña **Info** muestra: nombre completo, fecha de nacimiento, edad calculada, obra
   social, contacto de emergencia (nombre, parentesco, teléfono si existe) y alertas importantes
   (ej. alergias) si las tiene cargadas.

Las otras 3 pestañas del detalle son la puerta de entrada a F2, F3 y F4 — se explican abajo.

---

## 2. F2 — Registrar novedad

**Dónde:** detalle de un residente → pestaña **Novedades** → botón **"+ Nueva novedad"**.

Flujo de 3 pasos (formulario → confirmación → éxito):

1. **Formulario:**
   - Tipo de novedad (obligatorio, uno de: *Salud, Educación, Comportamiento, Alimentación,
     Visita Familiar, Otro*).
   - Descripción (obligatoria, 10 a 500 caracteres).
   - Botón **Continuar** (o **Cancelar** para volver atrás sin guardar).
2. **Confirmación:** se muestra un resumen de lo cargado — NNA, tipo, descripción, fecha/hora
   (la del momento, automática) y usuario (el de la sesión actual, automático). Opciones:
   **Confirmar** o **Volver a editar**.
3. **Éxito:** pantalla de confirmación ("Novedad registrada") con botón **Volver**, que regresa
   al detalle del residente — la novedad ya aparece en la pestaña Novedades y en el Historial (F3).

---

## 3. F3 — Consultar historial de seguimiento

**Dónde:** detalle de un residente → pestaña **Historial**.

1. Se muestra una **línea de tiempo unificada**, agrupada por día, que combina en un solo lugar:
   novedades (F2), actividades (F4) y situaciones críticas (F6) de ese NNA, ordenadas de más
   reciente a más antigua.
2. Cada entrada muestra: ícono y tipo de registro, tipo específico (ej. "Novedad · Salud"),
   resumen del contenido, hora y usuario responsable.
3. Las entradas de **situación crítica** se destacan visualmente con borde y fondo rojo, para que
   no se confundan con el resto del historial.
4. Tocar cualquier entrada abre su **detalle completo de solo lectura** (fecha y hora exacta,
   descripción completa, usuario responsable y, si es una situación crítica, las acciones tomadas).

---

## 4. F4 — Registrar actividad diaria

**Dónde:** detalle de un residente → pestaña **Actividades** → botón **"+ Nueva actividad"**.

Mismo patrón de 3 pasos que F2:

1. **Formulario:**
   - Actividad (obligatorio, una de: *Asistencia escolar, Actividad recreativa, Actividad
     deportiva, Comida, Actividad pedagógica, Turno médico, Otra*).
   - Estado (obligatorio: *Pendiente, Realizada, No realizada*).
   - Observaciones (opcional).
2. **Confirmación:** resumen con NNA, actividad, estado, observaciones (si se cargaron),
   fecha/hora y usuario — igual que en F2.
3. **Éxito:** "Actividad registrada" → Volver. La actividad queda visible en la pestaña
   Actividades del residente y en su Historial (F3).

---

## 5. F5 — Consultar turno y tareas de hoy

**Dónde:** tab **Mi turno** (y un resumen reducido en **Inicio**).

1. Encabezado con el horario del turno del educador logueado y su estado (*Por iniciar / Activo /
   Finalizado*), y la cantidad de NNA a cargo.
   > El horario en sí es un dato de ejemplo: la tabla de turnos de personal todavía no tiene datos
   > cargados en producción — el resto de la pantalla sí es información real.
2. **Novedades relevantes (24 h):** todas las novedades registradas en las últimas 24 horas para
   los residentes del educador, sin importar quién las cargó. Tocar una abre su detalle (mismo
   detalle de solo lectura que en F3).
3. **Actividades de hoy:** todas las actividades del día, con su estado (badge Pendiente/
   Realizada/No realizada). Tocar una abre su detalle.
4. Si no hay novedades ni actividades pendientes, se muestra un estado vacío ("Todo al día en
   este turno").
5. La pantalla **Inicio** repite el resumen del turno y agrega accesos rápidos a Residentes, Mi
   turno, y un acceso directo para reportar una situación crítica.

---

## 6. F6 — Reportar situación crítica

**Dónde:** tab **Crítica** (pantalla con fondo rojo, diferenciada a propósito del resto de la
app), o el botón rojo "Reportar situación crítica" en Inicio.

1. **Pantalla de advertencia:** explica que esta función es solo para emergencias reales
   (violencia, crisis emocional, accidente, fuga, emergencia sanitaria u otra que requiera
   intervención inmediata), lista los tipos de situación y aclara que el registro queda con
   fecha/hora/usuario y **no puede editarse después**. Botón **"Continuar con el reporte"**.
2. **Formulario** (`situacion-critica`):
   - NNA involucrado(s) — selección múltiple por checklist (obligatorio, al menos uno).
   - Tipo de situación (obligatorio: *Violencia, Crisis emocional, Accidente, Fuga, Emergencia
     sanitaria, Otra*).
   - Descripción (obligatoria, 20 a 1000 caracteres).
   - Acciones tomadas (opcional).
3. **Confirmación:** resumen con los NNA seleccionados, tipo, descripción, acciones tomadas (si
   se cargaron), fecha/hora y usuario. Botón **Confirmar reporte** (o volver a editar).
4. **Éxito** → el reporte queda guardado con auditoría automática y visible en el Historial (F3)
   de cada NNA involucrado, destacado en rojo.

---

## 7. Perfil

Tab **Perfil**: muestra nombre, rol (Admin / Administrador / Equipo Técnico — roles reales
compartidos con el sistema web) y correo de la sesión actual, y el botón para **cerrar sesión**
(con confirmación).

---

## Resumen de flujo por feature

| Feature | Acceso | Pasos del formulario | Resultado |
|---|---|---|---|
| F1 | Tab Residentes → tarjeta | — (solo lectura) | Detalle con 4 pestañas |
| F2 | Detalle → Novedades → "+ Nueva novedad" | Formulario → Confirmar → Éxito | Aparece en Novedades e Historial |
| F3 | Detalle → Historial | — (solo lectura, con detalle al tocar) | Timeline unificado por día |
| F4 | Detalle → Actividades → "+ Nueva actividad" | Formulario → Confirmar → Éxito | Aparece en Actividades e Historial |
| F5 | Tab Mi turno / Inicio | — (solo lectura, con detalle al tocar) | Novedades 24h + actividades de hoy |
| F6 | Tab Crítica → advertencia → Continuar | Formulario → Confirmar → Éxito | Registro auditado, visible en Historial |
