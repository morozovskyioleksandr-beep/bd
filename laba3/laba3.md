# Лабораторна робота №3

**Тема: Маніпулювання даними SQL (OLTP)**

***Виконав студент групи ІО-44, Морозовський Олександр.***

---
## Опис роботи
У цій лабораторній роботі я протестував базу даних системи реєстрації студентів на курси, створену в попередніх лабораторних роботах. Для цього
були виконані  SQL-запити в стилі OLTP, які імітують типові операції користувача: перегляд даних(select), додавання нового запису(insert), оновлення 
існуючих даних(update) та видалення запису(delete).

## Виконані запити

### 1. SELECT-запити
Було виконано запити для перегляду списку студентів, курсів та реєстрацій. Також було використано фільтрацію та з’єднання таблиць для отримання 
інформації про те, які студенти зареєстровані на які курси.
```sql
SELECT * FROM student;
```
Рехультат: 
<img width="1859" height="323" alt="image" src="https://github.com/user-attachments/assets/52eb1adb-147b-4eed-a1d9-2602079e3fac" />

```sql
SELECT * FROM course;
```
Результат:
<img width="1879" height="240" alt="image" src="https://github.com/user-attachments/assets/8d08e969-d79c-4bbd-bcf7-1bf74a131fd7" />

```sql
SELECT * FROM registration;
```
<img width="1860" height="384" alt="image" src="https://github.com/user-attachments/assets/b74ad6c8-115a-415a-8938-cc785ccd0d1f" />

```sql
SELECT first_name, last_name, email
FROM student;
```
<img width="1332" height="259" alt="image" src="https://github.com/user-attachments/assets/ab74d1bc-42b9-4a63-b286-6aa0c428986b" />

```sql
SELECT student_id, first_name, last_name, enrollment_year
FROM student
WHERE enrollment_year > 2020;
```
Результат:
<img width="1858" height="181" alt="image" src="https://github.com/user-attachments/assets/f65e8249-3cc0-4a11-8f95-6f0eafc6ab23" />

```sql
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
```
Результат:
<img width="1839" height="388" alt="image" src="https://github.com/user-attachments/assets/253a146f-49a1-422b-85a8-c19e293f82d4" />

### 2. INSERT-запит
Було додано нового студента до таблиці `student`, а також новий запис про його реєстрацію на курс у таблиці `registration`.
```sql
INSERT INTO student (last_name, first_name, birth_date, email, phone, enrollment_year)
VALUES ('Ткаченко', 'Марія', '2003-11-12', 'maria.tkachenko@gmail.com', '+380681234567', 2021);
```
Результат: 
<img width="2447" height="275" alt="image" src="https://github.com/user-attachments/assets/f8ccff01-bac2-4bcf-8e8b-af54b11c703f" />

```sql
INSERT INTO registration (student_id, course_id, status, grade)
VALUES (
    (SELECT student_id FROM student WHERE email = 'maria.tkachenko@gmail.com'),
    1,
    'активна',
    NULL
);
```
Результат: 
<img width="2202" height="415" alt="image" src="https://github.com/user-attachments/assets/bab0594f-2a48-451d-8d86-56952379f15b" />

### 3. UPDATE-запит
Було змінено номер телефону одного зі студентів та оновлено статус реєстрації в таблиці `registration`.
```sql
UPDATE student
SET phone = '+380991112233'
WHERE email = 'maria.tkachenko@gmail.com';
```
Результат: 
<img width="2516" height="137" alt="image" src="https://github.com/user-attachments/assets/3f08cdb2-08ba-48b0-bc78-e705e0ca3c3d" />

```sql
UPDATE registration
SET status = 'завершена',
    grade = 'B'
WHERE student_id = (SELECT student_id FROM student WHERE email = 'maria.tkachenko@gmail.com')
  AND course_id = 1;
```
Результат: 
<img width="1945" height="129" alt="image" src="https://github.com/user-attachments/assets/6dd2155d-0e4e-4a7d-8841-70cc85609c43" />

### 4. DELETE-запит
Було видалено один запис про реєстрацію студента на курс. Видалення виконувалося з використанням `WHERE`, щоб уникнути втрати всіх даних таблиці.

```sql
DELETE FROM registration
WHERE student_id = (SELECT student_id FROM student WHERE email = 'maria.tkachenko@gmail.com')
  AND course_id = 1;
```
Результат: 
<img width="2213" height="353" alt="image" src="https://github.com/user-attachments/assets/0d360d88-9f6d-446e-89b1-5241b39b804f" />

## Результати
Усі SQL-запити були успішно виконані в PostgreSQL. Було перевірено, що:
- SELECT-запити повертають коректні дані;
- INSERT додає нові записи;
- UPDATE змінює лише потрібні рядки;
- DELETE видаляє лише вказаний запис.

SQL-код усіх запитів наведений в окремому файлі `lab3.sql`.

## Висновок
У ході виконання лабораторної роботи було освоєно базові операції DML у PostgreSQL: вибірка, вставка, оновлення та видалення даних. Практичне
виконання цих операцій підтвердило коректність створеної раніше структури бази даних та її придатність до транзакційної обробки даних.
