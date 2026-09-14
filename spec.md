# Student Management System Project Specification

## Project Overview

Project name: Student Management System

Project type: Full-stack CRUD web application for managing students, departments, courses, and enrollments.

Main objective:

- Build a realistic application that demonstrates your ability to:
- Design a relational database
- Build a REST API
- Connect React to a backend
- Perform CRUD operations
- Validate user input
- Handle loading and error states
- Manage relational data
- Write tests
- Structure a maintainable full-stack project

Tech Stack:

- Frontend: React + Typescript + Tailwind CSS
- Backend: Node.js + Express + Typescript
- PostgreSQL
- pg
- Fetch API

## User Role

### Admin

The Administrator can:

- View students
- Create students
- Edit students
- Delete students
- View student details
- Manage departments
- Manage courses
- Enroll students in courses
- View dashboard statistics

## Main Features

MVP features

Student management:

- View all students
- Search students
- Filter students
- View student details
- Create a student
- Edit a student
- Delete a student
- Validate student data
- Display success and error messages

Department management

- View departments
- Create departments
- Edit departments
- Delete departments
- Assign students to departments
- Course management
- View courses
- Create courses
- Edit courses
- Delete courses
- Assign courses to departments

Enrollment management

- Enroll a student in a course
- View a student's courses
- View course enrollments
- Remove a student from a course
- Prevent duplicate enrollments

Dashboard
Display:

- Total students
- Total departments
- Total courses
- Total enrollments
- Recently added students
- Students grouped by department

## Application Pages

### Dashboard

Route: /dashboard

Components:

- Statistics cards
- Recent students table
- Department summary
- Enrollment summary
- Quick action buttons

### Student Page

Route: /students

Features:

- Student table
- Search input
- Department filter
- Status filter
- Add student button
- View details button
- Edit button
- Delete button
- Pagination

### Add Student Page

Route: /students/new

Form fields:

- First name
- Last name
- Email
- Phone number
- Date of birth
- Gender — optional
- Address — optional
- Department
- Enrollment year
- Status

Validation rules:

- First name is required
- Last name is required
- Email is required
- Email must be valid
- Email must be unique
- Department is required
- Enrollment year must be reasonable
- Status must be one of the allowed values
- Phone number must use a valid format if provided

### Student details page

Route: /students/:id

Display:

- Student profile
- Student ID
- Full name
- Email
- Phone
- Date of birth
- Department
- Enrollment year
- Status
- Enrolled courses
- Created date
- Updated date

Actions:

- Edit student
- Delete student
- Enroll in course
- Remove course enrollment

### Edit Student page

Route: /students/:id/edit

The form is similar to create form, but fields are pre-filled with existing student data.

### Departments page

Route: /departments

Features:

- View departments
- Add department
- Edit department
- Delete department
- View students in a department

Department fields:

- Department code
- Department name
- Description

### Courses page

Route: /courses

Features:

- View courses
- Add course
- Edit course
- Delete course
- Filter by department
- View enrolled students

Course fields:

- Course code
- Course name
- Description
- Credits
- Department

### Enrollments page

Route: /enrollments

Features:

- View all enrollments
- Filter by student
- Filter by course
- Enroll a student
- Remove enrollment
- Display enrollment date
- Display enrollment status

Enrollment fields:

- Student
- Course
- Enrollment date
- Status

## Database Design

Main tables:

- departments
- students
- courses
- enrollments

### Departments table

```
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

Fields:

| Field       | Type         | Rules            |
| ----------- | ------------ | ---------------- |
| id          | SERIAL       | Primary Key      |
| code        | VARCHAR(20)  | Required, unique |
| name        | VARCHAR(100) | Required, unique |
| description | TEXT         | Optional         |
| created_at  | TIMESTAMP    | Automatic        |
| updated_at  | TIMESTAMP    | Automatic        |

### Students table

```
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    student_number VARCHAR(30) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(30),
    date_of_birth DATE,
    gender VARCHAR(20),
    address TEXT,
    department_id INTEGER NOT NULL
        REFERENCES departments(id)
        ON DELETE RESTRICT,
    enrollment_year INTEGER NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT students_status_check
        CHECK (status IN ('active', 'inactive', 'graduated')),

    CONSTRAINT students_enrollment_year_check
        CHECK (enrollment_year >= 2000)
);
```

Fields:

| Field           | Description               |
| --------------- | ------------------------- |
| id              | Internal database id      |
| student_number  | Public student identifier |
| first_name      | Student's first name      |
| last_name       | Student's last name       |
| email           | Unique email              |
| phone           | Optional phone            |
| date_of_birth   | Optional birth date       |
| gender          | Optional gender           |
| address         | Optional address          |
| department_id   | Foreign key               |
| enrollment_year | Year joined               |
| status          | Student status            |
| created_at      | TIMESTAMP                 |
| updated_at      | TIMESTAMP                 |

### Course table

```
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_code VARCHAR(30) NOT NULL UNIQUE,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    credits INTEGER NOT NULL,
    department_id INTEGER NOT NULL
        REFERENCES departments(id)
        ON DELETE RESTRICT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT courses_credits_check
        CHECK (credits BETWEEN 1 AND 10)
);

```

### Enrollments table

```
CREATE TABLE enrollments (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL
        REFERENCES students(id)
        ON DELETE CASCADE,
    course_id INTEGER NOT NULL
        REFERENCES courses(id)
        ON DELETE CASCADE,
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'enrolled',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT enrollments_status_check
        CHECK (status IN ('enrolled', 'completed', 'dropped')),

    CONSTRAINT unique_student_course
        UNIQUE (student_id, course_id)
);
```

## Database Relationships

```
Department
   |
   | 1-to-many
   |
Students
   |
   | many-to-many through enrollments
   |
Courses
   |
   | many-to-one
   |
Department
```

## REST API Specification

Base URL: /api

### Student endpoints

#### Get all students

GET /api/students

#### Query parameters

/api/students?page=1&limit=10
/api/students?search=john
/api/students?departmentId=2
/api/students?status=active

Example response:

```
{
  "data": [
    {
      "id": 1,
      "student_number": "STU-0001",
      "first_name": "John",
      "last_name": "Doe",
      "email": "john@example.com",
      "department_id": 1,
      "department_name": "Computer Science",
      "enrollment_year": 2026,
      "status": "active"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 1,
    "totalPages": 1
  }
}
```

#### Get one student

GET /api/students/:id

#### Create student

POST /api/students

Request Body:

```
{
  "first_name": "John",
  "last_name": "Doe",
  "email": "john@example.com",
  "phone": "+628123456789",
  "date_of_birth": "2002-04-15",
  "gender": "male",
  "address": "Semarang, Indonesia",
  "department_id": 1,
  "enrollment_year": 2026,
  "status": "active"
}
```

The backend should generate the student number

#### Update student

PATCH /api/students/:id

Request Body:

```
{
  "first_name": "Jonathan",
  "status": "active"
}
```

#### Delete student

DELETE /api/students/:id

Successfull response:

```
{
  "message": "Student deleted successfully"
}
```

### Department endpoints

GET /api/departments
GET /api/departments/:id
POST /api/departments
PATCH /api/departments/:id
DELETE /api/departments/:id

#### Create department request

```
{
  "code": "CS",
  "name": "Computer Science",
  "description": "Department of computer science"
}
```

### Course endpoints

GET /api/courses
GET /api/courses/:id
POST /api/courses
PATCH /api/courses/:id
DELETE /api/courses/:id

#### Create course request

```
{
  "course_code": "CS101",
  "name": "Introduction to Programming",
  "description": "Basic programming concepts",
  "credits": 3,
  "department_id": 1
}
```

### Enrollment endpoints

GET /api/enrollments
GET /api/enrollments/:id
POST /api/enrollments
PATCH /api/enrollments/:id
DELETE /api/enrollments/:id

#### Create enrollment request

```
{
  "student_id": 1,
  "course_id": 1
}
```

#### Update enrollment status

```
{
  "status": "completed"
}
```

### Dashboard endpoints

GET /api/dashboard/statistics
GET /api/dashboard/recent-students
GET /api/dashboard/students-by-department

#### Example statistics response

```
{
  "totalStudents": 120,
  "totalDepartments": 6,
  "totalCourses": 24,
  "totalEnrollments": 480
}
```

## HTTP Status Codes

| Status | Usage                                    |
| ------ | ---------------------------------------- |
| 200    | Successfull GET, PATCH                   |
| 201    | Successfull POST                         |
| 204    | Successfull DELETE with no response body |
| 400    | Invalid request                          |
| 400    | Resource not found                       |
| 409    | Duplicate or conflicting data            |
| 422    | Validation error                         |
| 500    | Unexpected server error                  |

Example:

```
{
  "error": {
    "code": "STUDENT_EMAIL_EXISTS",
    "message": "A student with this email already exists"
  }
}
```

## Backend Folder Structure

```
server/
├── src/
│   ├── config/
│   │   ├── database.ts
│   │   └── env.ts
│   │
│   ├── controllers/
│   │   ├── student.controller.ts
│   │   ├── department.controller.ts
│   │   ├── course.controller.ts
│   │   ├── enrollment.controller.ts
│   │   └── dashboard.controller.ts
│   │
│   ├── routes/
│   │   ├── student.routes.ts
│   │   ├── department.routes.ts
│   │   ├── course.routes.ts
│   │   ├── enrollment.routes.ts
│   │   └── dashboard.routes.ts
│   │
│   ├── services/
│   │   ├── student.service.ts
│   │   ├── department.service.ts
│   │   ├── course.service.ts
│   │   ├── enrollment.service.ts
│   │   └── dashboard.service.ts
│   │
│   ├── repositories/
│   │   ├── student.repository.ts
│   │   ├── department.repository.ts
│   │   ├── course.repository.ts
│   │   └── enrollment.repository.ts
│   │
│   ├── middleware/
│   │   ├── error.middleware.ts
│   │   ├── not-found.middleware.ts
│   │   └── validation.middleware.ts
│   │
│   ├── validators/
│   │   ├── student.validator.ts
│   │   ├── department.validator.ts
│   │   ├── course.validator.ts
│   │   └── enrollment.validator.ts
│   │
│   ├── types/
│   │   └── index.ts
│   │
│   ├── app.ts
│   └── server.ts
│
├── tests/
├── migrations/
├── seeds/
├── .env
├── .env.example
├── package.json
└── tsconfig.json
```

## Frontend Folder Structure

```
client/
├── src/
│   ├── assets/
│   │
│   ├── components/
│   │   ├── layout/
│   │   │   ├── Navbar.tsx
│   │   │   ├── Sidebar.tsx
│   │   │   └── PageHeader.tsx
│   │   │
│   │   ├── students/
│   │   │   ├── StudentTable.tsx
│   │   │   ├── StudentForm.tsx
│   │   │   ├── StudentCard.tsx
│   │   │   └── StudentFilters.tsx
│   │   │
│   │   ├── departments/
│   │   ├── courses/
│   │   ├── enrollments/
│   │   └── common/
│   │       ├── Button.tsx
│   │       ├── Input.tsx
│   │       ├── Select.tsx
│   │       ├── Modal.tsx
│   │       ├── Spinner.tsx
│   │       └── ErrorMessage.tsx
│   │
│   ├── pages/
│   │   ├── Dashboard.tsx
│   │   ├── Students.tsx
│   │   ├── CreateStudent.tsx
│   │   ├── EditStudent.tsx
│   │   ├── StudentDetails.tsx
│   │   ├── Departments.tsx
│   │   ├── Courses.tsx
│   │   └── Enrollments.tsx
│   │
│   ├── services/
│   │   ├── api.ts
│   │   ├── studentApi.ts
│   │   ├── departmentApi.ts
│   │   ├── courseApi.ts
│   │   └── enrollmentApi.ts
│   │
│   ├── hooks/
│   │   ├── useStudents.ts
│   │   ├── useDepartments.ts
│   │   └── useCourses.ts
│   │
│   ├── types/
│   │   ├── student.ts
│   │   ├── department.ts
│   │   ├── course.ts
│   │   └── enrollment.ts
│   │
│   ├── routes/
│   │   └── AppRoutes.tsx
│   │
│   ├── App.tsx
│   ├── main.tsx
│   └── index.css
│
├── package.json
└── vite.config.ts
```

## Frontend TypeScript Types

### Student type

```
export type StudentStatus = "active" | "inactive" | "graduated";

export interface Student {
    id: number;
    student_number: string;
    first_name: string;
    last_name: string;
    email: string;
    phone: string | null;
    date_of_birth: string | null;
    gender: string | null;
    address: string | null;
    department_id: number;
    department_name?: string;
    enrollment_year: number;
    status: StudentStatus;
    created_at: string;
    updated_at: string;
}
```

### Department type

```
export interface Department {
    id: number;
    code: string;
    name: string;
    description: string | null;
    created_at: string;
    updated_at: string;
}
```

### Course type

```
export interface Course {
    id: number;
    course_code: string;
    name: string;
    description: string | null;
    credits: number;
    department_id: number;
    department_name?: string;
    created_at: string;
    updated_at: string;
}
```

### Enrollment type

```
export type EnrollmentStatus =
    | "enrolled"
    | "completed"
    | "dropped";

export interface Enrollment {
    id: number;
    student_id: number;
    course_id: number;
    student_name?: string;
    course_name?: string;
    enrollment_date: string;
    status: EnrollmentStatus;
    created_at: string;
}
```
