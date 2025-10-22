-- ============================================
-- CONSULTAS OPTIMIZADAS
-- ============================================

-- 1. Reporte académico completo de un estudiante
SELECT 
    e.codigo_estudiante,
    CONCAT(e.nombres, ' ', e.apellidos) AS estudiante,
    c.codigo_curso,
    c.nombre_curso,
    CONCAT(p.nombres, ' ', p.apellidos) AS profesor,
    g.nombre_grupo,
    g.horario,
    i.asistencia,
    i.nota_parcial1,
    i.nota_parcial2,
    i.nota_final,
    i.nota_promedio, -- Calculado automáticamente
    i.estado_control,
    i.estado_inscripcion
FROM inscripciones i
JOIN estudiantes e ON i.id_estudiante = e.id_estudiante
JOIN cursos c ON i.id_curso = c.id_curso
LEFT JOIN grupos g ON i.id_grupo = g.id_grupo
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor
WHERE e.id_estudiante = 1
ORDER BY c.nombre_curso;

-- 2. Carga académica de profesores
SELECT 
    p.codigo_profesor,
    CONCAT(p.nombres, ' ', p.apellidos) AS profesor,
    p.especialidad,
    d.nombre_departamento,
    COUNT(c.id_curso) AS total_cursos,
    SUM(c.creditos) AS total_creditos,
    GROUP_CONCAT(c.nombre_curso SEPARATOR ', ') AS cursos,
    p.salario
FROM profesores p
LEFT JOIN cursos c ON p.id_profesor = c.id_profesor AND c.estado = 'Activo'
LEFT JOIN departamentos_academicos d ON p.id_departamento = d.id_departamento
WHERE p.estado = 'Activo'
GROUP BY p.id_profesor
ORDER BY total_cursos DESC;

-- 3. Estudiantes con bajo rendimiento
SELECT 
    e.codigo_estudiante,
    CONCAT(e.nombres, ' ', e.apellidos) AS estudiante,
    c.nombre_curso,
    i.asistencia,
    i.nota_promedio,
    i.estado_control,
    CASE 
        WHEN i.asistencia < 70 THEN 'Crítico'
        WHEN i.asistencia < 80 THEN 'Advertencia'
        WHEN i.nota_promedio < 70 THEN 'Bajo rendimiento'
        ELSE 'Regular'
    END AS alerta
FROM inscripciones i
JOIN estudiantes e ON i.id_estudiante = e.id_estudiante
JOIN cursos c ON i.id_curso = c.id_curso
WHERE i.asistencia < 80 OR i.nota_promedio < 70 OR i.estado_control != 'Regular'
ORDER BY i.asistencia ASC, i.nota_promedio ASC;

-- 4. Nómina total por tipo de personal
SELECT 
    'Profesores' AS categoria,
    COUNT(*) AS cantidad,
    SUM(salario) AS total_nomina,
    AVG(salario) AS salario_promedio,
    MIN(salario) AS salario_minimo,
    MAX(salario) AS salario_maximo
FROM profesores
WHERE estado = 'Activo'
UNION ALL
SELECT 
    tipo_personal AS categoria,
    COUNT(*) AS cantidad,
    SUM(salario) AS total_nomina,
    AVG(salario) AS salario_promedio,
    MIN(salario) AS salario_minimo,
    MAX(salario) AS salario_maximo
FROM personal
WHERE estado = 'Activo'
GROUP BY tipo_personal
ORDER BY total_nomina DESC;

-- 5. Ocupación de aulas por periodo
SELECT 
    g.periodo_academico,
    i.nombre_espacio,
    i.tipo,
    i.capacidad,
    COUNT(DISTINCT g.id_grupo) AS grupos_asignados,
    GROUP_CONCAT(CONCAT(c.codigo_curso, ' - ', g.horario) SEPARATOR ' || ') AS detalle_uso
FROM grupos g
JOIN infraestructura i ON g.id_aula = i.id_infraestructura
JOIN cursos c ON g.id_curso = c.id_curso
GROUP BY g.periodo_academico, i.id_infraestructura
ORDER BY g.periodo_academico, i.nombre_espacio;

-- 6. Promedio general por estudiante
SELECT 
    e.codigo_estudiante,
    CONCAT(e.nombres, ' ', e.apellidos) AS estudiante,
    COUNT(i.id_inscripcion) AS total_cursos,
    ROUND(AVG(i.nota_promedio), 2) AS promedio_general,
    ROUND(AVG(i.asistencia), 2) AS asistencia_promedio,
    SUM(c.creditos) AS creditos_cursados
FROM estudiantes e
LEFT JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
LEFT JOIN cursos c ON i.id_curso = c.id_curso
WHERE e.estado = 'Activo'
GROUP BY e.id_estudiante
ORDER BY promedio_general DESC;


-- Boletín completo de un estudiante en UNA consulta
SELECT 
    e.codigo_estudiante,
    CONCAT(e.nombres, ' ', e.apellidos) AS estudiante,
    c.nombre_curso,
    CONCAT(p.nombres, ' ', p.apellidos) AS profesor,
    g.nombre_grupo,
    i.asistencia AS 'Asistencia %',
    i.nota_parcial1 AS 'Parcial 1',
    i.nota_parcial2 AS 'Parcial 2',
    i.nota_final AS 'Final',
    i.nota_promedio AS 'Promedio', -- ¡Calculado automáticamente!
    CASE 
        WHEN i.nota_promedio >= 90 THEN 'Excelente'
        WHEN i.nota_promedio >= 80 THEN 'Muy Bueno'
        WHEN i.nota_promedio >= 70 THEN 'Bueno'
        WHEN i.nota_promedio >= 60 THEN 'Aprobado'
        ELSE 'Reprobado'
    END AS 'Calificación',
    i.estado_inscripcion
FROM inscripciones i
JOIN estudiantes e ON i.id_estudiante = e.id_estudiante
JOIN cursos c ON i.id_curso = c.id_curso
JOIN grupos g ON i.id_grupo = g.id_grupo
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor
WHERE e.codigo_estudiante = 'EST2024001'
ORDER BY c.nombre_curso;
