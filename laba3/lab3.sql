-- 1. SELECT: перегляд усіх студентів
SELECT * FROM student;

-- 2. SELECT: перегляд усіх курсів
SELECT * FROM course;

-- 3. SELECT: перегляд усіх реєстрацій
SELECT * FROM registration;

-- 4. SELECT: вибір імені, прізвища та пошти студентів
SELECT first_name, last_name, email
FROM student;

-- 5. SELECT з WHERE: студенти, які вступили після 2020 року
SELECT student_id, first_name, last_name, enrollment_year
FROM student
WHERE enrollment_year > 2020;

-- 6. SELECT з JOIN: які студенти записані на які курси
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    r.status,
    r.grade
FROM registration r
JOIN student s ON r.student_id = s.student_id
JOIN course c ON r.course_id = c.course_id;

-- 7. INSERT: додавання нового студента
INSERT INTO student (last_name, first_name, birth_date, email, phone, enrollment_year)
VALUES ('Ткаченко', 'Марія', '2003-11-12', 'maria.tkachenko@gmail.com', '+380681234567', 2021);

-- 8. Перевірка, чи студент додався
SELECT * FROM student
WHERE email = 'maria.tkachenko@gmail.com';

-- 9. INSERT: реєстрація нового студента на курс
INSERT INTO registration (student_id, course_id, status, grade)
VALUES (
    (SELECT student_id FROM student WHERE email = 'maria.tkachenko@gmail.com'),
    1,
    'активна',
    NULL
);

-- 10. Перевірка реєстрації
SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    r.status
FROM registration r
JOIN student s ON r.student_id = s.student_id
JOIN course c ON r.course_id = c.course_id
WHERE s.email = 'maria.tkachenko@gmail.com';

-- 11. UPDATE: оновлення номера телефону студента
UPDATE student
SET phone = '+380991112233'
WHERE email = 'maria.tkachenko@gmail.com';

-- 12. Перевірка UPDATE
SELECT * FROM student
WHERE email = 'maria.tkachenko@gmail.com';

-- 13. UPDATE: зміна статусу реєстрації
UPDATE registration
SET status = 'завершена',
    grade = 'B'
WHERE student_id = (SELECT student_id FROM student WHERE email = 'maria.tkachenko@gmail.com')
  AND course_id = 1;

-- 14. Перевірка зміни статусу
SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    r.status,
    r.grade
FROM registration r
JOIN student s ON r.student_id = s.student_id
JOIN course c ON r.course_id = c.course_id
WHERE s.email = 'maria.tkachenko@gmail.com';

-- 15. DELETE: видалення реєстрації студента на курс
DELETE FROM registration
WHERE student_id = (SELECT student_id FROM student WHERE email = 'maria.tkachenko@gmail.com')
  AND course_id = 1;

-- 16. Перевірка DELETE
SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    r.status
FROM registration r
JOIN student s ON r.student_id = s.student_id
JOIN course c ON r.course_id = c.course_id
WHERE s.email = 'maria.tkachenko@gmail.com';

