# Лабораторна робота №4

**Тема: Аналітичні SQL-запити (OLAP)**

***Виконав студент групи ІО-44, Морозовський Олександр.***

---
## Опис роботи
У лабораторній роботі були виконані аналітичні запити до бази даних системи реєстрації студентів. Запити дозволяють отримувати узагальнену
інформацію, статистику та звіти.

## Виконані запити

### 1. Агрегація
Було виконано запити з використанням COUNT, AVG, MIN, MAX для отримання статистики по таблицях.
```sql
SELECT COUNT(*) AS total_students
FROM student;
```
Результат:
<img width="494" height="138" alt="image" src="https://github.com/user-attachments/assets/3e29ba05-2925-4041-bc12-9da8346fd451" />

```sql
SELECT AVG(enrollment_year) AS avg_year
FROM student;
```
Результат:
<img width="409" height="133" alt="image" src="https://github.com/user-attachments/assets/a5a5c8c4-0750-4f44-9072-0824efd5b59f" />

```sql
SELECT MIN(credits) AS min_credits,
       MAX(credits) AS max_credits
FROM course;
```
Результат:
<img width="936" height="149" alt="image" src="https://github.com/user-attachments/assets/d25432f0-183d-420d-a3f4-2e6f00172c28" />

### 2. GROUP BY
Використано групування для підрахунку кількості студентів за роками вступу
```sql
SELECT enrollment_year, COUNT(*) AS students_count
FROM student
GROUP BY enrollment_year;
```
Результат:
<img width="1064" height="250" alt="image" src="https://github.com/user-attachments/assets/f6ecd233-1e40-4c0c-a0a5-8bc8fd970b5a" />

### 3. HAVING
Застосовано фільтрацію агрегованих результатів для вибору курсів з найбільшою кількістю студентів.
```sql
SELECT course_id, COUNT(*) AS total_students
FROM registration
GROUP BY course_id
HAVING COUNT(*) > 1;
```
Результат:
<img width="935" height="193" alt="image" src="https://github.com/user-attachments/assets/ca8180b4-16d3-461f-b75c-c96fd0acddb1" />
### 4. JOIN
Було використано INNER JOIN та LEFT JOIN для об’єднання таблиць та отримання повної інформації про студентів і курси.
```sql
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM registration r
JOIN student s ON r.student_id = s.student_id
JOIN course c ON r.course_id = c.course_id;
```
Результат:
<img width="1292" height="352" alt="image" src="https://github.com/user-attachments/assets/f24bbd86-1b5e-466d-bd01-63ece915ae2c" />

```sql
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM student s
LEFT JOIN registration r ON s.student_id = r.student_id
LEFT JOIN course c ON r.course_id = c.course_id;
```
Результат:
<img width="1262" height="393" alt="image" src="https://github.com/user-attachments/assets/73405d3e-d21f-4a52-b414-f2464e8c23b3" />

### 5. Підзапити
Реалізовано підзапити у WHERE, SELECT та HAVING для отримання складних аналітичних результатів.
```sql
SELECT first_name, last_name
FROM student
WHERE enrollment_year >= (
    SELECT AVG(enrollment_year)
    FROM student
);
```
Результат: 
<img width="910" height="253" alt="image" src="https://github.com/user-attachments/assets/219b5887-4c84-4a15-a515-9f3fdacbaa13" />

```sql
SELECT
    s.first_name,
    s.last_name,
    (SELECT COUNT(*)
     FROM registration r
     WHERE r.student_id = s.student_id) AS course_count
FROM student s;
```
Результат: 
<img width="1325" height="296" alt="image" src="https://github.com/user-attachments/assets/97da8bc1-3721-4f49-94f6-22e27ea817a0" />

```sql
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
```
Результат: 
<img width="768" height="181" alt="image" src="https://github.com/user-attachments/assets/940f7c5b-a906-4bb0-869a-07af6abd4ff6" />

## Результати
Усі запити були успішно виконані в PostgreSQL та повернули коректні результати.

SQL-код запитів наведений у файлі `lab4.sql`.

## Висновок
У ході лабораторної роботи мною було освоєно створення аналітичних запитів у PostgreSQL. Було використано агрегатні функції, групування, об’єднання 
таблиць та підзапити для отримання зведеної інформації з бази даних.
