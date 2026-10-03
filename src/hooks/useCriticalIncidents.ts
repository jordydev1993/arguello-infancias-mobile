import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';

import type { CriticalIncident, NewCriticalIncident } from '@/types/critical';
import { getSupabase } from '@/lib/supabase';
import { useAuth } from '@/hooks/useAuth';

const INCIDENT_FIELDS =
  'id, nnya_id, tipo, descripcion, fecha_hora, gravedad, reportado_por, acciones_tomadas, estado, created_at, usuarios(nombre, apellido)';

type IncidentRow = {
  id: string;
  nnya_id: string;
  tipo: CriticalIncident['tipo'];
  descripcion: string;
  fecha_hora: string;
  gravedad: CriticalIncident['gravedad'];
  reportado_por: string | null;
  acciones_tomadas: string | null;
  estado: CriticalIncident['estado'];
  created_at: string;
  usuarios: { nombre: string; apellido: string } | null;
};

function toCriticalIncident(row: IncidentRow): CriticalIncident {
  return {
    id: row.id,
    nnya_id: row.nnya_id,
    tipo: row.tipo,
    descripcion: row.descripcion,
    fecha_hora: row.fecha_hora,
    gravedad: row.gravedad,
    reportado_por: row.reportado_por,
    reportado_por_nombre: row.usuarios ? `${row.usuarios.nombre} ${row.usuarios.apellido}` : null,
    acciones_tomadas: row.acciones_tomadas,
    estado: row.estado,
    created_at: row.created_at,
  };
}

/**
 * F6 — Crea un incidente por cada NNA seleccionado en el formulario (la
 * tabla real `incidentes` vincula un solo `nnya_id` por fila — ver PLAN 08).
 * `reportado_por` es siempre el usuario logueado; `gravedad`/`estado` quedan
 * en su default de la DB (`media`/`abierto`), no se piden en el form.
 * `incidentes.legajo_id` es NOT NULL en la base (migración web 20260915193141):
 * se resuelve el legajo activo de cada NNA (hay uno solo por NNA, índice
 * `uq_legajo_activo_por_nnya`).
 */
export function useCreateCriticalIncident() {
  const { user } = useAuth();
  const queryClient = useQueryClient();

  return useMutation<CriticalIncident[], Error, NewCriticalIncident>({
    mutationFn: async (input) => {
      const { data: legajos, error: legajoError } = await getSupabase()
        .from('legajos')
        .select('id, nnya_id')
        .in('nnya_id', input.nnya_ids)
        .eq('estado', 'activo');
      if (legajoError) throw legajoError;

      const legajoPorNnya = new Map((legajos ?? []).map((l) => [l.nnya_id as string, l.id as string]));
      const sinLegajo = input.nnya_ids.filter((id) => !legajoPorNnya.has(id));
      if (sinLegajo.length > 0) {
        throw new Error(
          sinLegajo.length === 1
            ? 'El NNA seleccionado no tiene un legajo activo. Pedile a Dirección o al Equipo Técnico que abra el legajo antes de reportar.'
            : `${sinLegajo.length} de los NNA seleccionados no tienen un legajo activo. Pedile a Dirección o al Equipo Técnico que abra sus legajos antes de reportar.`,
        );
      }

      const rows = input.nnya_ids.map((nnya_id) => ({
        nnya_id,
        legajo_id: legajoPorNnya.get(nnya_id)!,
        tipo: input.tipo,
        descripcion: input.descripcion,
        acciones_tomadas: input.acciones_tomadas || null,
        reportado_por: user?.id ?? null,
      }));

      const { data, error } = await getSupabase()
        .from('incidentes')
        .insert(rows)
        .select(INCIDENT_FIELDS);
      if (error) throw error;
      return ((data ?? []) as unknown as IncidentRow[]).map(toCriticalIncident);
    },
    onSuccess: (_data, variables) => {
      for (const nnyaId of variables.nnya_ids) {
        void queryClient.invalidateQueries({ queryKey: ['critical-incidents', nnyaId] });
      }
    },
  });
}

/**
 * F3/F6 — Incidentes de un NNA, más recientes primero. El historial (#13)
 * los consume directo para armar el timeline con diferenciación visual
 * (CA-50).
 */
export function useCriticalIncidents(nnyaId: string | undefined) {
  return useQuery<CriticalIncident[]>({
    queryKey: ['critical-incidents', nnyaId],
    enabled: Boolean(nnyaId),
    queryFn: async () => {
      const { data, error } = await getSupabase()
        .from('incidentes')
        .select(INCIDENT_FIELDS)
        .eq('nnya_id', nnyaId!)
        .order('fecha_hora', { ascending: false });
      if (error) throw error;
      return ((data ?? []) as unknown as IncidentRow[]).map(toCriticalIncident);
    },
  });
}
