-- Таблиця кафедр
CREATE TABLE department (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    faculty_name VARCHAR(100) NOT NULL,
    office_number VARCHAR(10)
);

-- Таблиця викладачів
CREATE TABLE teacher (
    teacher_id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    position VARCHAR(50),
    department_id INTEGER REFERENCES department(department_id)
);

-- Таблиця студентів
CREATE TABLE student (
    student_id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    enrollment_year INTEGER CHECK (enrollment_year >= 2000)
);

-- Таблиця курсів
CREATE TABLE course (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER CHECK (credits BETWEEN 1 AND 10),
    semester INTEGER CHECK (semester BETWEEN 1 AND 8),
    teacher_id INTEGER REFERENCES teacher(teacher_id),
    department_id INTEGER REFERENCES department(department_id)
);

-- Таблиця реєстрацій (many-to-many)
CREATE TABLE registration (
    registration_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES student(student_id),
    course_id INTEGER REFERENCES course(course_id),
    registration_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'active',
    grade VARCHAR(5),
    UNIQUE(student_id, course_id)
);
