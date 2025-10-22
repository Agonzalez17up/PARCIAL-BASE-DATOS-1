# PARCIAL-BASE-DATOS-1
Base de datos platel educativo
# 📚 DICCIONARIO DE DATOS - SISTEMA EDUCATIVO
**Versión:** 2.0 Optimizada  
**Fecha:** Octubre 2025  
**Total de Tablas:** 8

---

## TABLA 1: DEPARTAMENTOS_ACADEMICOS

**Descripción:** Almacena la estructura organizacional de la institución educativa, agrupando las diferentes áreas académicas y administrativas.

**Nombre físico:** `departamentos_academicos`

| Campo | Tipo de Dato | Longitud | Nulo | Clave | Default | Descripción |
|-------|--------------|----------|------|-------|---------|-------------|
| id_departamento | INT | - | NO | PK | AUTO_INCREMENT | Identificador único del departamento |
| nombre_departamento | VARCHAR | 100 | NO | - | - | Nombre oficial del departamento (ej: Ciencias Exactas) |
| descripcion | TEXT | 65535 | SÍ | - | NULL | Descripción detallada de las funciones y áreas del departamento |
| telefono | VARCHAR | 20 | SÍ | - | NULL | Número de teléfono de contacto del departamento |
| email | VARCHAR | 100 | SÍ | - | NULL | Correo electrónico institucional del departamento |
| fecha_registro | TIMESTAMP | - | NO | - | CURRENT_TIMESTAMP | Fecha y hora de creación del registro |

**Índices:**
- PRIMARY KEY: `id_departamento`

**Relaciones:**
- 1:N con PROFESORES (un departamento tiene múltiples profesores)
- 1:N con PERSONAL (un departamento tiene múltiples empleados)
- 1:N con CURSOS (un departamento ofrece múltiples cursos)
- 1:N con INFRAESTRUCTURA (un departamento administra múltiples espacios)

**Reglas de Negocio:**
- El nombre del departamento debe ser único en la institución
- Todo departamento debe tener un nombre
- El email debe tener formato válido si se proporciona

**Ejemplos de datos:**
```
ID: 1, Nombre: "Ciencias Exactas", Tel: "555-2001"
ID: 2, Nombre: "Ciencias Sociales", Tel: "555-2002"
ID: 3, Nombre: "Lenguas", Tel: "555-2003"
```

---

## TABLA 2: PROFESORES

**Descripción:** Contiene la información del personal docente de la institución. Esta tabla se mantiene independiente para facilitar la gestión académica y carga horaria.

**Nombre físico:** `profesores`

| Campo | Tipo de Dato | Longitud | Nulo | Clave | Default | Descripción |
|-------|--------------|----------|------|-------|---------|-------------|
| id_profesor | INT | - | NO | PK | AUTO_INCREMENT | Identificador único del profesor |
| codigo_profesor | VARCHAR | 20 | NO | UK | - | Código de empleado único del profesor (ej: PROF001) |
| nombres | VARCHAR | 100 | NO | - | - | Nombres completos del profesor |
| apellidos | VARCHAR | 100 | NO | - | - | Apellidos completos del profesor |
| email | VARCHAR | 100 | NO | UK | - | Correo electrónico institucional único |
| telefono | VARCHAR | 20 | SÍ | - | NULL | Número de teléfono de contacto |
| especialidad | VARCHAR | 100 | SÍ | - | NULL | Área de especialización académica (ej: Matemáticas, Física) |
| fecha_contratacion | DATE | - | NO | - | - | Fecha de inicio de labores |
| salario | DECIMAL | 10,2 | SÍ | - | NULL | Salario mensual bruto |
| id_departamento | INT | - | SÍ | FK | NULL | Departamento al que pertenece |
| estado | ENUM | - | NO | - | 'Activo' | Estado laboral: Activo, Inactivo, Licencia |
| fecha_registro | TIMESTAMP | - | NO | - | CURRENT_TIMESTAMP | Fecha y hora de creación del registro |

**Índices:**
- PRIMARY KEY: `id_profesor`
- UNIQUE KEY: `codigo_profesor`
- UNIQUE KEY: `email`
- INDEX: `idx_especialidad`
- INDEX: `idx_departamento`
- INDEX: `idx_estado`

**Relaciones:**
- N:1 con DEPARTAMENTOS_ACADEMICOS (varios profesores pertenecen a un departamento)
- 1:N con CURSOS (un profesor imparte múltiples cursos)

**Reglas de Negocio:**
- El código de profesor debe ser único en todo el sistema
- El email debe ser único y tener formato institucional
- La fecha de contratación no puede ser futura
- El salario debe ser un valor positivo
- Un profesor puede estar sin departamento temporalmente
- Solo profesores activos pueden tener cursos asignados

**Ejemplos de datos:**
```
ID: 1, Código: "PROF001", Nombre: "María González", Especialidad: "Matemáticas"
ID: 2, Código: "PROF002", Nombre: "Juan Pérez", Especialidad: "Física"
```

---

## TABLA 3: PERSONAL

**Descripción:** Almacena información del personal NO docente de la institución (administrativos, secretaría, directivos, personal de soporte). Fusiona las antiguas tablas de RECURSOS_HUMANOS y SECRETARIA_ACADEMICA.

**Nombre físico:** `personal`

| Campo | Tipo de Dato | Longitud | Nulo | Clave | Default | Descripción |
|-------|--------------|----------|------|-------|---------|-------------|
| id_personal | INT | - | NO | PK | AUTO_INCREMENT | Identificador único del empleado |
| codigo_personal | VARCHAR | 20 | NO | UK | - | Código de empleado único (ej: ADM001, SEC001) |
| nombres | VARCHAR | 100 | NO | - | - | Nombres completos del empleado |
| apellidos | VARCHAR | 100 | NO | - | - | Apellidos completos del empleado |
| email | VARCHAR | 100 | NO | UK | - | Correo electrónico institucional único |
| telefono | VARCHAR | 20 | SÍ | - | NULL | Número de teléfono de contacto |
| tipo_personal | ENUM | - | NO | - | - | Tipo: Administrativo, Soporte, Directivo, Secretaria |
| cargo | VARCHAR | 100 | NO | - | - | Puesto o cargo del empleado |
| fecha_contratacion | DATE | - | NO | - | - | Fecha de inicio de labores |
| salario | DECIMAL | 10,2 | SÍ | - | NULL | Salario mensual bruto |
| extension | INT | - | SÍ | - | NULL | Extensión telefónica (solo para administrativos/secretaría) |
| id_departamento | INT | - | SÍ | FK | NULL | Departamento al que pertenece |
| estado | ENUM | - | NO | - | 'Activo' | Estado laboral: Activo, Inactivo, Licencia |
| fecha_registro | TIMESTAMP | - | NO | - | CURRENT_TIMESTAMP | Fecha y hora de creación del registro |

**Índices:**
- PRIMARY KEY: `id_personal`
- UNIQUE KEY: `codigo_personal`
- UNIQUE KEY: `email`
- INDEX: `idx_tipo_personal`
- INDEX: `idx_departamento`

**Relaciones:**
- N:1 con DEPARTAMENTOS_ACADEMICOS (varios empleados pertenecen a un departamento)

**Reglas de Negocio:**
- El código de personal debe ser único
- El email debe ser único y con formato institucional
- El tipo_personal determina las funciones del empleado
- La extensión solo aplica para Administrativos y Secretaría
- El salario debe ser un valor positivo
- La fecha de contratación no puede ser futura

**Ejemplos de datos:**
```
ID: 1, Código: "SEC001", Tipo: "Secretaria", Cargo: "Secretaria Académica"
ID: 2, Código: "DIR001", Tipo: "Directivo", Cargo: "Director General"
ID: 3, Código: "SOP001", Tipo: "Soporte", Cargo: "Personal de Limpieza"
```

---

## TABLA 4: ESTUDIANTES

**Descripción:** Registra la información personal y académica de todos los estudiantes matriculados en la institución.

**Nombre físico:** `estudiantes`

| Campo | Tipo de Dato | Longitud | Nulo | Clave | Default | Descripción |
|-------|--------------|----------|------|-------|---------|-------------|
| id_estudiante | INT | - | NO | PK | AUTO_INCREMENT | Identificador único del estudiante |
| codigo_estudiante | VARCHAR | 20 | NO | UK | - | Código de matrícula único (ej: EST2024001) |
| nombres | VARCHAR | 100 | NO | - | - | Nombres completos del estudiante |
| apellidos | VARCHAR | 100 | NO | - | - | Apellidos completos del estudiante |
| fecha_nacimiento | DATE | - | NO | - | - | Fecha de nacimiento del estudiante |
| email | VARCHAR | 100 | SÍ | UK | NULL | Correo electrónico personal |
| telefono | VARCHAR | 20 | SÍ | - | NULL | Número de teléfono de contacto |
| direccion | VARCHAR | 200 | SÍ | - | NULL | Dirección de residencia |
| fecha_ingreso | DATE | - | NO | - | - | Fecha de ingreso a la institución |
| estado | ENUM | - | NO | - | 'Activo' | Estado: Activo, Inactivo, Graduado, Retirado |
| fecha_registro | TIMESTAMP | - | NO | - | CURRENT_TIMESTAMP | Fecha y hora de creación del registro |

**Índices:**
- PRIMARY KEY: `id_estudiante`
- UNIQUE KEY: `codigo_estudiante`
- UNIQUE KEY: `email` (si se proporciona)
- INDEX: `idx_estado`

**Relaciones:**
- 1:N con INSCRIPCIONES (un estudiante tiene múltiples inscripciones)

**Reglas de Negocio:**
- El código de estudiante debe ser único y seguir formato institucional
- El email debe ser único si se proporciona
- La fecha de nacimiento debe indicar edad mínima para ingreso
- La fecha de ingreso no puede ser futura
- Un estudiante debe estar activo para inscribirse en cursos
- Al graduarse, el estado cambia automáticamente

**Ejemplos de datos:**
```
ID: 1, Código: "EST2024001", Nombre: "Carlos Rodríguez", Estado: "Activo"
ID: 2, Código: "EST2024002", Nombre: "Laura Fernández", Estado: "Activo"
```

---

## TABLA 5: INFRAESTRUCTURA

**Descripción:** Gestiona los espacios físicos de la institución (aulas, laboratorios, oficinas, salas) y su disponibilidad.

**Nombre físico:** `infraestructura`

| Campo | Tipo de Dato | Longitud | Nulo | Clave | Default | Descripción |
|-------|--------------|----------|------|-------|---------|-------------|
| id_infraestructura | INT | - | NO | PK | AUTO_INCREMENT | Identificador único del espacio |
| tipo | ENUM | - | NO | - | - | Tipo de espacio: Aula, Laboratorio, Sala, Oficina |
| nombre_espacio | VARCHAR | 100 | NO | - | - | Nombre o número del espacio (ej: Aula 101, Lab Física) |
| capacidad | INT | - | SÍ | - | NULL | Capacidad máxima de personas |
| ubicacion | VARCHAR | 150 | SÍ | - | NULL | Ubicación física (edificio, piso) |
| estado | ENUM | - | NO | - | 'Disponible' | Estado: Disponible, En mantenimiento, Ocupado |
| id_departamento | INT | - | SÍ | FK | NULL | Departamento responsable del espacio |
| fecha_registro | TIMESTAMP | - | NO | - | CURRENT_TIMESTAMP | Fecha y hora de creación del registro |

**Índices:**
- PRIMARY KEY: `id_infraestructura`
- INDEX: `idx_tipo`
- INDEX: `idx_estado`

**Relaciones:**
- N:1 con DEPARTAMENTOS_ACADEMICOS (un departamento administra múltiples espacios)
- 1:N con GRUPOS (un espacio puede albergar múltiples grupos en diferentes horarios)

**Reglas de Negocio:**
- El nombre del espacio debe ser descriptivo y único
- La capacidad debe ser un número positivo
- Solo espacios "Disponibles" pueden asignarse a grupos
- Espacios tipo "Laboratorio" requieren equipamiento especial
- El estado cambia automáticamente según asignaciones

**Ejemplos de datos:**
```
ID: 1, Tipo: "Aula", Nombre: "Aula 101", Capacidad: 30
ID: 2, Tipo: "Laboratorio", Nombre: "Lab Física", Capacidad: 20
```

---

## TABLA 6: CURSOS

**Descripción:** Define las materias o asignaturas que se imparten en la institución, incluyendo sus características académicas.

**Nombre físico:** `cursos`

| Campo | Tipo de Dato | Longitud | Nulo | Clave | Default | Descripción |
|-------|--------------|----------|------|-------|---------|-------------|
| id_curso | INT | - | NO | PK | AUTO_INCREMENT | Identificador único del curso |
| codigo_curso | VARCHAR | 20 | NO | UK | - | Código oficial del curso (ej: MAT101, FIS101) |
| nombre_curso | VARCHAR | 150 | NO | - | - | Nombre completo de la materia |
| descripcion | TEXT | 65535 | SÍ | - | NULL | Descripción detallada del contenido del curso |
| creditos | INT | - | NO | - | - | Número de créditos académicos (valor positivo) |
| id_profesor | INT | - | SÍ | FK | NULL | Profesor asignado al curso |
| id_departamento | INT | - | SÍ | FK | NULL | Departamento que ofrece el curso |
| nivel | VARCHAR | 50 | SÍ | - | NULL | Nivel académico (Básico, Intermedio, Avanzado) |
| estado | ENUM | - | NO | - | 'Activo' | Estado del curso: Activo, Inactivo |
| fecha_registro | TIMESTAMP | - | NO | - | CURRENT_TIMESTAMP | Fecha y hora de creación del registro |

**Índices:**
- PRIMARY KEY: `id_curso`
- UNIQUE KEY: `codigo_curso`
- INDEX: `idx_nivel`
- INDEX: `idx_departamento`

**Relaciones:**
- N:1 con PROFESORES (un curso es impartido por un profesor)
- N:1 con DEPARTAMENTOS_ACADEMICOS (un curso pertenece a un departamento)
- 1:N con GRUPOS (un curso puede tener múltiples grupos)
- 1:N con INSCRIPCIONES (un curso tiene múltiples inscripciones)

**Reglas de Negocio:**
- El código del curso debe ser único y seguir nomenclatura institucional
- Los créditos deben ser un valor positivo (1-10 típicamente)
- Un curso puede existir sin profesor asignado temporalmente
- Solo cursos activos pueden tener inscripciones nuevas
- El nivel determina prerrequisitos académicos

**Ejemplos de datos:**
```
ID: 1, Código: "MAT101", Nombre: "Matemática Básica", Créditos: 4
ID: 2, Código: "FIS101", Nombre: "Física I", Créditos: 4
```

---

## TABLA 7: GRUPOS

**Descripción:** Representa las secciones o grupos en los que se divide un curso, con horarios y aulas específicas.

**Nombre físico:** `grupos`

| Campo | Tipo de Dato | Longitud | Nulo | Clave | Default | Descripción |
|-------|--------------|----------|------|-------|---------|-------------|
| id_grupo | INT | - | NO | PK | AUTO_INCREMENT | Identificador único del grupo |
| nombre_grupo | VARCHAR | 50 | NO | - | - | Nombre del grupo (ej: Grupo A, Grupo B) |
| id_curso | INT | - | NO | FK | - | Curso al que pertenece el grupo |
| horario | VARCHAR | 100 | SÍ | - | NULL | Descripción del horario (ej: Lunes y Miércoles 8:00-10:00) |
| cupo_maximo | INT | - | SÍ | - | 30 | Capacidad máxima de estudiantes |
| id_aula | INT | - | SÍ | FK | NULL | Aula asignada (referencia a INFRAESTRUCTURA) |
| periodo_academico | VARCHAR | 20 | NO | - | - | Periodo académico (ej: 2024-1, 2024-2) |
| fecha_registro | TIMESTAMP | - | NO | - | CURRENT_TIMESTAMP | Fecha y hora de creación del registro |

**Índices:**
- PRIMARY KEY: `id_grupo`
- INDEX: `idx_periodo`

**Relaciones:**
- N:1 con CURSOS (un grupo pertenece a un curso)
- N:1 con INFRAESTRUCTURA (un grupo se imparte en un aula)
- 1:N con INSCRIPCIONES (un grupo tiene múltiples estudiantes inscritos)

**Reglas de Negocio:**
- Un curso puede tener múltiples grupos en el mismo periodo
- El cupo máximo no debe exceder la capacidad del aula
- No pueden solaparse horarios en la misma aula
- El periodo académico debe seguir formato institucional
- Al alcanzar cupo máximo, no se permiten más inscripciones

**Ejemplos de datos:**
```
ID: 1, Nombre: "Grupo A", Curso: MAT101, Horario: "Lun-Mie 8:00-10:00"
ID: 2, Nombre: "Grupo B", Curso: FIS101, Horario: "Mar-Jue 10:00-12:00"
```

---

## TABLA 8: INSCRIPCIONES

**Descripción:** Tabla central que registra la matrícula de estudiantes en cursos y centraliza toda su información académica (calificaciones, asistencia, control escolar). Fusiona las antiguas tablas INSCRIPCIONES, CALIFICACIONES y CONTROL_ESCOLAR.

**Nombre físico:** `inscripciones`

| Campo | Tipo de Dato | Longitud | Nulo | Clave | Default | Descripción |
|-------|--------------|----------|------|-------|---------|-------------|
| id_inscripcion | INT | - | NO | PK | AUTO_INCREMENT | Identificador único de la inscripción |
| id_estudiante | INT | - | NO | FK | - | Estudiante inscrito |
| id_curso | INT | - | NO | FK | - | Curso en el que se inscribe |
| id_grupo | INT | - | SÍ | FK | NULL | Grupo específico del curso |
| fecha_inscripcion | DATE | - | NO | - | - | Fecha de inscripción al curso |
| asistencia | DECIMAL | 5,2 | SÍ | - | 0.00 | Porcentaje de asistencia (0-100) |
| estado_control | ENUM | - | NO | - | 'Regular' | Control: Regular, Condicionado, Suspendido |
| nota_parcial1 | DECIMAL | 5,2 | SÍ | - | NULL | Calificación del primer parcial (0-100) |
| nota_parcial2 | DECIMAL | 5,2 | SÍ | - | NULL | Calificación del segundo parcial (0-100) |
| nota_final | DECIMAL | 5,2 | SÍ | - | NULL | Calificación del examen final (0-100) |
| nota_promedio | DECIMAL | 5,2 | CALC | - | CALCULATED | Promedio calculado automáticamente |
| estado_inscripcion | ENUM | - | NO | - | 'Inscrito' | Estado: Inscrito, Cursando, Aprobado, Reprobado, Retirado |
| observaciones | TEXT | 65535 | SÍ | - | NULL | Comentarios o notas adicionales |
| fecha_registro | TIMESTAMP | - | NO | - | CURRENT_TIMESTAMP | Fecha y hora de creación del registro |
| fecha_actualizacion | TIMESTAMP | - | NO | - | CURRENT_TIMESTAMP | Fecha y hora de última actualización |

**Índices:**
- PRIMARY KEY: `id_inscripcion`
- UNIQUE KEY: `unique_inscripcion (id_estudiante, id_curso, id_grupo)`
- INDEX: `idx_estado_control`
- INDEX: `idx_asistencia`
- INDEX: `idx_nota_promedio`

**Relaciones:**
- N:1 con ESTUDIANTES (una inscripción pertenece a un estudiante)
- N:1 con CURSOS (una inscripción es para un curso)
- N:1 con GRUPOS (una inscripción es en un grupo específico)

**Reglas de Negocio:**
- Un estudiante no puede inscribirse dos veces en el mismo curso y grupo
- La asistencia debe estar entre 0 y 100
- Las notas deben estar entre 0 y 100
- El promedio se calcula automáticamente: (parcial1 + parcial2 + final) / 3
- Asistencia < 70% → estado_control pasa a "Condicionado"
- Asistencia < 50% → estado_control pasa a "Suspendido"
- Promedio >= 60 → estado_inscripcion = "Aprobado"
- Promedio < 60 → estado_inscripcion = "Reprobado"
- La fecha de inscripción no puede ser futura

**Campo Calculado:**
```sql
nota_promedio GENERATED ALWAYS AS (
    CASE 
        WHEN nota_parcial1 IS NOT NULL 
         AND nota_parcial2 IS NOT NULL 
         AND nota_final IS NOT NULL
        THEN ROUND((nota_parcial1 + nota_parcial2 + nota_final) / 3, 2)
        ELSE NULL
    END
) STORED
```

**Ejemplos de datos:**
```
ID: 1, Estudiante: 1, Curso: MAT101, Asistencia: 95.5%, 
       Parcial1: 85.5, Parcial2: 90.0, Final: 88.0, Promedio: 87.83

ID: 2, Estudiante: 1, Curso: FIS101, Asistencia: 88.0%,
       Parcial1: 78.0, Parcial2: 82.5, Final: 80.0, Promedio: 80.17
```

---

## RESUMEN GENERAL DEL MODELO

### Estadísticas:
- **Total de tablas:** 8
- **Total de campos:** ~95
- **Total de relaciones (FK):** 11
- **Campos calculados:** 1 (nota_promedio)
- **Índices totales:** 15

### Relaciones entre tablas:
```
DEPARTAMENTOS_ACADEMICOS (1) → (N) PROFESORES
DEPARTAMENTOS_ACADEMICOS (1) → (N) PERSONAL
DEPARTAMENTOS_ACADEMICOS (1) → (N) CURSOS
DEPARTAMENTOS_ACADEMICOS (1) → (N) INFRAESTRUCTURA

PROFESORES (1) → (N) CURSOS

CURSOS (1) → (N) GRUPOS
CURSOS (1) → (N) INSCRIPCIONES

GRUPOS (1) → (N) INSCRIPCIONES

INFRAESTRUCTURA (1) → (N) GRUPOS

ESTUDIANTES (1) → (N) INSCRIPCIONES
```

### Convenciones:
- **PK:** Primary Key (Clave Primaria)
- **FK:** Foreign Key (Clave Foránea)
- **UK:** Unique Key (Clave Única)
- **CALC:** Campo Calculado Automáticamente
- **ENUM:** Enumeración con valores predefinidos
- **Longitud:** Número máximo de caracteres o dígitos

### Notas importantes:
1. Todos los IDs son AUTO_INCREMENT
2. Todos los timestamps tienen valores por defecto
3. Los campos ENUM tienen valores restringidos
4. Las claves foráneas mantienen integridad referencial
5. Los índices mejoran el rendimiento de consultas frecuentes
