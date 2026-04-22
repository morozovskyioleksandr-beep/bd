-- 1. COUNT: кількість студентів
SELECT COUNT(*) AS total_students
FROM student;

-- 2. AVG: середній рік вступу
SELECT AVG(enrollment_year) AS avg_year
FROM student;

-- 3. MIN / MAX кредити
SELECT MIN(credits) AS min_credits,
       MAX(credits) AS max_credits
FROM course;

-- 4. GROUP BY: кількість студентів по роках вступу
SELECT enrollment_year, COUNT(*) AS students_count
FROM student
GROUP BY enrollment_year;

-- 5. GROUP BY + HAVING: курси з більш ніж 1 студентом
SELECT course_id, COUNT(*) AS total_students
FROM registration
GROUP BY course_id
HAVING COUNT(*) > 1;

-- 6. INNER JOIN: студент + курс
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM registration r
JOIN student s ON r.student_id = s.student_id
JOIN course c ON r.course_id = c.course_id;

-- 7. LEFT JOIN: всі студенти навіть без курсів
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM student s
LEFT JOIN registration r ON s.student_id = r.student_id
LEFT JOIN course c ON r.course_id = c.course_id;

-- 8. JOIN + GROUP BY: кількість курсів у викладача
SELECT
    t.first_name,
    t.last_name,
    COUNT(c.course_id) AS course_count
FROM teacher t
LEFT JOIN course c ON t.teacher_id = c.teacher_id
GROUP BY t.teacher_id;

-- 9. ПІДЗАПИТ (WHERE): студенти з 2021 року і пізніше
SELECT first_name, last_name
FROM student
WHERE enrollment_year >= (
    SELECT AVG(enrollment_year)
    FROM student
);

-- 10. ПІДЗАПИТ (SELECT): кількість курсів у кожного студента
SELECT
    s.first_name,
    s.last_name,
    (SELECT COUNT(*)
     FROM registration r
     WHERE r.student_id = s.student_id) AS course_count
FROM student s;

-- 11. ПІДЗАПИТ (HAVING): курси з максимальною кількістю студентів
SELECT course_id, COUNT(*) AS total
FROM registration
GROUP BY course_id
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM registration
        GROUP BY course_id
    ) sub
);

SELECT *FROM student;
