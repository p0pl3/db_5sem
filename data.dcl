INSERT INTO "user" (first_name, username, last_name, phone, email, password) VALUES
('Roman', 'blstz13', 'Dmitrievich', '+70151071717', 's1niewfgqwgqfg20w3@mail.ru'),
('Petya', 'qwerty', 'Alexandrovich', '+70120751077', 'siqtggfgcinr20w3@mail.ru'),
('Vasya', '', 'Alexeevich', '+71777571177', '1initgfqwgnrw003@mail.ru'),
('Misha', 'Romanovich', '+70570011177', 'siqfgici1gr2ewf03@mail.ru'),
('Marina', 'Alexandrovich', '+79070011577', 'sinqwggnr2ewftg3@mail.ru');



INSERT INTO user_transport (model, color, serial_number, user_id, weight) VALUES
('Bisnes JETT', 'Gray', '6-123-DADAD', 1, ),
('Sport JETT', 'White', 'eqw-123-WER', 1, ),
('Sport AIR', 'Red', '1-123-RW', 2, ),
('Sport WATER', 'Green', '45-as-QQQQ', 2,),
('JEP JETT', 'Blue', '123-s-EQWE', 3, ),
('S7 FLOT', 'Gray', 'FSD-EW-5', 4, ),
('S9 OT', 'Yellow', 'B-1-QQQ', 5, );


INSERT INTO part (name, part_code, price, quantity, manufacture_date) VALUES
('ENGINE d2', '73Aw', 100000.00, 1, '2023-10-13'),
('Window airobus', 'qw543tgAw', 60000.00, 12, '2023-09-11'),
('Chair dq2', '7u65rgt', 180000.00, 4, '2023-01-12'),
('Vehicle', '12345y', 100100.00, 5, '2023-11-15'),
('Control panel ', '123r', 234500.00, 8, '2023-12-01');


INSERT INTO hangar (name, location, area, code) VALUES
('AVL-1', 'Moscow', '1200', 'X2Z'),
('AVL-2', 'Piter', '2200', 'XY35'),
('AVL-3', 'Tomsk', '5200', 'XY888'),
('AVL-4', 'Mordovia', '1200', 'X212');


INSERT INTO status_maintenance (name, status_code) VALUES
('START', 'STRT'),
('STOP', 'STP'),
('WAIT', 'WT'),
('DONE', 'DN');


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