INSERT INTO "user" (first_name, username, last_name, phone, email, password) VALUES
('Roman', 'blstz13', 'Dmitrievich', '+70151071717', 's1niewfgqwgqfg20w3@mail.ru', 'qwerty'),
('Petya', 'qwerty', 'Alexandrovich', '+70120751077', 'siqtggfgcinr20w3@mail.ru','qwerty'),
('Vasya', '', 'Alexeevich', '+71777571177', '1initgfqwgnrw003@mail.ru','qwerty'),
('Misha', 'Romanovich', '+70570011177', 'siqfgici1gr2ewf03@mail.ru','qwerty'),
('Marina', 'Alexandrovich', '+79070011577', 'sinqwggnr2ewftg3@mail.ru','qwerty');



INSERT INTO user_transport (model, color, serial_number, user_id, weight) VALUES
('Bisnes JETT', 'Gray', '6-123-DADAD', 1, 1000),
('Sport JETT', 'White', 'eqw-123-WER', 1, 2000),
('Sport AIR', 'Red', '1-123-RW', 2, 3000),
('Sport WATER', 'Green', '45-as-QQQQ', 2, 10000),
('JEP JETT', 'Blue', '123-s-EQWE', 3, 5000),
('S7 FLOT', 'Gray', 'FSD-EW-5', 4, 3500),
('S9 OT', 'Yellow', 'B-1-QQQ', 5, 2500);


INSERT INTO detail (name, detail_code, price, quantity, serial_number) VALUES
('ENGINE d2', '73Aw', 100000.00, 1, 'qwe123'),
('Window airobus', 'qw543tgAw', 60000.00, 12, 'x7cv92f'),
('Chair dq2', '7u65rgt', 180000.00, 4, 'no1n4hgv14'),
('Vehicle', '12345y', 100100.00, 5, 'yb4124bob'),
('Control panel ', '123r', 234500.00, 8, '124vcu1v4v');


INSERT INTO work_station (name, location) VALUES
('AVL-1', 'Moscow'),
('AVL-2', 'Piter'),
('AVL-3', 'Tomsk'),
('AVL-4', 'Mordovia');


INSERT INTO status_order (name) VALUES
('START'),
('STOP'),
('WAIT'),
('DONE');


INSERT INTO repairer (first_name, middle_name, last_name, phone, salary, age, degree) VALUES
('Vladimir', 'Dmitrievich', 'POPL', '+789128912', 2000.00, 25, 'MASTER'),
('Petya', 'Alexandrovich', 'DUB', '+782222912', 1040.00, 25, 'HELPER'),
('Vasya', 'Alexeevich', 'Sinicin', '+7811118912', 1400.00, 25, 'GRADE-MASTER'),
('Rima', 'Romanovich', 'Reznikov', '+7890008912', 500.00, 25, 'CLEANER');


INSERT INTO primary_diagnosis (date_create, description) VALUES
('2020-10-04', 'Crash vehicle'),
('2020-11-01', 'Crash engine'),
('2020-04-02', 'Crash wings');

ALTER TABLE payment_method drop serial_number;

INSERT INTO payment_method (payment_date, status, total_sum, transaction_number) VALUES
('2023-10-01', TRUE, 100000, 'ewp12q-e3q-b2vs-ad423f'),
('2023-10-01', FALSE, 900000, 'eq2-eq-3bvs-ad2f'),
('2023-10-01', TRUE, 433, 'f54sd-e432q-b234vs-a1df');

INSERT INTO repair_document (date_start, date_end, description, total_price, payment_method_id) VALUES
('2023-09-01', '2023-09-25', 'ALL OF GOOD', 100000, 1),
('2023-09-21', '2023-09-25', 'ALL OF GOOD', 100000, 2),
('2023-09-07', '2023-10-01', 'ALL OF GOOD', 100000, 3);


INSERT INTO maintenance (maintenance_date, maintenance_deadline, description, client_transport_id, hangar_id, primary_diagnosis_id, repair_document_id, status_maintenance_id) VALUES
('2023-08-01', '2023-09-25', 'something...', 1, 1, 1, 3, 4),
('2023-07-01', '2023-09-25', 'crash something', 2, 2, 2, 4, 4),
('2023-09-07', '2023-10-01', 'crash wings', 3, 3, 3, 5, 4),
('2023-10-07', '2024-09-01', 'something wrong', 4, 1, NULL, NULL, 3),
('2023-11-07', '2025-11-01', 'idk', 5, 2, NULL, NULL, 3);

INSERT INTO maintenance_repairer (maintenance_id, repairer_id) VALUES
(6, 1),
(6, 2),
(6, 4),
(7, 2),
(8, 3);


INSERT INTO work_part (serial_number, description, quantity, maintenance_id, part_id) VALUES
('231-432', 'vehicle big size new', 2, 6, 4),
('rgw=13', 'vehicle big size new', 1, 6, 3),
('RWQW1', 'vehicle big size new', 1, 7, 1),
('qwe-123', 'vehicle big size new', 4, 8, 5);