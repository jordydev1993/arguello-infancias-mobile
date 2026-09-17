# 🔄 FLUJO DE TRABAJO: 4 Analistas + Claude Code

## Metodología: Vibe Engineering + SDD + Paralelismo

**Proyecto:** Argüello Infancias Mobile  
**Equipo:** Jordy (Producto) + Meli (QA) + Cami (UI/UX) + Sofi (Backend)  
**Herramienta:** Claude Code + Terminal  
**Metodología:** Vibe Engineering (8 pasos) + SDD + Trabajo paralelo

---

## 📊 ARQUITECTURA DE COLABORACIÓN

```
┌─────────────────────────────────────────────────────────┐
│           PROYECTO CENTRAL (GitHub)                     │
│   .../arguello-mobile (rama main)                       │
└────────┬────────────────────────────────────────────────┘
         │
    ┌────┴────┬────────┬────────┬────────┐
    │          │        │        │        │
    ▼          ▼        ▼        ▼        ▼
┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐
│ JORDY  │ │ MELI   │ │ CAMI   │ │ SOFI   │
│(Local) │ │(Local) │ │(Local) │ │(Local) │
│ Prod   │ │ QA     │ │ UI/UX  │ │Backend │
└────────┘ └────────┘ └────────┘ └────────┘
     │          │        │        │
     └──────────┼────────┼────────┘
            ┌───┴────────┴───┐
            │  Claude Code   │
            │  (Instancia 4) │
            │  Por analista  │
            └────────────────┘
```

---

## 🔄 CICLO VIBE ENGINEERING (ACTUALIZADO PARA 4 ANALISTAS)

### **8 Pasos Vibe Original**

```
1. Escribe reglas en AGENTS.md + skills/
2. Envía prompt CORTO a Claude Code
3. Claude Code escribe PLAN en prompts/XX-nombre-plan.md
4. TÚ REVISAS el plan (paso crítico — 5 min)
5. Apruebas con "✓ Aprobado" o "✕ Cambiar X"
6. Claude Code implementa
7. Claude Code corre chequeos
8. Tú verificas resultado
```

### **Versión 4 Analistas + SDD**

```
FASE 0: COORDINACIÓN (5 min)
├─ Jordy: "Vamos a hacer F7: Timeline Comentarios"
├─ Divide tareas: Frontend (Cami), Backend (Sofi), QA (Meli)
├─ Crea rama: git checkout -b feature/F7-timeline-comments
└─ Notifica en Slack/Discord

FASE 1: LECTURA (10 min cada uno)
├─ Todos leen: AGENTS.md + skills/
├─ Todos leen: docs/F7-especificaciones.md
├─ Todos leen: docs/criterios-aceptacion-F7.md
└─ Todos leen: docs/flujos-navegacion-F7.md

FASE 2: PLANIFICACIÓN DISTRIBUIDA (15 min - paralelo)
├─ JORDY envía a Claude Code:
│  "Crear plan frontend F7 (componentes + UI)"
│  ✓ Lee AGENTS.md + skills/design.md
│  ✓ Lee docs/F7-especificaciones.md
│  ✓ Escribe prompts/F7-frontend-plan.md
│
├─ MELI envía a Claude Code:
│  "Crear plan testing F7 (casos de prueba)"
│  ✓ Lee AGENTS.md + skills/testing.md
│  ✓ Lee docs/criterios-aceptacion-F7.md
│  ✓ Escribe prompts/F7-testing-plan.md
│
├─ CAMI envía a Claude Code:
│  "Crear plan UI F7 (componentes + design)"
│  ✓ Lee AGENTS.md + skills/design.md
│  ✓ Lee wireframes-F7.md
│  ✓ Escribe prompts/F7-design-plan.md
│
└─ SOFI envía a Claude Code:
   "Crear plan backend F7 (APIs + BD)"
   ✓ Lee AGENTS.md + skills/database.md
   ✓ Lee modelo-datos-F7.md
   ✓ Escribe prompts/F7-backend-plan.md

FASE 3: REVISIÓN DISTRIBUIDA (15 min - paralelo)
├─ JORDY revisa plan frontend → "✓ Aprobado" o "✕ Cambiar X"
├─ MELI revisa plan testing → "✓ Aprobado" o "✕ Cambiar X"
├─ CAMI revisa plan UI → "✓ Aprobado" o "✕ Cambiar X"
└─ SOFI revisa plan backend → "✓ Aprobado" o "✕ Cambiar X"

FASE 4: IMPLEMENTACIÓN PARALELA (120 min)
├─ JORDY implementa componentes (src/components/F7/)
├─ MELI prepara test cases (test/F7.test.ts)
├─ CAMI crea assets + Figma (design/)
└─ SOFI implementa APIs (src/api/F7/)

FASE 5: CHEQUEOS LOCALES (30 min - paralelo)
├─ JORDY corre: npm run build + npm run lint + npm run typecheck
├─ MELI corre: npm run test (F7 tests)
├─ CAMI verifica: design tokens + componentes en Figma
└─ SOFI corre: API tests + BD validation

FASE 6: INTEGRACIÓN (30 min)
├─ Todos merge a rama feature/F7-timeline-comments
├─ SOFI: Ejecuta DDL nuevas tablas (si aplica)
├─ JORDY: Conecta APIs a componentes
├─ MELI: Testing de integración
└─ CAMI: Verifica UI en contexto

FASE 7: VERIFICACIÓN FINAL (30 min)
├─ MELI testea todo F7 (manual + automated)
├─ Todos: Ejecutan npm run build (check final)
├─ Todos: Revisan código (PR review 4 personas)
└─ Todos: Aprueban y mergean a main
```

---

## 📅 EJEMPLO: UN DÍA TÍPICO IMPLEMENTANDO F7

**Funcionalidad:** F7 - Timeline de Comentarios  
**Criterios:** 6 (CA-1 a CA-6)  
**Equipo:** Jordy (Lead), Meli (QA), Cami (UI), Sofi (Backend)

---

## ⏰ 09:00 - STANDUP INICIAL (15 min)

**En Slack/Discord:**

```
🟦 JORDY:
"Buenos días equipo. Hoy implementamos F7: Timeline de Comentarios.
Criterios: 6 (CA-1 a CA-6).
Divido trabajo así:
- Yo (Jordy): Frontend + componentes
- Cami: UI + assets
- Sofi: APIs + BD
- Meli: Testing + QA
¿Todos listos? Comenzamos en 5 min."

🟣 MELI:
"✓ Listo. Acabo de leer AGENTS.md y F7-especificaciones.md"

🟢 CAMI:
"✓ Listo. Abierto Figma y tools de diseño."

🟡 SOFI:
"✓ Listo. Reviví modelo de datos. Necesito crear 1 tabla nueva."

🟦 JORDY:
"Perfecto. Rama: feature/F7-timeline-comments
git checkout -b feature/F7-timeline-comments
Comenzamos en terminal de Claude Code. ¡Vamos!"
```

---

## 🔧 09:15 - LECTURA DE DOCUMENTOS (10 min)

### Todos hacen esto en paralelo:

**JORDY abre terminal de Claude Code:**

```bash
# Terminal en Claude Code (MacBook Jordy)
$ cd ~/projects/arguello-mobile

# Lee AGENTS.md
$ cat AGENTS.md | head -100

# Lee especificaciones F7
$ cat docs/02-ESPECIFICACIONES/F7-timeline-comentarios.md

# Lee criterios
$ cat docs/02-ESPECIFICACIONES/criterios-aceptacion-F7.md

# Lee flujos
$ cat docs/02-ESPECIFICACIONES/flujos-navegacion-F7.md

# Lista estructura actual
$ tree -L 3 src/components/
```

**MELI abre terminal de Claude Code:**

```bash
# Terminal en Claude Code (MacBook Meli)
$ cd ~/projects/arguello-mobile

# Lee AGENTS.md
$ cat AGENTS.md | grep -A 50 "F7"

# Lee criterios aceptación
$ cat docs/02-ESPECIFICACIONES/criterios-aceptacion-F7.md

# Lee especificaciones de testing
$ cat skills/testing.md | grep -A 30 "F7"
```

**CAMI abre terminal de Claude Code:**

```bash
# Terminal en Claude Code (MacBook Cami)
$ cd ~/projects/arguello-mobile

# Lee design system
$ cat skills/design.md

# Lee wireframes F7
$ cat docs/03-DISEÑO/wireframes-F7.md

# Lee design tokens
$ cat src/theme/design-tokens.json
```

**SOFI abre terminal de Claude Code:**

```bash
# Terminal en Claude Code (MacBook Sofi)
$ cd ~/projects/arguello-mobile

# Lee modelo de datos
$ cat skills/database.md

# Lee especificaciones DB F7
$ cat docs/04-BACKEND/F7-modelo-datos.md

# Lista tablas actuales
$ sqlite3 .env.example | .tables
```

---

## 📋 09:30 - FASE 2: GENERACIÓN DE PLANES (15 min - PARALELO)

### **JORDY (Frontend) - Terminal Claude Code**

```bash
$ # En terminal de Claude Code (Jordy)
$ cat > PROMPT-F7-FRONTEND.txt << 'EOF'
PROYECTO: Argüello Infancias Mobile
FEATURE: F7 - Timeline de Comentarios
TAREA: Crear plan de implementación frontend

LEE ESTOS ARCHIVOS:
- AGENTS.md (§7: Frontend Architecture)
- skills/design.md
- docs/02-ESPECIFICACIONES/F7-timeline-comentarios.md
- docs/02-ESPECIFICACIONES/criterios-aceptacion-F7.md
- docs/03-DISEÑO/wireframes-F7.md

CREA UN PLAN que incluya:
1. Estructura de componentes (qué archivos crearás)
2. Componentes específicos (CommentCard.tsx, CommentForm.tsx, etc)
3. Hooks necesarios (useComments.ts, etc)
4. Integración con APIs
5. Estados (empty, loading, error)
6. Validación de tipos TypeScript
7. Design tokens usados

ESCRIBE el plan en: prompts/F7-frontend-plan.md
ESPERA mi aprobación: "✓ Aprobado" o "✕ Cambiar X"
EOF

# Pegamos el contenido en Claude Code
# Claude Code lee proyecto y escribe plan
```

**Claude Code (Jordy instance) responde:**

```markdown
# 📋 PLAN: F7 Frontend - Timeline de Comentarios

## Estructura de Componentes

```
src/components/
├── cards/
│   ├── CommentCard.tsx          (tarjeta individual de comentario)
│   └── CommentThreadCard.tsx    (thread de comentarios)
└── forms/
    └── CommentForm.tsx          (formulario nuevo comentario)
```

## Componentes a Crear

### 1. CommentCard.tsx
- Muestra comentario individual
- Autor, contenido, timestamp, avatar
- Usa design-tokens (colores, tipografía)
- Props tipadas (IComment)
- Estados: normal, editable, deleting

### 2. CommentThreadCard.tsx
- Contenedor de comentarios
- Timeline visual
- Loading state
- Empty state

### 3. CommentForm.tsx
- Input para nuevo comentario
- Textarea para descripción
- Submit + cancel buttons
- Validación en cliente (zod)
- Loading state en submit

## Hooks Necesarios

### useComments.ts
- Lógica para obtener comentarios
- POST comentario nuevo
- PUT editar comentario
- DELETE comentario
- Estados: loading, error, data
- Re-fetch automático

### useCommentValidation.ts
- Validación con zod
- Errores en tiempo real

## Integración con APIs

Endpoints esperados:
- GET /api/residentes/:id/comentarios
- POST /api/residentes/:id/comentarios
- PUT /api/residentes/:id/comentarios/:commentId
- DELETE /api/residentes/:id/comentarios/:commentId

## Design Tokens Usados

- Color primary: #007AFF
- Font: Poppins (medium)
- Spacing: 12px (base unit)
- Border radius: 8px

## Criterios de Aceptación

- [CA-1] Mostrar lista de comentarios ordenados por fecha
- [CA-2] Form nuevo comentario funcional
- [CA-3] Validación de campos
- [CA-4] Estados (empty, loading, error)
- [CA-5] Editar comentario (si es autor)
- [CA-6] Eliminar comentario (si es autor)

---

**STATUS:** ✅ PLAN LISTO
Esperando aprobación de Jordy...
```

---

### **MELI (QA) - Terminal Claude Code**

```bash
$ # En terminal de Claude Code (Meli)
# Similar, pero para testing

PROMPT: "Crear plan de testing para F7"
ARCHIVOS A LEER:
- AGENTS.md (§ Testing)
- skills/testing.md
- docs/criterios-aceptacion-F7.md

CREAR: prompts/F7-testing-plan.md
INCLUIR:
- Test cases por criterio (CA-1 a CA-6)
- Mocks de data
- Casos edge
- Performance expectations
```

**Claude Code (Meli instance) responde:**

```markdown
# 📋 PLAN: F7 Testing - Timeline de Comentarios

## Test Cases por Criterio

### CA-1: Mostrar lista comentarios
- [ ] Test: GET /api/.../comentarios retorna array
- [ ] Test: Comentarios se renderizan en UI
- [ ] Test: Orden por fecha DESC (más recientes primero)

### CA-2: Form nuevo comentario
- [ ] Test: Form visible y accesible
- [ ] Test: Submit envía POST correcto
- [ ] Test: Nuevo comentario aparece en lista

### CA-3: Validación campos
- [ ] Test: Campo vacío no permite submit
- [ ] Test: Mensaje error si campo inválido
- [ ] Test: Máximo 500 caracteres

### CA-4: Estados
- [ ] Test: Loading spinner durante fetch
- [ ] Test: Empty state si no hay comentarios
- [ ] Test: Error state si falla API

### CA-5: Editar comentario
- [ ] Test: Solo autor puede editar
- [ ] Test: PUT /api/.../comentarios/:id
- [ ] Test: Cambios reflejados inmediatamente

### CA-6: Eliminar comentario
- [ ] Test: Confirmación antes de delete
- [ ] Test: DELETE /api/.../comentarios/:id
- [ ] Test: Comentario desaparece de lista

## Test Data Mocks

```typescript
const mockComments = [
  {
    id: "1",
    autor_id: "user-1",
    contenido: "Comentario de prueba",
    fecha_creacion: "2026-09-02T10:00:00Z",
    puede_editar: true,
  },
  // ...
];
```

---

**STATUS:** ✅ PLAN LISTO
Esperando aprobación de Meli...
```

---

### **CAMI (UI/UX) - Terminal Claude Code**

```bash
$ # En terminal de Claude Code (Cami)
PROMPT: "Crear plan de diseño UI/UX para F7"
ARCHIVOS:
- skills/design.md
- docs/wireframes-F7.md
- src/theme/design-tokens.json

CREAR: prompts/F7-design-plan.md
INCLUIR:
- Componentes UI necesarios
- Tokens de color, tipografía, espaciado
- Estados visuales (normal, hover, error, loading)
- Responsive design
- Figma updates
```

**Claude Code (Cami instance) responde:**

```markdown
# 📋 PLAN: F7 Design - Timeline de Comentarios

## Componentes UI a Crear

### CommentCard.tsx
**Layout:**
- Avatar (32x32px) + Nombre (Poppins SemiBold, 14px)
- Timestamp (Poppins Regular, 12px, #666)
- Contenido (Poppins Regular, 14px, #333)
- Botones editar/eliminar (Si es autor)

**Colores:**
- Background: #F8F9FA
- Border: #E0E0E0
- Text: #333333
- Secondary text: #666666

### CommentForm.tsx
**Layout:**
- Avatar pequeño (24x24px)
- Textarea placeholder: "Escribe un comentario..."
- Botones: Guardar (primary), Cancelar (secondary)

**Spacing:**
- Padding: 12px
- Margin bottom: 16px
- Gap entre elementos: 8px

## Estados Visuales

- Normal: Gray background
- Hover: Darker gray border
- Focus: Blue border + glow
- Error: Red border + red text
- Loading: Spinner + disabled state

## Design Tokens Aplicados

```json
{
  "colors": {
    "primary": "#007AFF",
    "secondary": "#7C3AED",
    "text": "#333333",
    "textSecondary": "#666666",
    "border": "#E0E0E0",
    "background": "#F8F9FA"
  },
  "typography": {
    "fontFamily": "Poppins",
    "sizes": {
      "body": "14px",
      "small": "12px",
      "label": "13px"
    }
  },
  "spacing": {
    "xs": "4px",
    "sm": "8px",
    "md": "12px",
    "lg": "16px"
  }
}
```

---

**STATUS:** ✅ PLAN LISTO
Esperando aprobación de Cami...
```

---

### **SOFI (Backend) - Terminal Claude Code**

```bash
$ # En terminal de Claude Code (Sofi)
PROMPT: "Crear plan de backend para F7"
ARCHIVOS:
- skills/database.md
- docs/04-BACKEND/F7-modelo-datos.md
- docs/04-BACKEND/MODELO-DATOS.md (existente)

CREAR: prompts/F7-backend-plan.md
INCLUIR:
- DDL para nueva tabla comentarios
- Índices y constraints
- Relaciones
- APIs (GET, POST, PUT, DELETE)
- RLS policies
- Validation (zod)
```

**Claude Code (Sofi instance) responde:**

```markdown
# 📋 PLAN: F7 Backend - Timeline de Comentarios

## Nuevo Schema

### Tabla: comentarios

```sql
CREATE TABLE comentarios (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  residente_id UUID NOT NULL REFERENCES residentes(id) ON DELETE CASCADE,
  usuario_id UUID NOT NULL REFERENCES perfiles_usuarios(id),
  contenido TEXT NOT NULL,
  fecha_creacion TIMESTAMP DEFAULT NOW(),
  fecha_modificacion TIMESTAMP,
  deleted_at TIMESTAMP,
  
  UNIQUE(id),
  INDEX idx_residente_id (residente_id),
  INDEX idx_usuario_id (usuario_id),
  INDEX idx_fecha (fecha_creacion DESC)
);
```

### RLS Policies

```sql
-- Leer comentarios: educador ve solo los de sus residentes
ALTER TABLE comentarios ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Leer comentarios propios" ON comentarios
  FOR SELECT USING (
    usuario_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM residentes_turnos rt
      WHERE rt.residente_id = comentarios.residente_id
      AND rt.usuario_id = auth.uid()
    )
  );

-- Crear: cualquier educador/coordinador
CREATE POLICY "Crear comentarios" ON comentarios
  FOR INSERT WITH CHECK (
    auth.uid() = usuario_id AND
    (current_user_role() IN ('educador', 'coordinador'))
  );

-- Editar/Eliminar: solo autor o admin
CREATE POLICY "Editar comentarios" ON comentarios
  FOR UPDATE USING (
    usuario_id = auth.uid() OR
    current_user_role() = 'admin'
  );
```

## APIs

### GET /api/residentes/:id/comentarios
```
Query params:
- limit: 20 (default)
- offset: 0 (default)
- ordenar: fecha_desc (default)

Response:
{
  "comentarios": [
    {
      "id": "uuid",
      "contenido": "...",
      "autor": { "id", "nombre", "avatar" },
      "fecha_creacion": "ISO",
      "puede_editar": true/false
    }
  ],
  "total": 45
}
```

### POST /api/residentes/:id/comentarios
```
Body:
{
  "contenido": "Nuevo comentario"
}

Response:
{
  "id": "uuid",
  "contenido": "...",
  "usuario_id": "uuid",
  "fecha_creacion": "ISO"
}
```

### PUT /api/residentes/:id/comentarios/:commentId
```
Body:
{
  "contenido": "Contenido actualizado"
}

Response: Mismo que POST
```

### DELETE /api/residentes/:id/comentarios/:commentId
```
Response: { "deleted": true }
```

## Validation (Zod)

```typescript
const createCommentSchema = z.object({
  contenido: z.string()
    .min(1, "Contenido requerido")
    .max(500, "Máximo 500 caracteres")
});
```

---

**STATUS:** ✅ PLAN LISTO
Esperando aprobación de Sofi...
```

---

## ✅ 09:45 - FASE 3: REVISIÓN DE PLANES (15 min)

### **JORDY revisa plan frontend:**

```
📋 PLAN FRONTEND LISTO

✓ Componentes bien desglosados (CommentCard, CommentForm, etc)
✓ Hooks claros (useComments)
✓ Design tokens aplicados
✓ Criterios cubiertos

APROBACIÓN: ✅ "✓ Aprobado - Adelante con implementación"
```

### **MELI revisa plan testing:**

```
📋 PLAN TESTING LISTO

✓ Test cases por criterio (CA-1 a CA-6)
✓ Mocks de data
✓ Edge cases identificados

APROBACIÓN: ✅ "✓ Aprobado - Empiezo a escribir tests"
```

### **CAMI revisa plan design:**

```
📋 PLAN DESIGN LISTO

✓ Componentes visuales claros
✓ Design tokens mapeados
✓ Estados visuales definidos
✓ Spacing consistente

APROBACIÓN: ✅ "✓ Aprobado - Abierto Figma"
```

### **SOFI revisa plan backend:**

```
📋 PLAN BACKEND LISTO

✓ DDL claro (tabla comentarios)
✓ RLS policies bien definidas
✓ APIs con validación (zod)
✓ Índices para performance

APROBACIÓN: ✅ "✓ Aprobado - Empiezo implementación"
```

---

## 💻 10:00 - FASE 4: IMPLEMENTACIÓN PARALELA (120 min)

### **JORDY implementa componentes**

```bash
# Terminal Claude Code (Jordy)

$ # Abre CommentCard.tsx
cat > src/components/cards/CommentCard.tsx << 'EOF'
import React from 'react';
import { IComment } from '@/types';
import { formatDate } from '@/utils';

interface CommentCardProps {
  comment: IComment;
  onEdit?: (id: string) => void;
  onDelete?: (id: string) => void;
  canEdit?: boolean;
}

export const CommentCard: React.FC<CommentCardProps> = ({
  comment,
  onEdit,
  onDelete,
  canEdit = false,
}) => {
  return (
    <div className="bg-gray-50 rounded-lg p-3 border border-gray-200">
      <div className="flex gap-2">
        <img
          src={comment.autor.avatar}
          alt={comment.autor.nombre}
          className="w-8 h-8 rounded-full"
        />
        <div className="flex-1">
          <div className="flex justify-between items-start">
            <h4 className="font-semibold text-sm text-gray-900">
              {comment.autor.nombre}
            </h4>
            <span className="text-xs text-gray-500">
              {formatDate(comment.fecha_creacion)}
            </span>
          </div>
          <p className="text-sm text-gray-700 mt-1">{comment.contenido}</p>
          
          {canEdit && (
            <div className="flex gap-2 mt-2">
              <button
                onClick={() => onEdit?.(comment.id)}
                className="text-xs text-blue-600 hover:text-blue-800"
              >
                Editar
              </button>
              <button
                onClick={() => onDelete?.(comment.id)}
                className="text-xs text-red-600 hover:text-red-800"
              >
                Eliminar
              </button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};
EOF

# Abre CommentForm.tsx
cat > src/components/forms/CommentForm.tsx << 'EOF'
// Componente del formulario de comentarios
// ...
EOF

# Abre useComments hook
cat > src/hooks/features/useComments.ts << 'EOF'
// Hook para lógica de comentarios
// ...
EOF

# Compila y verifica tipos
npm run typecheck

# Resultado esperado: ✅ No type errors
```

### **MELI implementa tests**

```bash
# Terminal Claude Code (Meli)

$ # Crea archivo de tests
cat > test/features/comments.test.ts << 'EOF'
import { describe, it, expect, beforeEach } from 'vitest';
import { renderHook, act } from '@testing-library/react';
import { useComments } from '@/hooks/features/useComments';

describe('F7: Timeline de Comentarios', () => {
  describe('CA-1: Mostrar lista comentarios', () => {
    it('debe obtener comentarios ordenados por fecha DESC', async () => {
      const { result } = renderHook(() => useComments('residente-1'));
      
      await act(async () => {
        await result.current.fetchComments();
      });
      
      expect(result.current.comments).toBeDefined();
      expect(result.current.comments[0].fecha_creacion)
        .toBeGreaterThan(result.current.comments[1].fecha_creacion);
    });
  });
  
  describe('CA-2: Crear comentario', () => {
    it('debe permitir crear nuevo comentario', async () => {
      // Test implementation
    });
  });
  
  // ... más tests
});
EOF

# Corre tests
npm run test -- test/features/comments.test.ts

# Resultado esperado: ✅ All tests passing
```

### **CAMI crea assets y diseño**

```bash
# Terminal Claude Code (Cami)
# (Aunque Figma es GUI, ella también maneja CLI para assets)

# Crea carpeta de assets si no existe
mkdir -p design/F7-timeline-comments

# Crea archivo de tokens locales
cat > design/F7-timeline-comments/design-spec.json << 'EOF'
{
  "colors": {
    "commentBg": "#F8F9FA",
    "commentBorder": "#E0E0E0",
    "commentText": "#333333"
  },
  "spacing": {
    "commentPadding": "12px",
    "commentGap": "8px"
  },
  "components": [
    {
      "name": "CommentCard",
      "figmaLink": "...",
      "variants": ["default", "hover", "editing"]
    },
    {
      "name": "CommentForm",
      "figmaLink": "...",
      "variants": ["empty", "focused", "error"]
    }
  ]
}
EOF

# Actualiza Figma localmente (exporta componentes)
# npm run figma:sync (comando custom)

# Verifica en Figma web (manual)
echo "✅ Componentes actualizados en Figma"
```

### **SOFI implementa backend**

```bash
# Terminal Claude Code (Sofi)

# Crea archivo de DDL
cat > db/migrations/002-create-comments-table.sql << 'EOF'
CREATE TABLE IF NOT EXISTS comentarios (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  residente_id UUID NOT NULL REFERENCES residentes(id) ON DELETE CASCADE,
  usuario_id UUID NOT NULL REFERENCES perfiles_usuarios(id),
  contenido TEXT NOT NULL,
  fecha_creacion TIMESTAMP DEFAULT NOW(),
  fecha_modificacion TIMESTAMP,
  deleted_at TIMESTAMP
);

-- Índices
CREATE INDEX idx_comentarios_residente_id ON comentarios(residente_id);
CREATE INDEX idx_comentarios_usuario_id ON comentarios(usuario_id);
CREATE INDEX idx_comentarios_fecha ON comentarios(fecha_creacion DESC);

-- RLS Policies
ALTER TABLE comentarios ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Leer comentarios propios" ON comentarios
  FOR SELECT USING (
    usuario_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM residentes_turnos rt
      WHERE rt.residente_id = comentarios.residente_id
      AND rt.usuario_id = auth.uid()
    )
  );

-- ... más policies
EOF

# Crea archivos de API
cat > src/api/routes/comments.ts << 'EOF'
import { Router } from 'express';
import { z } from 'zod';
import { db } from '@/lib/database';
import { authenticate, authorize } from '@/middleware/auth';

const router = Router();

// GET /api/residentes/:id/comentarios
router.get(
  '/api/residentes/:id/comentarios',
  authenticate,
  async (req, res) => {
    const { id } = req.params;
    const { limit = 20, offset = 0 } = req.query;
    
    try {
      const comentarios = await db.query(`
        SELECT c.*, u.nombre, u.avatar
        FROM comentarios c
        JOIN perfiles_usuarios u ON c.usuario_id = u.id
        WHERE c.residente_id = $1 AND c.deleted_at IS NULL
        ORDER BY c.fecha_creacion DESC
        LIMIT $2 OFFSET $3
      `, [id, limit, offset]);
      
      res.json({ comentarios, total: comentarios.length });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
);

// POST, PUT, DELETE endpoints...

export default router;
EOF

# Verifica tipos
npm run typecheck

# Resultado: ✅ APIs compiladas correctamente
```

---

## 🧪 11:00 - FASE 5: CHEQUEOS LOCALES (30 min)

### **JORDY corre linting y builds**

```bash
$ npm run build
$ npm run lint
$ npm run typecheck

# Resultado esperado:
# ✅ Build successful
# ✅ No linting errors
# ✅ No type errors
```

### **MELI corre los tests**

```bash
$ npm run test

# Resultado esperado:
# ✅ 6 test suites passed
# ✅ 18 tests passed
# ✅ 0 failures
```

### **CAMI verifica componentes en Figma**

```bash
$ # Abre Figma manualmente
$ # Verifica:
# ✅ Componentes creados
# ✅ Design tokens aplicados
# ✅ Estados visuales (hover, focus, error)
# ✅ Responsive preview OK
```

### **SOFI valida APIs**

```bash
$ # En Postman o terminal
$ curl -X GET http://localhost:3000/api/residentes/1/comentarios \
  -H "Authorization: Bearer token"

# Resultado esperado:
# 200 OK
# {
#   "comentarios": [...],
#   "total": 5
# }

$ npm run test:api

# ✅ API tests passed
```

---

## 🔗 11:30 - FASE 6: INTEGRACIÓN (30 min)

### **Todos integran en rama feature**

```bash
# Todos hacen:
$ git status
$ git add .
$ git commit -m "feat(F7): Timeline comentarios - [Nombre]"

# Jordy mergea:
$ git merge feature/F7-timeline-comments --no-ff

# Resultado:
$ npm run build        # ✅ Full build OK
$ npm run test         # ✅ All tests OK
$ npm run typecheck    # ✅ No errors
```

### **SOFI ejecuta DDL en BD**

```bash
$ npm run db:migrate

# Migraciones ejecutadas:
# ✅ 002-create-comments-table.sql ejecutada
# ✅ Tabla comentarios creada
# ✅ Índices creados
# ✅ RLS policies aplicadas
```

### **JORDY conecta APIs a componentes**

```bash
# Abre useComments.ts
$ cat > src/hooks/features/useComments.ts << 'EOF'
export const useComments = (residenteId: string) => {
  const [comments, setComments] = useState<IComment[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  
  const fetchComments = useCallback(async () => {
    setLoading(true);
    try {
      const response = await fetch(
        `/api/residentes/${residenteId}/comentarios`,
        {
          headers: { 'Authorization': `Bearer ${token}` }
        }
      );
      const data = await response.json();
      setComments(data.comentarios);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }, [residenteId, token]);
  
  useEffect(() => {
    fetchComments();
  }, [fetchComments]);
  
  return { comments, loading, error, fetchComments };
};
EOF

$ npm run build  # ✅ Build OK
```

---

## 🧪 12:00 - FASE 7: VERIFICACIÓN FINAL (30 min)

### **MELI testing de integración**

```bash
$ # Testing completo: F7 en contexto

$ npm run test:e2e -- test/e2e/comments.e2e.ts

# Resultado:
# ✅ CA-1: Lista comentarios OK
# ✅ CA-2: Crear comentario OK
# ✅ CA-3: Validar campos OK
# ✅ CA-4: Estados (empty, loading, error) OK
# ✅ CA-5: Editar comentario OK
# ✅ CA-6: Eliminar comentario OK

# 6/6 criterios PASSING ✅
```

### **Todos hacen PR review**

```bash
$ git log --oneline | head -10
# abc1234 feat(F7): Timeline comentarios - [4 commits]

$ # En GitHub:
# 1. Jordy abre PR: feature/F7-timeline-comments → main
# 2. Meli revisa: "✓ Aprobado (QA)"
# 3. Cami revisa: "✓ Aprobado (UI)"
# 4. Sofi revisa: "✓ Aprobado (Backend)"
# 5. Todos aprueban
# 6. Jordy mergea a main

# ✅ PR MERGED
```

### **Final verification**

```bash
$ npm run build && npm run test && npm run typecheck

# ✅ Build: PASS
# ✅ Tests: 180/180 PASS (incluye nuevos)
# ✅ TypeCheck: PASS (0 errors)

$ git log --oneline | head -1
# 1a2b3c4 Merge pull request #42: F7 Timeline comentarios

✅ FEATURE F7 COMPLETADA Y MERGEADA A MAIN
```

---

## 12:30 - CIERRE DEL DÍA

**En Slack:**

```
🟦 JORDY:
"✅ F7 Timeline Comentarios COMPLETADA y mergeada a main
6/6 criterios pasando
0 bugs críticos
Excelente trabajo equipo!"

🟣 MELI:
"✅ QA REPORT: 
- 6/6 criterios validados
- Performance <200ms ✓
- RLS policies OK ✓
- 0 bugs críticos"

🟢 CAMI:
"✅ Design completado:
- 2 componentes (Card + Form)
- Design tokens aplicados
- Figma actualizado
- WCAG AA compliant"

🟡 SOFI:
"✅ Backend completado:
- Tabla comentarios + índices
- 4 APIs funcionales
- RLS policies activas
- Migration ejecutada"

📊 RESUMEN:
Horas de trabajo: 3.5 horas
Criterios: 6/6 ✓
Status: PRODUCTION-READY ✓
Próxima feature: F8 (mañana)
```

---

## 📊 COMPARATIVA: FLUJO CON vs SIN CLAUDE CODE

### ❌ SIN CLAUDE CODE (Estimado: 12 horas)

```
Día tradicional sin IA:
├─ 09:00-10:00: Standup + lectura docs (1h)
├─ 10:00-12:00: Escribir código manualmente (2h)
├─ 12:00-13:00: Almuerzo
├─ 13:00-17:00: Debugging + fixes (4h)
├─ 17:00-19:00: Testing + PR review (2h)
└─ 19:00-22:00: Hotfixes + merge (3h)

TOTAL: 12 horas
CRITERIOS: 6/6 (si todo sale bien)
BUGS: Probablemente 2-3 encontrados en QA
```

### ✅ CON CLAUDE CODE (Estimado: 3.5 horas)

```
Con Claude Code + Vibe Engineering:
├─ 09:00-09:15: Standup (0.25h)
├─ 09:15-09:30: Lectura documentos (0.25h)
├─ 09:30-09:45: Generación planes Claude (0.25h)
├─ 09:45-10:00: Revisión planes (0.25h)
├─ 10:00-11:30: Implementación paralela (1.5h)
├─ 11:30-12:00: Chequeos locales (0.5h)
├─ 12:00-12:30: Integración (0.5h)
└─ 12:30-13:00: Verificación final (0.5h)

TOTAL: 3.5 horas
CRITERIOS: 6/6 ✅
BUGS: 0 encontrados
CALIDAD: TypeScript tipado, tests 100%, design OK
```

**MEJORA: 3.4x más rápido, 0 bugs críticos**

---

# 🎯 RECOMENDACIONES: MEJORES PRÁCTICAS

## 1️⃣ ESTRUCTURA DEL PROYECTO (Crítico)

```
arguello-mobile/
├── AGENTS.md                    ⭐ EL COMANDANTE (no modificar)
├── skills/
│   ├── design.md               (Cami lo mantiene)
│   ├── database.md             (Sofi lo mantiene)
│   └── testing.md              (Meli lo mantiene)
├── prompts/                    (Claude Code escribe aquí)
│   ├── F7-frontend-plan.md
│   ├── F7-backend-plan.md
│   ├── F7-design-plan.md
│   └── F7-testing-plan.md
├── docs/
│   ├── 02-ESPECIFICACIONES/
│   │   ├── F7-timeline-comentarios.md
│   │   ├── criterios-aceptacion-F7.md
│   │   └── wireframes-F7.md
│   └── 04-BACKEND/
│       └── F7-modelo-datos.md
└── src/
    ├── components/
    ├── hooks/features/
    ├── api/
    └── lib/
```

**Regla:** AGENTS.md + skills/ + docs/ = Single Source of Truth
Claude Code NUNCA modifica estos archivos (solo lee)
Claude Code escribe planes en prompts/ y código en src/

---

## 2️⃣ ROLES DEFINIDOS (Crítico)

```
JORDY (Producto)
├─ Responsable: Feature lead
├─ Tareas:
│  ├─ Coordina al equipo (standup, issues)
│  ├─ Envía PRIMER prompt a Claude Code (plan general)
│  ├─ Revisa plans de los demás
│  ├─ Implementa componentes + integración
│  └─ Hace merge a main
└─ Terminal Claude Code: Sí (frontend + integración)

MELI (QA)
├─ Responsable: Calidad
├─ Tareas:
│  ├─ Envía prompt para plan testing
│  ├─ Crea test cases (antes de código)
│  ├─ Testing exhaustivo
│  └─ Crea QA Report final
└─ Terminal Claude Code: Sí (tests + automation)

CAMI (UI/UX)
├─ Responsable: Diseño
├─ Tareas:
│  ├─ Envía prompt para plan diseño
│  ├─ Crea/actualiza Figma
│  ├─ Define design tokens
│  └─ Valida implementación visual
└─ Terminal Claude Code: Parcial (solo assets/exportes)

SOFI (Backend)
├─ Responsable: Backend
├─ Tareas:
│  ├─ Envía prompt para plan backend
│  ├─ Implementa BD (DDL, RLS)
│  ├─ Implementa APIs
│  └─ Validación de performance
└─ Terminal Claude Code: Sí (BD + APIs)
```

---

## 3️⃣ CICLO VIBE ENGINEERING (Crítico)

```
PASO 1: LECTURA (Individual - 10 min)
└─ Todos leen: AGENTS.md + skills/ + docs/

PASO 2: GENERACIÓN PLANES (Paralelo - 15 min)
├─ Jordy → Claude: "Plan frontend F7"
├─ Meli → Claude: "Plan testing F7"
├─ Cami → Claude: "Plan design F7"
└─ Sofi → Claude: "Plan backend F7"

PASO 3: REVISIÓN PLANES (Individual - 15 min)
├─ Jordy revisa plan frontend
├─ Meli revisa plan testing
├─ Cami revisa plan design
└─ Sofi revisa plan backend

PASO 4: IMPLEMENTACIÓN (Paralelo - 120 min)
├─ Jordy implementa componentes
├─ Meli crea tests
├─ Cami crea assets
└─ Sofi implementa APIs + BD

PASO 5: CHEQUEOS (Individual - 30 min)
├─ Jordy: npm run build + lint
├─ Meli: npm run test
├─ Cami: Figma verification
└─ Sofi: API tests + DB validation

PASO 6: INTEGRACIÓN (Equipo - 30 min)
├─ Todos: merge a rama feature
├─ Sofi: DB migration
├─ Jordy: Conecta APIs
└─ Meli: Integration testing

PASO 7: VERIFICACIÓN (Equipo - 30 min)
├─ Todos: Full build + test
├─ Todos: PR review (4 personas)
└─ Jordy: Merge a main
```

---

## 4️⃣ CONFIGURACIÓN CLAUDE CODE (Crítico)

### **Cada analista tiene su instancia:**

```bash
# JORDY (MacBook Pro M1)
$ cd ~/projects/arguello-mobile
$ npm install -g claude-code
$ claude-code start
# → Abre en http://localhost:3000
# → Conecta con su GitHub
# → Acceso a src/components/, src/hooks/, src/api/

# MELI (MacBook Pro M1)
$ cd ~/projects/arguello-mobile
$ npm install -g claude-code
$ claude-code start
# → http://localhost:3000
# → Acceso a test/, .test.ts files

# CAMI (MacBook Air M2)
$ cd ~/projects/arguello-mobile
$ npm install -g claude-code
$ claude-code start
# → http://localhost:3000
# → Acceso a design/, src/theme/

# SOFI (Windows 11 + WSL2)
$ cd ~/projects/arguello-mobile
$ npm install -g claude-code
$ claude-code start
# → http://localhost:3000
# → Acceso a src/api/, db/migrations/
```

### **Variables de entorno (.env.local de cada uno):**

```bash
# Todos necesitan:
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_ANON_KEY=xxx
VITE_API_URL=http://localhost:3000

# Cada uno agrega su contexto:
# JORDY
CLAUDE_CODE_ROLE=product
CLAUDE_CODE_WORKSPACE=components,hooks,integrations

# MELI
CLAUDE_CODE_ROLE=qa
CLAUDE_CODE_WORKSPACE=test,automation

# CAMI
CLAUDE_CODE_ROLE=design
CLAUDE_CODE_WORKSPACE=design,components/ui

# SOFI
CLAUDE_CODE_ROLE=backend
CLAUDE_CODE_WORKSPACE=api,database,migrations
```

---

## 5️⃣ PROMPTS EFECTIVOS (Crítico)

### ✅ BUEN PROMPT (Claude Code entiende qué hacer)

```
PROYECTO: Argüello Infancias Mobile
FEATURE: F7 - Timeline de Comentarios
TAREA: Crear plan de implementación frontend

CONTEXTO:
- Metodología: Vibe Engineering + SDD
- Equipo: 4 analistas (Jordy lead)
- Criterios: 6 (CA-1 a CA-6)

LEE ESTOS ARCHIVOS EN ORDEN:
1. AGENTS.md (§7: Frontend Architecture)
2. skills/design.md
3. docs/02-ESPECIFICACIONES/F7-timeline-comentarios.md
4. docs/02-ESPECIFICACIONES/criterios-aceptacion-F7.md
5. docs/03-DISEÑO/wireframes-F7.md

CREA UN PLAN que incluya:
1. Lista de archivos a crear (componentes, hooks, tipos)
2. Componentes específicos (nombre, props, responsabilidades)
3. Hooks necesarios (nombre, estados, lógica)
4. Integración con APIs (endpoints esperados)
5. Design tokens a usar (colores, tipografía, espaciado)
6. Validación de tipos TypeScript (interfaces)
7. Cómo cumplen los criterios de aceptación

FORMATO DEL PLAN:
- Markdown con secciones claras
- Use de code blocks para código propuesto
- Checklist de tareas

ESCRIBE el plan en: prompts/F7-frontend-plan.md
ESPERA aprobación: "✓ Aprobado" o "✕ Cambiar X"

IMPORTANTE:
- NO implementes aún (solo plan)
- NO modifiques AGENTS.md ni skills/
- Sigue la estructura del proyecto existente
```

### ❌ MALO PROMPT (Claude Code confundido)

```
"Implementa comentarios"
```

---

## 6️⃣ GIT WORKFLOW (Crítico)

```bash
# ANTES DE EMPEZAR FEATURE
$ git checkout main
$ git pull origin main

# CREAR RAMA POR FEATURE
$ git checkout -b feature/F7-timeline-comments

# DURANTE DESARROLLO (Todos en misma rama)
$ git status
$ git add [archivos de mi parte]
$ git commit -m "feat(F7): [Mi parte específica] - [Nombre]"
# Ejemplos:
# - "feat(F7): Create CommentCard component - Jordy"
# - "feat(F7): Add comment test cases - Meli"
# - "feat(F7): Design comment UI tokens - Cami"
# - "feat(F7): Implement comment APIs - Sofi"

# PUSH A RAMA FEATURE
$ git push origin feature/F7-timeline-comments

# CUANDO ESTÉ LISTO (Jordy coordina)
$ git checkout feature/F7-timeline-comments
$ git pull origin feature/F7-timeline-comments  (sync latest)
$ npm run build && npm run test && npm run typecheck
# Si todo OK:
$ git checkout main
$ git pull origin main
$ git merge feature/F7-timeline-comments --no-ff
$ git push origin main

# CLEANUP
$ git branch -d feature/F7-timeline-comments
$ git push origin --delete feature/F7-timeline-comments
```

---

## 7️⃣ COMUNICACIÓN EN EQUIPO (Crítico)

### **Slack channels:**

```
#desarrollo-general
├─ Standups diarios
├─ Bloqueadores
└─ Decisiones importantes

#f7-timeline-comentarios  (privado, por feature)
├─ Planes generados
├─ Aprobaciones
├─ Issues encontrados
└─ Cierre

#codigo-reviews
├─ Links de PRs
├─ Comentarios de review
└─ Aprobaciones
```

### **Formato de mensajes:**

```
09:15 [JORDY]
📋 Generando plan F7 frontend en Claude Code...

09:30 [CLAUDECODE]
✅ PLAN LISTO: prompts/F7-frontend-plan.md
Esperando aprobación...

09:35 [JORDY]
✓ Aprobado - 3 cambios menores:
  • Agregar EmptyState component
  • Usar design-tokens v2.1
  • Validación con zod schema

09:36 [CLAUDECODE]
✅ PLAN ACTUALIZADO
Comenzando implementación...

10:30 [CLAUDECODE]
✅ IMPLEMENTACIÓN COMPLETA
- 3 componentes creados
- 1 hook implementado
- 0 type errors
- 0 linting errors
Esperando merge de otros módulos...

11:45 [MELI]
✅ TESTS COMPLETADOS: 6/6 passing ✓

12:00 [SOFI]
✅ APIs COMPLETADAS: GET, POST, PUT, DELETE

12:15 [CAMI]
✅ DESIGN COMPLETADO: Figma actualizado

12:30 [JORDY]
🚀 Integrando todo en main...

13:00 [JORDY]
✅ F7 MERGEADA A MAIN
Criterios: 6/6 ✓
Bugs: 0 ✓
Tiempo: 3.5 horas ✓

🎉 Feature completada!
```

---

## 8️⃣ RESOLUCIÓN DE PROBLEMAS (Crítico)

### **Bloqueador: API no implementada**

```
Situación: Jordy espera que Sofi terminen APIs
Problema: Sofi está retenido en otros tasks

SOLUCIÓN (Vibe Engineering):
1. Jordy: "Sofi, necesito POST /api/comentarios AHORA"
2. Sofi: "Dame 5 min, estoy haciendo DDL"
3. Jordy: "No puedo esperar, ¿puedo mockear?"
4. CONSENSO: Sofi hace API stub (interface + response)
   POST /api/comentarios → retorna mock data
5. Jordy implementa con mock
6. Sofi implementa real
7. Swap automático cuando real esté listo

CÓDIGO:
// En Claude Code (Sofi):
// Stub rápido
export const createComment = async (data) => {
  return {
    id: "mock-1",
    contenido: data.contenido,
    usuario_id: "mock-user"
  };
};

// Cuando esté real, Jordy swappea el import
import { createComment } from '@/api/comments.real';
```

### **Bloqueador: TypeScript errors**

```
Situación: Componente de Cami no compila

ERROR: Property 'avatar' does not exist on type 'Autor'

SOLUCIÓN:
1. Cami: "¿Cuál es el tipo correcto de Autor?"
2. Sofi: "Mira en src/types/index.ts line 45"
3. Cami actualiza types y recompila
4. O mejor: Sofi crea tipo y Cami lo importa

PREVENCIÓN: AGENTS.md debe tener schema de tipos centralizado
```

### **Bloqueador: Merge conflict**

```
Situación: Dos personas modifican mismo archivo

PREVENCIÓN (Vibe Engineering):
- Cada persona modifica su propio módulo
- Nunca dos personas en mismo componente

SI PASA:
$ git merge --abort
Quien llegó primero: merge
Quien llegó después: rebase y soluciona

COMUNICACIÓN: En Slack #f7-timeline-comentarios
```

---

## 9️⃣ MÉTRICAS DE ÉXITO (Crítico)

### **Por día:**

```
✅ Features completadas (criterios 100%)
✅ Bugs críticos: 0
✅ Build time: < 30 segundos
✅ Test coverage: > 80%
✅ Deployment: Exitoso
✅ Team morale: 😊😊😊😊
```

### **Por feature (F7 ejemplo):**

```
✅ Criterios: 6/6 (100%)
✅ Bugs encontrados en testing: 0
✅ Código review: 4 personas ✓
✅ Performance: < 200ms (queries)
✅ TypeScript: 0 errors
✅ Tests: 18/18 passing
✅ Tiempo total: 3.5 horas
✅ Calidad: Production-ready
```

---

## 🔟 TEMPLATE PARA NUEVA FEATURE

Cada vez que comienzan feature nueva:

```markdown
# TEMPLATE: Nueva Feature con Claude Code + 4 Analistas

## Información básica
- **Feature:** F[X] - [Nombre]
- **Criterios:** N (CA-1 a CA-N)
- **Lead:** [Jordy/Meli/Cami/Sofi]
- **Fecha:** YYYY-MM-DD
- **Rama:** feature/F[X]-[nombre-slug]

## Documentación a crear
- [ ] docs/02-ESPECIFICACIONES/F[X]-[nombre].md
- [ ] docs/02-ESPECIFICACIONES/criterios-aceptacion-F[X].md
- [ ] docs/03-DISEÑO/wireframes-F[X].md
- [ ] docs/04-BACKEND/F[X]-modelo-datos.md

## Claude Code Prompts
- [ ] prompts/F[X]-frontend-plan.md
- [ ] prompts/F[X]-backend-plan.md
- [ ] prompts/F[X]-design-plan.md
- [ ] prompts/F[X]-testing-plan.md

## Tareas

### Jordy (Frontend)
- [ ] Leer especificaciones
- [ ] Enviar prompt frontend a Claude Code
- [ ] Revisar plan
- [ ] Implementar componentes
- [ ] Conectar APIs
- [ ] Merge a main

### Meli (QA)
- [ ] Leer especificaciones
- [ ] Enviar prompt testing
- [ ] Crear test cases
- [ ] Testing exhaustivo
- [ ] Crear QA Report

### Cami (UI/UX)
- [ ] Leer especificaciones
- [ ] Enviar prompt design
- [ ] Crear assets Figma
- [ ] Validar implementación

### Sofi (Backend)
- [ ] Leer especificaciones
- [ ] Enviar prompt backend
- [ ] Implementar BD
- [ ] Implementar APIs
- [ ] Validar performance

## Timeline
- 09:00 - Standup
- 09:15 - Lectura (10 min)
- 09:30 - Planes Claude Code (15 min)
- 09:45 - Revisión planes (15 min)
- 10:00 - Implementación paralela (120 min)
- 11:30 - Chequeos (30 min)
- 12:00 - Integración (30 min)
- 12:30 - Verificación (30 min)
- 13:00 - Cierre

## Métricas de éxito
- [ ] Criterios: N/N (100%)
- [ ] Bugs críticos: 0
- [ ] TypeScript errors: 0
- [ ] Tests: 100% passing
- [ ] Performance: OK
- [ ] PR reviewed: 4 personas
- [ ] Mergeado a main
```

---

# 📊 COMPARATIVA: DIFERENTES ESCENARIOS

## Escenario A: Feature Simple (4 criterios)

```
Equipo normal (4 personas):
Tiempo estimado: 2-3 horas
Bugs encontrados: 1-2
Status: Probablemente OK

Con Vibe + Claude Code:
Tiempo real: 1.5 horas
Bugs: 0
Status: Production-ready inmediatamente
```

## Escenario B: Feature Compleja (12 criterios)

```
Equipo normal:
Tiempo: 8+ horas
Bugs: 3-5
Status: Necesita iteraciones

Con Vibe + Claude Code + 4 analistas paralelo:
Tiempo: 4-5 horas
Bugs: 0-1
Status: Listo para producción
```

## Escenario C: Feature crítica (bugs = no release)

```
Equipo normal:
Tiempo: 12+ horas
Bugs: Probables
Status: Riesgoso

Con Vibe + Claude Code + testing automático:
Tiempo: 3-4 horas
Bugs: 0 (testeo exhaustivo)
Status: Alto confianza para release
```

---

# 🎯 CONCLUSIÓN Y RECOMENDACIONES FINALES

## ✅ FUNCIONA PERFECTO CUANDO:

1. ✅ Todos siguen **Vibe Engineering** al pie de la letra
2. ✅ **AGENTS.md** es Single Source of Truth (nadie lo modifica)
3. ✅ **skills/** documentan bien cada dominio
4. ✅ **docs/** tiene especificaciones claras
5. ✅ **Roles claros**: Jordy (lead), Meli (QA), Cami (UI), Sofi (Backend)
6. ✅ **Comunicación asincrónica** en Slack
7. ✅ **Claude Code** solo lee AGENTS + skills + docs
8. ✅ **Claude Code** escribe en prompts/ y src/ (nunca en AGENTS)
9. ✅ **Cada persona** tiene proyecto clonado en local
10. ✅ **Tests antes de código** (Meli crea test cases primero)

## ❌ PROBLEMAS SI:

1. ❌ Modifican AGENTS.md durante desarrollo (pierde contexto)
2. ❌ Falta documentación en docs/ (Claude Code no sabe qué hacer)
3. ❌ Roles superpuestos (dos personas mismo componente)
4. ❌ Sin comunicación en Slack (descoordinados)
5. ❌ Prompts a Claude Code poco específicos
6. ❌ Saltarse paso de revisión de planes (QA fail)
7. ❌ No correr `npm run build` antes de merge
8. ❌ Ignorar test results

## 🚀 RECOMENDACIÓN FINAL:

**Usa este flujo EXACTAMENTE como está:**

```
DÍA 1-2: Setup y dos features pequeñas (familiarizarse)
DÍA 3-7: 2-3 features por día (velocidad máxima)
DESPUÉS: 2-3 features por día indefinidamente
```

**Con 4 analistas + Vibe Engineering + Claude Code:**
- 📊 Capacidad: 10-15 features por semana
- 🐛 Bugs críticos en producción: 0-1 por mes
- 👥 Satisfacción equipo: Alta (menos debugging)
- 💰 Costo: Solo salarios (sin consultores externos)

---

**¡Este es tu flujo de oro!**

