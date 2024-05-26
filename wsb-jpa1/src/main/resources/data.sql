-- Create necessary tables if they don't exist
CREATE TABLE IF NOT EXISTS ADDRESS (
    id INT PRIMARY KEY,
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(255),
    postal_code VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS DOCTOR (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    telephone_number VARCHAR(20),
    email VARCHAR(100),
    doctor_number VARCHAR(10),
    specialization VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS PATIENT (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    telephone_number VARCHAR(20),
    email VARCHAR(100),
    patient_number VARCHAR(10),
    date_of_birth DATE,
    has_insurance BOOLEAN
);

CREATE TABLE IF NOT EXISTS VISIT (
    id INT PRIMARY KEY,
    description VARCHAR(255),
    time TIMESTAMP,
    PATIENT_ID INT,
    DOCTOR_ID INT,
    FOREIGN KEY (PATIENT_ID) REFERENCES PATIENT(id),
    FOREIGN KEY (DOCTOR_ID) REFERENCES DOCTOR(id)
);

CREATE TABLE IF NOT EXISTS MEDICAL_TREATMENT (
    id INT PRIMARY KEY,
    description VARCHAR(255),
    type VARCHAR(50),
    VISIT_ID INT,
    FOREIGN KEY (VISIT_ID) REFERENCES VISIT(id)
);

CREATE TABLE IF NOT EXISTS DOCTOR_ADDRESS_MAPPING (
    doctor_id INT,
    address_id INT,
    FOREIGN KEY (doctor_id) REFERENCES DOCTOR(id),
    FOREIGN KEY (address_id) REFERENCES ADDRESS(id)
);

CREATE TABLE IF NOT EXISTS PATIENT_ADDRESS_MAPPING (
    patient_id INT,
    address_id INT,
    FOREIGN KEY (patient_id) REFERENCES PATIENT(id),
    FOREIGN KEY (address_id) REFERENCES ADDRESS(id)
);

-- Clear existing data
DELETE FROM DOCTOR_ADDRESS_MAPPING;
DELETE FROM PATIENT_ADDRESS_MAPPING;
DELETE FROM MEDICAL_TREATMENT;
DELETE FROM VISIT;
DELETE FROM PATIENT;
DELETE FROM DOCTOR;
DELETE FROM ADDRESS;

-- Reset auto-increment (if necessary)
ALTER TABLE ADDRESS ALTER COLUMN id RESTART WITH 1;
ALTER TABLE DOCTOR ALTER COLUMN id RESTART WITH 1;
ALTER TABLE PATIENT ALTER COLUMN id RESTART WITH 1;
ALTER TABLE VISIT ALTER COLUMN id RESTART WITH 1;
ALTER TABLE MEDICAL_TREATMENT ALTER COLUMN id RESTART WITH 1;

-- Insert new data
INSERT INTO ADDRESS (id, address_line1, address_line2, city, postal_code)
VALUES
(1, 'ul. Kwiatowa 15', '', 'Warszawa', '00-001'),
(2, 'ul. Słoneczna 20', '', 'Kraków', '30-002'),
(3, 'ul. Wiosenna 10', '', 'Łódź', '90-003'),
(4, 'ul. Jesienna 5', '', 'Wrocław', '50-004'),
(5, 'ul. Zimowa 8', '', 'Poznań', '60-005'),
(6, 'ul. Letnia 12', '', 'Gdańsk', '80-006'),
(7, 'ul. Polna 3', '', 'Szczecin', '70-007'),
(8, 'ul. Leśna 18', '', 'Lublin', '20-008'),
(9, 'ul. Morska 25', '', 'Gdynia', '81-009'),
(10, 'ul. Górska 30', '', 'Zakopane', '34-010');

-- Insert doctors
INSERT INTO DOCTOR (id, first_name, last_name, telephone_number, email, doctor_number, specialization)
VALUES
(1, 'Jan', 'Kowalski', '123456789', 'jan.kowalski@example.com', 'D001', 'Kardiolog'),
(2, 'Anna', 'Nowak', '987654321', 'anna.nowak@example.com', 'D002', 'Dermatolog'),
(3, 'Piotr', 'Wiśniewski', '456789123', 'piotr.wisniewski@example.com', 'D003', 'Neurolog'),
(4, 'Maria', 'Wójcik', '789123456', 'maria.wojcik@example.com', 'D004', 'Ortopeda'),
(5, 'Krzysztof', 'Kaczmarek', '321654987', 'krzysztof.kaczmarek@example.com', 'D005', 'Pediatra'),
(6, 'Ewa', 'Kamińska', '654321987', 'ewa.kaminska@example.com', 'D006', 'Psychiatra'),
(7, 'Tomasz', 'Lewandowski', '147258369', 'tomasz.lewandowski@example.com', 'D007', 'Urolog'),
(8, 'Agnieszka', 'Zielińska', '258369147', 'agnieszka.zielinska@example.com', 'D008', 'Ginekolog'),
(9, 'Marek', 'Szymański', '369147258', 'marek.szymanski@example.com', 'D009', 'Endokrynolog'),
(10, 'Magdalena', 'Wróbel', '741852963', 'magdalena.wrobel@example.com', 'D010', 'Okulista');

-- Insert patients
INSERT INTO PATIENT (id, first_name, last_name, telephone_number, email, patient_number, date_of_birth, has_insurance)
VALUES
(1, 'Paweł', 'Mazurek', '111222333', 'pawel.mazurek@example.com', 'P001', '1980-01-01', true),
(2, 'Katarzyna', 'Stępień', '444555666', 'katarzyna.stepien@example.com', 'P002', '1985-02-02', true),
(3, 'Michał', 'Dąbrowski', '777888999', 'michal.dabrowski@example.com', 'P003', '1990-03-03', false),
(4, 'Aleksandra', 'Król', '333444555', 'aleksandra.krol@example.com', 'P004', '1995-04-04', true),
(5, 'Rafał', 'Pawlak', '666777888', 'rafal.pawlak@example.com', 'P005', '2000-05-05', false),
(6, 'Monika', 'Głowacka', '999000111', 'monika.glowacka@example.com', 'P006', '1975-06-06', true),
(7, 'Jacek', 'Sikora', '222333444', 'jacek.sikora@example.com', 'P007', '1982-07-07', true),
(8, 'Zofia', 'Włodarczyk', '555666777', 'zofia.wlodarczyk@example.com', 'P008', '1988-08-08', false),
(9, 'Wojciech', 'Pietrzak', '888999000', 'wojciech.pietrzak@example.com', 'P009', '1970-09-09', true),
(10, 'Barbara', 'Czarnecka', '000111222', 'barbara.czarnecka@example.com', 'P010', '1993-10-10', true);

-- Insert visits
INSERT INTO VISIT (id, description, time, PATIENT_ID, DOCTOR_ID)
VALUES
(1, 'Wizyta kontrolna', '2024-05-10 10:00', 1, 1),
(2, 'Konsultacja dermatologiczna', '2024-05-11 11:00', 2, 2),
(3, 'Badanie neurologiczne', '2024-05-12 12:00', 3, 3),
(4, 'Konsultacja ortopedyczna', '2024-05-13 13:00', 4, 4),
(5, 'Wizyta pediatryczna', '2024-05-14 14:00', 5, 5),
(6, 'Konsultacja psychiatryczna', '2024-05-15 15:00', 6, 6),
(7, 'Badanie urologiczne', '2024-05-16 16:00', 7, 7),
(8, 'Konsultacja ginekologiczna', '2024-05-17 17:00', 8, 8),
(9, 'Badanie endokrynologiczne', '2024-05-18 18:00', 9, 9),
(10, 'Wizyta okulistyczna', '2024-05-19 19:00', 10, 10);

-- Insert medical treatments
INSERT INTO MEDICAL_TREATMENT (id, description, type, VISIT_ID)
VALUES
(1, 'Echokardiografia', 'Diagnostyka', 1),
(2, 'Dermatoskopia', 'Diagnostyka', 2),
(3, 'EEG', 'Diagnostyka', 3),
(4, 'RTG', 'Diagnostyka', 4),
(5, 'Szczepienie', 'Leczenie', 5),
(6, 'Terapia', 'Leczenie', 6),
(7, 'USG', 'Diagnostyka', 7),
(8, 'Cytologia', 'Diagnostyka', 8),
(9, 'Badanie hormonalne', 'Diagnostyka', 9),
(10, 'Badanie wzroku', 'Diagnostyka', 10);

-- Insert doctor address mappings
INSERT INTO DOCTOR_ADDRESS_MAPPING (doctor_id, address_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert patient address mappings
INSERT INTO PATIENT_ADDRESS_MAPPING (patient_id, address_id)
VALUES
(1, 10),
(2, 9),
(3, 8),
(4, 7),
(5, 6),
(6, 5),
(7, 4),
(8, 3),
(9, 2),
(10, 1);

