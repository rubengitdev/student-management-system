-- =================================================================
-- Student Management System
-- Database Schema
-- =================================================================

-- Departments Table
CREATE TABLE IF NOT EXISTS departments (
    id SERIAL PRIMARY KEY,
    code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Students Table
CREATE TABLE IF NOT EXISTS students (
    id SERIAL PRIMARY KEY,
    student_number VARCHAR(30) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(30),
    date_of_birth DATE,
    gender VARCHAR(20),
    address TEXT,
    department_id INTEGER NOT NULL REFERENCES departments(id) ON DELETE RESTRICT,
    enrollment_year INTEGER NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT students_status_check CHECK (status IN ('active', 'inactive', 'graduated')),
    CONSTRAINT students_enrollment_year_check CHECK (enrollment_year BETWEEN 2000 AND 2100)
);

-- Courses Table
CREATE TABLE IF NOT EXISTS courses (
    id SERIAL PRIMARY KEY,
    course_code VARCHAR(30) NOT NULL UNIQUE,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    credits INTEGER NOT NULL,
    department_id INTEGER NOT NULL REFERENCES departments(id) ON DELETE RESTRICT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT courses_credits_check CHECK (credits BETWEEN 1 AND 10)
);

-- Enrollments Table (Many-to-Many junction between Students and Courses)
CREATE TABLE IF NOT EXISTS enrollments (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    course_id INTEGER NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'enrolled',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT enrollments_status_check CHECK (status IN ('enrolled', 'completed', 'dropped')),
    CONSTRAINT unique_student_course UNIQUE (student_id, course_id)
);


-- =================================================================
-- CREATING INDEXES FOR FOREIGN KEY COLUMNS
-- =================================================================

CREATE INDEX IF NOT EXISTS idx_students_department_id
ON students(department_id)

CREATE INDEX IF NOT EXISTS idx_courses_department_id
ON courses(department_id)

CREATE INDEX IF NOT EXISTS idx_enrollments_student_id
ON enrollments(student_id)

CREATE INDEX IF NOT EXISTS idx_enrollments_course_id
ON enrollments(course_id)


