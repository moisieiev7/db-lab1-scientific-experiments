-- Лабораторна робота №1
-- Предметна галузь: Наукові експерименти

-- 1. Таблиця дослідників
CREATE TABLE IF NOT EXISTS public.researchers (
    researcher_id serial PRIMARY KEY,
    full_name character varying(100) NOT NULL,
    academic_degree character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    CONSTRAINT uq_researchers_email UNIQUE (email)
);

-- 2. Таблиця обладнання
CREATE TABLE IF NOT EXISTS public.equipment (
    equipment_id serial PRIMARY KEY,
    name character varying(100) NOT NULL,
    manufacturer character varying(100) NOT NULL,
    serial_number character varying(50) NOT NULL,
    CONSTRAINT uq_equipment_serial UNIQUE (serial_number)
);

-- 3. Таблиця експериментів
CREATE TABLE IF NOT EXISTS public.experiments (
    experiment_id serial PRIMARY KEY,
    title character varying(150) NOT NULL,
    start_date date NOT NULL,
    status character varying(50) NOT NULL,
    lead_researcher_id integer NOT NULL,
    CONSTRAINT uq_experiments_title UNIQUE (title),
    CONSTRAINT fk_experiments_researcher FOREIGN KEY (lead_researcher_id)
        REFERENCES public.researchers (researcher_id)
);

-- 4. Проміжна таблиця зв'язку N:M (використання обладнання в експериментах)
CREATE TABLE IF NOT EXISTS public.experiment_equipment (
    experiment_id integer NOT NULL,
    equipment_id integer NOT NULL,
    usage_hours integer NOT NULL,
    CONSTRAINT experiment_equipment_pkey PRIMARY KEY (experiment_id, equipment_id),
    CONSTRAINT fk_exp_equip_experiment FOREIGN KEY (experiment_id)
        REFERENCES public.experiments (experiment_id),
    CONSTRAINT fk_exp_equip_equipment FOREIGN KEY (equipment_id)
        REFERENCES public.equipment (equipment_id)
);

-- Внесення тестових даних
INSERT INTO public.researchers (full_name, email, academic_degree) VALUES
('Коваленко Олександр Іванович', 'kovalenko@kpi.ua', 'Доктор наук'),
('Мельник Ірина Петрівна', 'melnyk@kpi.ua', 'Кандидат наук'),
('Бондаренко Максим Сергійович', 'bondarenko@kpi.ua', 'Магістр');

INSERT INTO public.equipment (name, manufacturer, serial_number) VALUES
('Цифровий осцилограф', 'Tektronix', 'SN-TEK-10492'),
('Мас-спектрометр', 'Agilent', 'SN-AGI-88310'),
('Тепловізійна камера', 'FLIR', 'SN-FLR-55201');

INSERT INTO public.experiments (title, start_date, status, lead_researcher_id) VALUES
('Дослідження теплопровідності композитів', '2026-09-10', 'Завершений', 1),
('Аналіз високочастотних завад у мікросхемах', '2026-09-25', 'У процесі', 2),
('Спектральний аналіз нових полімерів', '2026-10-01', 'Запланований', 1);

INSERT INTO public.experiment_equipment (experiment_id, equipment_id, usage_hours) VALUES
(1, 3, 14),
(2, 1, 28),
(2, 3, 6),
(3, 2, 12);
