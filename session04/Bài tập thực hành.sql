-- ===============================
-- PHẦN I: TẠO CSDL & BẢNG
-- ===============================

CREATE DATABASE online_learning;
USE online_learning;

CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE teacher (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    total_sessions INT,
    teacher_id INT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);

CREATE TABLE enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enroll_date DATE NOT NULL,
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE score (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    mid_score DECIMAL(3,1) CHECK (mid_score >= 0 AND mid_score <= 10),
    final_score DECIMAL(3,1) CHECK (final_score >= 0 AND final_score <= 10),
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

-- ===============================
-- PHẦN II: NHẬP DỮ LIỆU
-- ===============================

INSERT INTO student (full_name, date_of_birth, email) VALUES
('Nguyen Van A', '2004-01-10', 'a@student.edu.vn'),
('Tran Thi B', '2004-03-15', 'b@student.edu.vn'),
('Le Van C', '2003-12-20', 'c@student.edu.vn'),
('Pham Thi D', '2004-07-05', 'd@student.edu.vn'),
('Hoang Van E', '2003-09-30', 'e@student.edu.vn');

INSERT INTO teacher (full_name, email) VALUES
('Dr. Nguyen Tuan', 'tuan@edu.vn'),
('Dr. Tran Minh', 'minh@edu.vn'),
('Dr. Le Hoa', 'hoa@edu.vn'),
('Dr. Pham Long', 'long@edu.vn'),
('Dr. Vo Anh', 'anh@edu.vn');

INSERT INTO course (course_name, description, total_sessions, teacher_id) VALUES
('Lap trinh C', 'Co ban ngon ngu C', 30, 1),
('Lap trinh Java', 'Huong doi tuong Java', 45, 2),
('Co so du lieu', 'MySQL va thiet ke CSDL', 40, 3),
('Mang may tinh', 'Kien thuc mang can ban', 35, 4),
('Lap trinh Web', 'HTML CSS JS', 50, 5);

INSERT INTO enrollment (student_id, course_id, enroll_date) VALUES
(1, 1, '2025-01-10'),
(1, 2, '2025-01-12'),
(2, 3, '2025-01-15'),
(3, 1, '2025-01-18'),
(4, 4, '2025-01-20');

INSERT INTO score (student_id, course_id, mid_score, final_score) VALUES
(1, 1, 7.5, 8.0),
(1, 2, 6.5, 7.0),
(2, 3, 8.0, 8.5),
(3, 1, 5.5, 6.0),
(4, 4, 9.0, 9.5);

-- ===============================
-- PHẦN III: CẬP NHẬT
-- ===============================

UPDATE student
SET email = 'newemail@student.edu.vn'
WHERE student_id = 1;

UPDATE course
SET description = 'Lap trinh Java tu co ban den nang cao'
WHERE course_id = 2;

UPDATE score
SET final_score = 9.0
WHERE student_id = 1 AND course_id = 1;

-- ===============================
-- PHẦN IV: XÓA DỮ LIỆU
-- ===============================

DELETE FROM enrollment
WHERE student_id = 3 AND course_id = 1;

DELETE FROM score
WHERE student_id = 3 AND course_id = 1;

-- ===============================
-- PHẦN V: TRUY VẤN
-- ===============================

SELECT * FROM student;

SELECT * FROM teacher;

SELECT * FROM course;

SELECT * FROM enrollment;

SELECT * FROM score;
