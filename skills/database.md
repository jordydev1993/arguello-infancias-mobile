# Modelo de datos que consume Argüello Infancias Mobile

> Alineado con `../AGENTS.md` [5], `../../AGENTS.md` y las migraciones de `../../arguello-infancias/supabase/migrations/` (fuente de verdad). Verificado contra el código de `src/hooks/`.
> El modelo anterior de este archivo (7 tablas propias: `perfiles_usuarios`, `residentes`, `turnos_trabajo`, `residentes_turnos`, `actividades_diarias`, `situaciones_criticas`, `audit_log` propio) **no existe** y no debe usarse.

## Principio

La app móvil **comparte la base de datos con la web** (Supabase/PostgreSQL, 28 tablas). No tiene tablas propias salvo `novedades`. La autorización la garantiza **RLS** (rol vía `get_my_role()`); no hay backend intermedio.

## Tablas que consume mobile

| Feature | Tablas | Hook |
|---|---|---|
| F1 Residentes | `nnya`, `nnya_tutores` (+ `tutores`) | `useResidents` |
| F2 Registrar novedad | `novedades` | `useObservations` |
| F3 Historial | `novedades`, `incidentes`, `actividades` | `useObservations`, `useCriticalIncidents`, `useActivities` |
| F4 Registrar actividad | `actividades` | `useActivities` |
| F5 Mi turno | `novedades`, `actividades` (+ horario mock; `turnos_personal` vacía) | `useShiftInfo` |
| F6 Situación crítica | `incidentes`, `legajos` | `useCriticalIncidents` |
| Sesión | `usuarios`, `roles` | `authStore` |

## Estructura de cada tabla (resumen)

### `nnya` (residentes)
Entidad central de la web. Mobile agrega tres columnas (migración `20260514000003` + `20260912000035`):

```
id, nombre, apellido, dni (UNIQUE), fecha_nacimiento, lugar_nacimiento, nacionalidad,
genero, domicilio, telefono, email, escolaridad, obra_social, numero_expediente,
activo, estado_actual, fecha_egreso, created_at, updated_at
-- agregadas para mobile:
foto_url             TEXT NULL
alertas_importantes  TEXT NULL
turno_escolar        VARCHAR(50) NULL  CHECK (NULL o 'Mañana','Tarde','Noche','Doble Jornada')
```

- Baja lógica con `activo`; nunca se borra un NNyA.
- La edad se calcula en el cliente desde `fecha_nacimiento`.
- El DNI está en texto plano (decisión documentada en la web).

### `novedades` (nueva, de mobile — migración `20260912000036`)

```
id UUID PK, nnya_id UUID NOT NULL → nnya, usuario_id UUID NULL → usuarios (ON DELETE SET NULL),
tipo VARCHAR(50) NOT NULL CHECK IN ('Salud','Educación','Comportamiento','Alimentación',
                                    'Visita Familiar','Otro'),
descripcion TEXT NOT NULL, fecha_hora TIMESTAMPTZ NOT NULL DEFAULT NOW(),
created_at, updated_at
Índice: idx_novedades_nnya_fecha (nnya_id, fecha_hora DESC)
RLS: Admin y Equipo Tecnico
```

### `actividades` (compartida con la web)

```
id, titulo NOT NULL, descripcion, tipo NOT NULL, fecha DATE NOT NULL, hora_inicio, hora_fin,
lugar, responsable_id → usuarios, nnya_ids UUID[] NOT NULL (grupal, sin legajo_id),
estado CHECK IN ('programada','en_curso','realizada','cancelada') DEFAULT 'programada',
observaciones, created_by → usuarios, created_at, updated_at
```

Mobile filtra por `nnya_ids` (`contains`). Al crear, completa `titulo` (etiqueta del tipo) y `fecha` (hoy), que son NOT NULL en la base.

### `incidentes` (compartida con la web; es la "situación crítica" de mobile)

```
id, nnya_id NOT NULL → nnya, legajo_id → legajos (NOT NULL desde la migración
20260915193141), tipo NOT NULL, descripcion NOT NULL, fecha_hora DEFAULT NOW(),
gravedad CHECK IN ('leve','media','grave','critico') DEFAULT 'media',
reportado_por → usuarios (ON DELETE SET NULL), acciones_tomadas,
estado CHECK IN ('abierto','en_seguimiento','cerrado') DEFAULT 'abierto',
gravedad_sugerida, sugerencia_aceptada, created_at, updated_at
```

Mobile inserta una fila por NNyA seleccionado, con `nnya_id`, `legajo_id`, `tipo`, `descripcion`, `acciones_tomadas` y `reportado_por`. El `legajo_id` se resuelve consultando `legajos` con `estado = 'activo'` (hay un solo legajo activo por NNyA, índice único `uq_legajo_activo_por_nnya`). Si un NNyA no tiene legajo activo, la app no guarda y muestra un aviso.

> Verificado en las migraciones del repo web; no se pudo confirmar contra la base en vivo (la conexión dio timeout). Ante un error de `legajo_id` al reportar, revisar `information_schema.columns`.

### `usuarios` y `roles`
`usuarios` (`id`, `auth_user_id`, `nombre`, `apellido`, `activo`, rol) y `roles` (`nombre`). Roles vigentes: **`Admin`** y **`Equipo Tecnico`**. `authStore` rechaza el ingreso si el usuario está inactivo o su rol no está permitido.

### `audit_log` (compartido con la web)

```
id BIGSERIAL, tabla, operacion CHECK IN ('INSERT','UPDATE','DELETE'), id_registro,
datos_antes JSONB, datos_despues JSONB, auth_uid UUID, fecha TIMESTAMPTZ
```

`fn_audit_trigger()` lo completa automáticamente. Solo `Admin` puede leerlo; nadie puede editarlo ni borrarlo.

## Seguridad y RLS

- RLS activo en todas las tablas; las políticas de negocio permiten a `Admin` y `Equipo Tecnico`.
- **Hoy no existe restricción por asignación**: ambos roles ven todos los NNyA. No asumir un filtro "residentes asignados".
- `nnya_id` usa `ON DELETE RESTRICT` en las tablas de negocio (`prompts/025` de la web): no se puede borrar un NNyA con historial.
- Mobile solo usa la **anon key**; la `service_role` nunca sale del servidor de la web.

## Checklist al tocar la base desde mobile

- [ ] La tabla y las columnas existen en `../../arguello-infancias/supabase/migrations/` (o en la migración de mobile correspondiente).
- [ ] Los campos NOT NULL que la UI no pide se completan en el hook.
- [ ] La operación está permitida por la política RLS del rol.
- [ ] El cambio queda en `audit_log` (verificar con un rol `Admin`).
- [ ] Un cambio de schema se hace como migración en el repo web, no desde la app.
