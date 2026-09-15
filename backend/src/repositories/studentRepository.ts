import pool from '../config/database.js';
import type { Student } from '../types/student.ts';

export async function getAllStudents(): Promise<Student[]> {
    const result = await pool.query<Student>(
        'SELECT * FROM students ORDER BY id',
    );

    // return table rows
    return result.rows;
}

// Test Query
// async function test() {
//     const students = await getAllStudents();
//     console.log(students);
// }
//
// test();
