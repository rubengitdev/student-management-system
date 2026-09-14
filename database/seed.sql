-- =================================================================
-- Student Management System
-- DEMO DATA
-- =================================================================

-- Seed departments
INSERT INTO departments (code, name, description) VALUES
('CS', 'Computer Science', 'Focus on algorithms, software engineering, and artificial intelligence.'),
('EE', 'Electrical Engineering', 'Study of electronics, power systems, and signal processing.'),
('ME', 'Mechanical Engineering', 'Principles of physics and materials for analysis and design of mechanical systems.'),
('BA', 'Business Administration', 'Leadership, finance, marketing, and strategic organizational management.'),
('MATH', 'Mathematics & Statistics', 'Pure and applied mathematics, data science, and analytical modeling.')
ON CONFLICT (code) DO NOTHING;

-- Seed courses
INSERT INTO courses (course_code, name, description, credits, department_id) VALUES
('CS101', 'Introduction to Programming', 'Fundamental concepts of programming and problem solving.', 3, 1),
('CS201', 'Data Structures & Algorithms', 'In-depth study of abstract data types and algorithm design.', 4, 1),
('CS301', 'Database Systems', 'Relational database theory, SQL, indexing, and normalization.', 3, 1),
('EE101', 'Circuit Analysis I', 'Basic DC and AC circuits, Kirchhoff laws, and network theorems.', 4, 2),
('EE205', 'Digital Logic Design', 'Boolean algebra, combinational circuits, and sequential systems.', 3, 2),
('ME101', 'Engineering Mechanics', 'Static equilibrium of structures, particles, and rigid bodies.', 3, 3),
('BA101', 'Principles of Management', 'Organizational behavior, planning, decision-making, and ethics.', 3, 4),
('MATH201', 'Linear Algebra & Calculus', 'Vector spaces, matrices, eigenvalues, and multivariable calculus.', 4, 5)
ON CONFLICT (course_code) DO NOTHING;

-- Seed student
INSERT INTO students (student_number, first_name, last_name, email, phone, date_of_birth, gender, address, department_id, enrollment_year, status) VALUES
('STU-0001', 'John', 'Doe', 'john.doe@university.edu', '+1-555-0101', '2002-04-15', 'male', '124 University Ave, Seattle, WA', 1, 2024, 'active'),
('STU-0002', 'Sarah', 'Jenkins', 'sarah.jenkins@university.edu', '+1-555-0102', '2003-01-22', 'female', '88 Maple Street, Boston, MA', 1, 2025, 'active'),
('STU-0003', 'Alex', 'Chen', 'alex.chen@university.edu', '+1-555-0103', '2001-09-10', 'male', '45 Oak Ridge Rd, Austin, TX', 2, 2023, 'active'),
('STU-0004', 'Maria', 'Garcia', 'maria.garcia@university.edu', '+1-555-0104', '2002-11-05', 'female', '320 Highland Blvd, Denver, CO', 4, 2024, 'active'),
('STU-0005', 'David', 'Kim', 'david.kim@university.edu', '+1-555-0105', '2000-08-30', 'male', '512 Pinecrest Dr, San Jose, CA', 1, 2022, 'graduated'),
('STU-0006', 'Emily', 'Taylor', 'emily.taylor@university.edu', '+1-555-0106', '2003-06-18', 'female', '204 Sunset View, Portland, OR', 3, 2025, 'active'),
('STU-0007', 'Michael', 'Brown', 'michael.brown@university.edu', '+1-555-0107', '2001-03-25', 'male', '670 Cedar Way, Chicago, IL', 5, 2023, 'inactive'),
('STU-0008', 'Jessica', 'Miller', 'jessica.miller@university.edu', '+1-555-0108', '2003-12-14', 'female', '819 Birch Court, Minneapolis, MN', 4, 2025, 'active')
ON CONFLICT (student_number) DO NOTHING;

-- Seed course enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date, status) VALUES
(1, 1, '2024-09-01', 'completed'),
(1, 2, '2025-01-15', 'enrolled'),
(1, 3, '2025-01-15', 'enrolled'),
(2, 1, '2025-09-01', 'enrolled'),
(2, 8, '2025-09-01', 'enrolled'),
(3, 4, '2023-09-01', 'completed'),
(3, 5, '2024-01-15', 'enrolled'),
(4, 7, '2024-09-01', 'completed'),
(5, 1, '2022-09-01', 'completed'),
(5, 2, '2023-01-15', 'completed'),
(5, 3, '2023-09-01', 'completed'),
(6, 6, '2025-09-01', 'enrolled'),
(8, 7, '2025-09-01', 'enrolled')
ON CONFLICT (student_id, course_id) DO NOTHING;
