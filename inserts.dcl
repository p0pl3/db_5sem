INSERT INTO "user" ("first_name", "username", "last_name", "phone", "email", "password")
VALUES
    ('John', 'john_doe', 'Smith', '+79123456789', 'john@example.com', 'password123'),
    ('Alice', 'alice_smith', 'Johnson', '+79234567890', 'alice@example.com', 'securepass'),
    ('Bob', 'bob_jones', 'Williams', '+79012345678', 'bob@example.com', 'bob1234'),
    ('Emma', 'emma_miller', 'Brown', '+79876543210', 'emma@example.com', 'emmabrown'),
    ('Michael', 'michael_wilson', 'Davis', '+79765432109', 'michael@example.com', '12345678');

INSERT INTO "user_transport" ("model", "color", "serial_number", "weight", "user_id")
VALUES
    ('Boeing 747', 'White', 'BA123456', '400,000 lbs', 1),
    ('Airbus A320', 'Blue', 'AB987654', '200,000 lbs', 2),
    ('Embraer E190', 'Red', 'ER567890', '120,000 lbs', 3),
    ('Bombardier CRJ900', 'Yellow', 'CR123789', '85,000 lbs', 4),
    ('Cessna 172', 'Green', 'CE456789', '2,450 lbs', 5);

INSERT INTO "detail" ("name", "detail_code", "price", "quantity", "serial_number")
VALUES
    ('Jet Engine', 'JE123', 50000.00, 20, 'SN12345'),
    ('Wing Assembly', 'WA456', 10000.00, 30, 'SN67890'),
    ('Landing Gear', 'LG789', 7500.00, 25, 'SN23456'),
    ('Cockpit Instrument Panel', 'CIP101', 5000.00, 15, 'SN78901'),
    ('Tail Fin', 'TF234', 3000.00, 40, 'SN34567'),
    ('Navigation Lights', 'NL567', 1500.00, 50, 'SN45678'),
    ('Avionics System', 'AS890', 9000.00, 10, 'SN56789'),
    ('Seats', 'SE777', 500.00, 100, 'SN67890'),
    ('Fuel Tank', 'FT456', 25000.00, 5, 'SN78901'),
    ('Aircraft Fuselage', 'AF123', 20000.00, 10, 'SN89012');

INSERT INTO "employee" ("first_name", "middle_name", "last_name", "phone", "salary", "age", "degree", "email", "sex")
VALUES
    ('John', 'A.', 'Smith', '+79123456789', 60000.00, 30, 'MASTER', 'john@example.com', 'Male'),
    ('Alice', 'M.', 'Johnson', '+79234567890', 55000.00, 28, 'HELPER', 'alice@example.com', 'Female'),
    ('Bob', 'C.', 'Williams', '+79345678901', 65000.00, 35, 'GRADE-MASTER', 'bob@example.com', 'Male'),
    ('Emma', 'D.', 'Brown', '+79456789012', 52000.00, 27, 'CLEANER', 'emma@example.com', 'Female');

INSERT INTO "status_order" (name) VALUES
('START'),
('STOP'),
('WAIT'),
('DONE');

INSERT INTO "work_station" (name, location) VALUES
('AVL-1', 'Moscow'),
('AVL-2', 'Piter'),
('AVL-3', 'Tomsk'),
('AVL-4', 'Saratov');

INSERT INTO "malfunction" (date_create, description) VALUES
('2020-10-04', 'Crash vehicle'),
('2020-11-01', 'Crash engine'),
('2020-04-02', 'Crash wings');

INSERT INTO "payment_method" (payment_date, status, total_sum, transaction_number) VALUES
('2023-10-01', TRUE, 100000, 'ewp12q-e3q-b2vs-ad423f'),
('2023-10-01', FALSE, 900000, 'eq2-eq-3bvs-ad2f'),
('2023-10-01', TRUE, 433, 'f54sd-e432q-b234vs-a1df');

INSERT INTO "order_document" (date_start, date_end, description, total_price, advice, payment_method_id) VALUES
('2023-09-01', '2023-09-25', 'ALL OF GOOD', 100000, 'last repair', 1),
('2023-09-21', '2023-09-25', 'ALL OF GOOD', 100000, 'change oil', 2),
('2023-09-07', '2023-10-01', 'ALL OF GOOD', 100000, 'check wings', 3);

INSERT INTO "order" (order_date, order_deadline, description, user_transport_id, work_station_id, malfunction_id, order_document_id, status_order_id) VALUES
('2023-08-01', '2023-09-25', 'something...', 1, 1, 1, 1, 4),
('2023-07-01', '2023-09-25', 'crash something', 2, 2, 2, 2, 4),
('2023-09-07', '2023-10-01', 'crash wings', 3, 3, 3, 3, 4),
('2023-10-07', '2024-09-01', 'something wrong', 4, 1, NULL, NULL, 3),
('2023-11-07', '2025-11-01', 'idk', 5, 2, NULL, NULL, 3);

INSERT INTO "order_detail" (description, quantity, order_id, detail_id) VALUES
('vehicle big', 12, 1, 6),
('window glass', 1, 2, 1),
('bolt 2x3', 2, 3, 3),
('creslo natural', 5, 4, 2);

INSERT INTO "order_employee" (order_id, employee_id) VALUES
(1, 1),
(1, 2),
(1, 4),
(2, 2),
(3, 3);
