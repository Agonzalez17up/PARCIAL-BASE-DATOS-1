-- ============================================
-- BASE DE DATOS OPTIMIZADA: ADMINISTRACIÓN EDUCATIVA
-- ============================================
-- ============================================
-- TABLA 1: DEPARTAMENTOS_ACADEMICOS
-- Mantiene la estructura organizacional
-- ============================================
CREATE TABLE departamentos_academicos (
    id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nombre_departamento VARCHAR(100) NOT NULL,
    descripcion TEXT,
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- TABLA 2: PROFESORES
-- Personal docente (TABLA INDEPENDIENTE - MANTENIDA)
-- ============================================
CREATE TABLE profesores (
    id_profesor INT PRIMARY KEY AUTO_INCREMENT,
    codigo_profesor VARCHAR(20) UNIQUE NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    especialidad VARCHAR(100),
    fecha_contratacion DATE NOT NULL,
    salario DECIMAL(10,2),
    id_departamento INT,
    estado ENUM('Activo', 'Inactivo', 'Licencia') DEFAULT 'Activo',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_departamento) REFERENCES departamentos_academicos(id_departamento),
    INDEX idx_especialidad (especialidad),
    INDEX idx_departamento (id_departamento),
    INDEX idx_estado (estado)
);

-- ============================================
-- TABLA 3: PERSONAL (Fusión: RECURSOS_HUMANOS + SECRETARIA_ACADEMICA)
-- Personal NO docente (Administrativos, Directivos, Soporte, Secretaría)
-- ============================================
CREATE TABLE personal (
    id_personal INT PRIMARY KEY AUTO_INCREMENT,
    codigo_personal VARCHAR(20) UNIQUE NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    
    -- Campos laborales
    tipo_personal ENUM('Administrativo', 'Soporte', 'Directivo', 'Secretaria') NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    salario DECIMAL(10,2),
    extension INT, -- Para administrativos/secretaría
    
    -- Relaciones
    id_departamento INT,
    estado ENUM('Activo', 'Inactivo', 'Licencia') DEFAULT 'Activo',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_departamento) REFERENCES departamentos_academicos(id_departamento),
    INDEX idx_tipo_personal (tipo_personal),
    INDEX idx_departamento (id_departamento)
);

-- ============================================
-- TABLA 4: ESTUDIANTES
-- Sin cambios - estructura óptima
-- ============================================
CREATE TABLE estudiantes (
    id_estudiante INT PRIMARY KEY AUTO_INCREMENT,
    codigo_estudiante VARCHAR(20) UNIQUE NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    direccion VARCHAR(200),
    fecha_ingreso DATE NOT NULL,
    estado ENUM('Activo', 'Inactivo', 'Graduado', 'Retirado') DEFAULT 'Activo',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_estado (estado)
);

-- ============================================
-- TABLA 5: INFRAESTRUCTURA
-- Sin cambios - estructura óptima
-- ============================================
CREATE TABLE infraestructura (
    id_infraestructura INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM('Aula', 'Laboratorio', 'Sala', 'Oficina') NOT NULL,
    nombre_espacio VARCHAR(100) NOT NULL,
    capacidad INT,
    ubicacion VARCHAR(150),
    estado ENUM('Disponible', 'En mantenimiento', 'Ocupado') DEFAULT 'Disponible',
    id_departamento INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_departamento) REFERENCES departamentos_academicos(id_departamento),
    INDEX idx_tipo (tipo),
    INDEX idx_estado (estado)
);

-- ============================================
-- TABLA 6: CURSOS
-- Referencia a PROFESORES (tabla independiente)
-- ============================================
CREATE TABLE cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    codigo_curso VARCHAR(20) UNIQUE NOT NULL,
    nombre_curso VARCHAR(150) NOT NULL,
    descripcion TEXT,
    creditos INT NOT NULL,
    id_profesor INT,
    id_departamento INT,
    nivel VARCHAR(50),
    estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor),
    FOREIGN KEY (id_departamento) REFERENCES departamentos_academicos(id_departamento),
    INDEX idx_nivel (nivel),
    INDEX idx_departamento (id_departamento)
);

-- ============================================
-- TABLA 7: GRUPOS
-- Sin cambios sustanciales
-- ============================================
CREATE TABLE grupos (
    id_grupo INT PRIMARY KEY AUTO_INCREMENT,
    nombre_grupo VARCHAR(50) NOT NULL,
    id_curso INT NOT NULL,
    horario VARCHAR(100),
    cupo_maximo INT DEFAULT 30,
    id_aula INT,
    periodo_academico VARCHAR(20) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
    FOREIGN KEY (id_aula) REFERENCES infraestructura(id_infraestructura),
    INDEX idx_periodo (periodo_academico)
);

-- ============================================
-- TABLA 8: INSCRIPCIONES (Fusión: INSCRIPCIONES + CALIFICACIONES + CONTROL_ESCOLAR)
-- Centraliza toda la información académica del estudiante por curso
-- ============================================
CREATE TABLE inscripciones (
    id_inscripcion INT PRIMARY KEY AUTO_INCREMENT,
    
    -- Datos de inscripción
    id_estudiante INT NOT NULL,
    id_curso INT NOT NULL,
    id_grupo INT,
    fecha_inscripcion DATE NOT NULL,
    
    -- Control escolar (antes tabla separada)
    asistencia DECIMAL(5,2) DEFAULT 0.00,
    estado_control ENUM('Regular', 'Condicionado', 'Suspendido') DEFAULT 'Regular',
    
    -- Calificaciones (antes tabla separada)
    nota_parcial1 DECIMAL(5,2),
    nota_parcial2 DECIMAL(5,2),
    nota_final DECIMAL(5,2),
    nota_promedio DECIMAL(5,2) GENERATED ALWAYS AS (
        CASE 
            WHEN nota_parcial1 IS NOT NULL AND nota_parcial2 IS NOT NULL AND nota_final IS NOT NULL
            THEN ROUND((nota_parcial1 + nota_parcial2 + nota_final) / 3, 2)
            ELSE NULL
        END
    ) STORED, -- Campo calculado automáticamente
    
    -- Estado general
    estado_inscripcion ENUM('Inscrito', 'Cursando', 'Aprobado', 'Reprobado', 'Retirado') DEFAULT 'Inscrito',
    observaciones TEXT,
    
    -- Auditoría
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
    FOREIGN KEY (id_grupo) REFERENCES grupos(id_grupo),
    
    UNIQUE KEY unique_inscripcion (id_estudiante, id_curso, id_grupo),
    INDEX idx_estado_control (estado_control),
    INDEX idx_asistencia (asistencia),
    INDEX idx_nota_promedio (nota_promedio)
);
