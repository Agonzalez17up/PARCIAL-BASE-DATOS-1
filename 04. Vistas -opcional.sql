-- ============================================
-- VISTAS ÚTILES
-- ============================================

-- Vista de Calificaciones (simula tabla antigua)
CREATE VIEW v_calificaciones AS
SELECT 
    id_inscripcion AS id_calificacion,
    id_estudiante,
    id_curso,
    nota_parcial1,
    nota_parcial2,
    nota_final,
    nota_promedio,
    observaciones,
    fecha_actualizacion AS fecha_registro
FROM inscripciones
WHERE nota_parcial1 IS NOT NULL OR nota_parcial2 IS NOT NULL OR nota_final IS NOT NULL;

-- Vista de Control Escolar (simula tabla antigua)
CREATE VIEW v_control_escolar AS
SELECT 
    id_inscripcion AS id_control,
    id_estudiante,
    id_curso,
    asistencia,
    observaciones,
    estado_control AS estado,
    fecha_actualizacion
FROM inscripciones;

-- Vista de todo el personal (Profesores + Personal)
CREATE VIEW v_todo_personal AS
SELECT 
    id_profesor AS id,
    codigo_profesor AS codigo,
    nombres,
    apellidos,
    email,
    telefono,
    'Docente' AS tipo,
    CONCAT('Profesor de ', especialidad) AS cargo,
    fecha_contratacion,
    salario,
    id_departamento,
    estado,
    'PROFESOR' AS origen
FROM profesores
UNION ALL
SELECT 
    id_personal AS id,
    codigo_personal AS codigo,
    nombres,
    apellidos,
    email,
    telefono,
    tipo_personal AS tipo,
    cargo,
    fecha_contratacion,
    salario,
    id_departamento,
    estado,
    'PERSONAL' AS origen
FROM personal;