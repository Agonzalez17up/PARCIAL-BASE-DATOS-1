
-- Insertar Departamentos
INSERT INTO departamentos_academicos (nombre_departamento, descripcion, telefono, email) VALUES
('Ciencias Exactas', 'Departamento de Matemáticas, Física y Química', '555-2001', 'ciencias@escuela.edu'),
('Ciencias Sociales', 'Departamento de Historia, Geografía y Sociología', '555-2002', 'sociales@escuela.edu'),
('Lenguas', 'Departamento de Español, Inglés y Literatura', '555-2003', 'lenguas@escuela.edu'),
('Administración', 'Departamento Administrativo', '555-2004', 'admin@escuela.edu');

-- Insertar Profesores (TABLA INDEPENDIENTE)
INSERT INTO profesores (codigo_profesor, nombres, apellidos, email, telefono, especialidad, fecha_contratacion, salario, id_departamento) VALUES
('PROF001', 'María', 'González', 'maria.gonzalez@escuela.edu', '555-0101', 'Matemáticas', '2020-01-15', 45000.00, 1),
('PROF002', 'Juan', 'Pérez', 'juan.perez@escuela.edu', '555-0102', 'Física', '2019-08-20', 48000.00, 1),
('PROF003', 'Ana', 'Martínez', 'ana.martinez@escuela.edu', '555-0103', 'Historia', '2021-03-10', 42000.00, 2),
('PROF004', 'Carlos', 'López', 'carlos.lopez@escuela.edu', '555-0104', 'Inglés', '2020-06-15', 43000.00, 3),
('PROF005', 'Laura', 'Sánchez', 'laura.sanchez@escuela.edu', '555-0105', 'Química', '2021-08-01', 44000.00, 1);

-- Insertar Personal NO Docente (Administrativos, Secretaría, Directivos, Soporte)
INSERT INTO personal (codigo_personal, nombres, apellidos, email, telefono, tipo_personal, cargo, fecha_contratacion, salario, extension, id_departamento) VALUES
-- SECRETARÍA
('SEC001', 'Patricia', 'Gómez', 'patricia.gomez@escuela.edu', '555-3001', 'Secretaria', 'Secretaria Académica - Ciencias', '2018-05-01', 35000.00, 301, 1),
('SEC002', 'Roberto', 'Sánchez', 'roberto.sanchez@escuela.edu', '555-3002', 'Secretaria', 'Secretaria Académica - Sociales', '2019-02-15', 35000.00, 302, 2),
('SEC003', 'Elena', 'Vargas', 'elena.vargas@escuela.edu', '555-3003', 'Secretaria', 'Secretaria Académica - Lenguas', '2020-01-10', 34000.00, 303, 3),

-- ADMINISTRATIVOS
('ADM001', 'Luis', 'Morales', 'luis.morales@escuela.edu', '555-4001', 'Administrativo', 'Coordinador Académico', '2019-02-15', 38000.00, 401, 1),
('ADM002', 'Diana', 'Torres', 'diana.torres@escuela.edu', '555-4002', 'Administrativo', 'Jefe de Recursos Humanos', '2018-06-20', 40000.00, 402, 4),

-- DIRECTIVOS
('DIR001', 'Fernando', 'Díaz', 'fernando.diaz@escuela.edu', '555-5001', 'Directivo', 'Director General', '2015-01-10', 65000.00, 501, 4),
('DIR002', 'Gabriela', 'Ramírez', 'gabriela.ramirez@escuela.edu', '555-5002', 'Directivo', 'Subdirectora Académica', '2017-03-15', 55000.00, 502, 4),

-- SOPORTE
('SOP001', 'Carmen', 'Ruiz', 'carmen.ruiz@escuela.edu', '555-6001', 'Soporte', 'Personal de Limpieza', '2020-09-01', 25000.00, NULL, 4),
('SOP002', 'Jorge', 'Mendoza', 'jorge.mendoza@escuela.edu', '555-6002', 'Soporte', 'Mantenimiento', '2019-11-15', 28000.00, NULL, 4);

-- Insertar Estudiantes
INSERT INTO estudiantes (codigo_estudiante, nombres, apellidos, fecha_nacimiento, email, telefono, direccion, fecha_ingreso) VALUES
('EST2024001', 'Carlos', 'Rodríguez', '2010-05-15', 'carlos.r@email.com', '555-1001', 'Calle Principal 123', '2024-01-15'),
('EST2024002', 'Laura', 'Fernández', '2010-08-22', 'laura.f@email.com', '555-1002', 'Av. Secundaria 456', '2024-01-15'),
('EST2024003', 'Miguel', 'Torres', '2010-03-10', 'miguel.t@email.com', '555-1003', 'Calle Tercera 789', '2024-01-15'),
('EST2024004', 'Sofia', 'Ramírez', '2010-11-30', 'sofia.r@email.com', '555-1004', 'Av. Central 321', '2024-01-15'),
('EST2024005', 'Diego', 'Moreno', '2010-07-18', 'diego.m@email.com', '555-1005', 'Calle Cuarta 555', '2024-01-15');

-- Insertar Infraestructura
INSERT INTO infraestructura (tipo, nombre_espacio, capacidad, ubicacion, id_departamento) VALUES
('Aula', 'Aula 101', 30, 'Edificio A - Planta 1', 1),
('Aula', 'Aula 102', 25, 'Edificio A - Planta 1', 1),
('Laboratorio', 'Lab Física', 20, 'Edificio B - Planta 2', 1),
('Laboratorio', 'Lab Química', 18, 'Edificio B - Planta 2', 1),
('Aula', 'Aula 201', 28, 'Edificio C - Planta 2', 2),
('Aula', 'Aula 202', 30, 'Edificio C - Planta 2', 3),
('Sala', 'Sala de Profesores', 15, 'Edificio A - Planta 3', 4),
('Oficina', 'Dirección', 5, 'Edificio A - Planta 3', 4),
('Oficina', 'Recursos Humanos', 3, 'Edificio A - Planta 3', 4);

-- Insertar Cursos
INSERT INTO cursos (codigo_curso, nombre_curso, descripcion, creditos, id_profesor, id_departamento, nivel) VALUES
('MAT101', 'Matemática Básica', 'Fundamentos de álgebra y geometría', 4, 1, 1, 'Básico'),
('FIS101', 'Física I', 'Introducción a la mecánica clásica', 4, 2, 1, 'Básico'),
('QUI101', 'Química General', 'Fundamentos de química', 4, 5, 1, 'Básico'),
('HIS101', 'Historia Universal', 'Panorama de la historia mundial', 3, 3, 2, 'Básico'),
('ING101', 'Inglés Básico', 'Fundamentos del idioma inglés', 3, 4, 3, 'Básico');

-- Insertar Grupos
INSERT INTO grupos (nombre_grupo, id_curso, horario, cupo_maximo, id_aula, periodo_academico) VALUES
('Grupo A', 1, 'Lunes y Miércoles 8:00-10:00', 30, 1, '2024-1'),
('Grupo B', 2, 'Martes y Jueves 10:00-12:00', 20, 3, '2024-1'),
('Grupo C', 3, 'Miércoles y Viernes 14:00-16:00', 18, 4, '2024-1'),
('Grupo D', 4, 'Viernes 14:00-17:00', 28, 5, '2024-1'),
('Grupo E', 5, 'Lunes a Viernes 7:00-8:00', 25, 6, '2024-1');

-- Insertar Inscripciones (CON calificaciones y control escolar integrado)
INSERT INTO inscripciones (id_estudiante, id_curso, id_grupo, fecha_inscripcion, asistencia, estado_control, nota_parcial1, nota_parcial2, nota_final, estado_inscripcion) VALUES
-- Carlos (estudiante 1)
(1, 1, 1, '2024-01-20', 95.50, 'Regular', 85.5, 90.0, 88.0, 'Cursando'),
(1, 2, 2, '2024-01-20', 88.00, 'Regular', 78.0, 82.5, 80.0, 'Cursando'),
(1, 5, 5, '2024-01-20', 92.00, 'Regular', 90.0, 88.0, 91.0, 'Cursando'),

-- Laura (estudiante 2)
(2, 1, 1, '2024-01-20', 98.00, 'Regular', 92.0, 95.0, 94.5, 'Cursando'),
(2, 3, 3, '2024-01-20', 96.00, 'Regular', 88.0, 90.0, 89.0, 'Cursando'),
(2, 5, 5, '2024-01-20', 97.00, 'Regular', NULL, NULL, NULL, 'Cursando'),

-- Miguel (estudiante 3)
(3, 4, 4, '2024-01-20', 82.00, 'Regular', 88.0, 85.0, 90.0, 'Cursando'),
(3, 5, 5, '2024-01-20', 85.00, 'Regular', 75.0, 78.0, 80.0, 'Cursando'),

-- Sofia (estudiante 4)
(4, 1, 1, '2024-01-20', 75.00, 'Condicionado', 65.0, 70.0, 68.0, 'Cursando'),
(4, 5, 5, '2024-01-20', 89.00, 'Regular', NULL, NULL, NULL, 'Cursando'),

-- Diego (estudiante 5)
(5, 2, 2, '2024-01-20', 91.00, 'Regular', 85.0, 87.0, 86.0, 'Cursando'),
(5, 3, 3, '2024-01-20', 88.00, 'Regular', NULL, NULL, NULL, 'Cursando');