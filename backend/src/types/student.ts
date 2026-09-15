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
    enrollment_year: number;
    status: 'active' | 'inactive' | 'graduated';
    created_at: Date;
    updated_at: Date;
}

export interface CreateStudentInput {
    student_number: string;
    first_name: string;
    last_name: string;
    email: string;
    phone?: string;
    date_of_birth?: string;
    gender?: string;
    address?: string;
    department_id: number;
    enrollment_year: number;
    status?: 'active' | 'inactive' | 'graduated';
}
