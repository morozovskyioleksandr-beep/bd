# Лабораторна робота №2

**Тема: Перетворення ER-діаграми на схему PostgreSQL**

***Виконав студент групи ІО-44, Морозовський Олександр.***

---

*Основні зв’язки в системі:*

- одна кафедра може мати багато викладачів;
  
- одна кафедра може забезпечувати багато курсів;
  
- один викладач може викладати багато курсів;
  
- один студент може бути зареєстрований на багато курсів;
  
- один курс може мати багато студентів.

Зв’язок багато-до-багатьох між студентами та курсами реалізовано через таблицю `registration`.

## Опис таблиць
### Таблиця `department`

Містить інформацію про кафедри.

- `department_id` — первинний ключ;
  
- `department_name` — назва кафедри;
  
- `faculty_name` — назва факультету;
  
- `office_number` — номер аудиторії або кабінету.

### Таблиця `teacher`

Містить інформацію про викладачів.
- `teacher_id` — первинний ключ;
  
- `last_name` — прізвище;
  
- `first_name` — ім’я;
  
- `email` — електронна пошта;
  
- `phone` — номер телефону;
  
- `position` — посада;
  
- `department_id` — зовнішній ключ на таблицю `department`.

### Таблиця `student`

Містить інформацію про студентів.

- `student_id` — первинний ключ;
  
- `last_name` — прізвище;
  
- `first_name` — ім’я;
  
- `birth_date` — дата народження;
  
- `email` — електронна пошта;
  
- `phone` — номер телефону;
  
- `enrollment_year` — рік вступу.

### Таблиця `course`

Містить інформацію про навчальні курси.

- `course_id` — первинний ключ;
  
- `course_name` — назва курсу;
  
- `credits` — кількість кредитів;
  
- `semester` — семестр;
 
- `teacher_id` — зовнішній ключ на таблицю `teacher`;

- `department_id` — зовнішній ключ на таблицю `department`.

### Таблиця `registration`

Містить інформацію про реєстрацію студентів на курси.

- `registration_id` — первинний ключ;
  
- `student_id` — зовнішній ключ на таблицю `student`;
  
- `course_id` — зовнішній ключ на таблицю `course`;
  
- `registration_date` — дата реєстрації;
  
- `status` — статус реєстрації;
  
- `grade` — підсумкова оцінка.

## SQL-скрипт створення таблиць

```sql
CREATE TABLE department (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    faculty_name VARCHAR(100) NOT NULL,
    office_number VARCHAR(10)
);

CREATE TABLE teacher (
    teacher_id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    position VARCHAR(50),
    department_id INTEGER REFERENCES department(department_id)
);

CREATE TABLE student (
    student_id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    enrollment_year INTEGER CHECK (enrollment_year >= 2000)
);

CREATE TABLE course (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER CHECK (credits BETWEEN 1 AND 10),
    semester INTEGER CHECK (semester BETWEEN 1 AND 8),
    teacher_id INTEGER REFERENCES teacher(teacher_id),
    department_id INTEGER REFERENCES department(department_id)
);

CREATE TABLE registration (
    registration_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES student(student_id),
    course_id INTEGER REFERENCES course(course_id),
    registration_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'активна',
    grade VARCHAR(5),
    UNIQUE(student_id, course_id)
);
```

*Невеличка перевірка роботи бази:*

```sql
SELECT * FROM department;
SELECT * FROM teacher;
SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM registration;
```

<img width="1832" height="245" alt="image" src="https://github.com/user-attachments/assets/086b33b3-f634-4444-8b9d-e3c1d42934a6" />

<img width="1830" height="247" alt="image" src="https://github.com/user-attachments/assets/e2abbddf-9b87-4dd4-9933-c76a7035c389" />

<img width="1862" height="251" alt="image" src="https://github.com/user-attachments/assets/c9a3cfaf-5103-4cbc-bf60-b5417fee2743" />

<img width="1805" height="254" alt="image" src="https://github.com/user-attachments/assets/f2d69d9e-10ef-4bbf-9a17-428df3d2cdfd" />

<img width="1861" height="333" alt="image" src="https://github.com/user-attachments/assets/ff4366d5-f7f9-4384-8db4-5521ab0fd054" />

## Висновок

В цій лабораторній роботі я ознайомився з новим матеріалом про реалізацію нашої таблиці безпосередньо у системі. 
У ході лабораторної роботи ER-діаграма була перетворена у реляційну модель бази даних. Було створено таблиці, визначено ключі та обмеження. 
Реалізація була перевірена шляхом виконання SQL-скриптів та аналізу результатів.
