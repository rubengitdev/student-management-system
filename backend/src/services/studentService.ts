import { getAllStudents } from '../repositories/studentRepository.js';
import type { Student } from '../types/student.js';

export async function getStudents(): Promise<Student[]> {
    return getAllStudents();
}

// Test
async function test() {
    const students = await getStudents();
    console.log(students);
}

test();
