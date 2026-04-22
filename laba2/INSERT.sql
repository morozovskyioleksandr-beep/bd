-- department
INSERT INTO department (department_name, faculty_name, office_number) VALUES
('Кафедра комп’ютерних наук', 'Факультет інформаційних технологій', '101'),
('Кафедра математики', 'Факультет природничих наук', '202'),
('Кафедра фізики', 'Факультет природничих наук', '303');

-- teacher
INSERT INTO teacher (last_name, first_name, email, phone, position, department_id) VALUES
('Іваненко', 'Іван', 'ivanenko@gmail.com', '+380671234567', 'Професор', 1),
('Петренко', 'Олег', 'petrenko@gmail.com', '+380501112233', 'Доцент', 2),
('Шевченко', 'Анна', 'shevchenko@gmail.com', '+380931234567', 'Асистент', 1);

-- student
INSERT INTO student (last_name, first_name, birth_date, email, phone, enrollment_year) VALUES
('Коваль', 'Андрій', '2003-05-10', 'andriy.koval@gmail.com', '+380661234567', 2021),
('Мельник', 'Оксана', '2002-08-15', 'oksana.melnyk@gmail.com', '+380671112233', 2020),
('Бондар', 'Тарас', '2004-02-20', 'taras.bondar@gmail.com', '+380991234567', 2022);

-- course
INSERT INTO course (course_name, credits, semester, teacher_id, department_id) VALUES
('Бази даних', 5, 3, 1, 1),
('Лінійна алгебра', 4, 2, 2, 2),
('Програмування', 6, 1, 3, 1);

-- registration
INSERT INTO registration (student_id, course_id, status, grade) VALUES
(1, 1, 'active', NULL),
(1, 2, 'completed', 'A'),
(2, 1, 'active', NULL),
(2, 3, 'active', NULL),
(3, 3, 'active', NULL);
