SELECT name from work_station where id = 1;
select * from order_document where total_price > 100;
select * from order_document where total_price < 200000;
select * from employee where salary >= 600;
select * from employee where salary <= 1400;
select * from employee where salary != 1400;
select * from "order" where "order".malfunction_id is null;
select * from "order" where "order".malfunction_id is not null;
select * from employee where salary between 12 and 1200;
select * from employee where id in (1, 4);
select * from employee where employee.first_name LIKE 'Pet%';
select * from employee where employee.first_name NOT LIKE 'Vas%';

--
-- - снимки экрана (скриншоты) выборки данных по различным параметрам
-- (по каждому оператору);

select * from detail ORDER BY name;
select * from detail ORDER BY name DESC ;
-- - снимок экрана (скриншоты) сортировки данных;
select * from employee;
ALTER TABLE employee ADD COLUMN email varchar(127);
select * from employee;
ALTER TABLE employee RENAME COLUMN email to pochta;
select * from employee;
ALTER TABLE employee DROP COLUMN pochta;
select * from employee;

select * from employee;
INSERT INTO "employee" ("first_name", "middle_name", "last_name", "phone", "salary", "age", "degree", "email", "sex")
VALUES ('QWE', 'ASD', 'ZXC', '+71234567890', 1000.00, 60, 'SLAVE', 'email@email.ru', 'Trans');
select * from employee;
UPDATE employee SET last_name = 'SMILE' where id = 5;
select * from employee;
DELETE FROM employee where id = 5;
select * from employee;

-- - снимки экрана (скриншоты) применения операторов изменения данных
-- в таблицах Вашей базы данных;
-- - добавить все практические работы по SQL в итоговых отчет


--
-- 3 PRACTICA
--


--проекция
select first_name from employee;
--селекция
SELECT * from work_station where id = 1;
--соединение
select * from "order" as m1 INNER JOIN status_order ct on ct.id = m1.status_order_id;
--объединение
select * from "order" as m1 INNER JOIN work_station ct on ct.id = m1.work_station_id where location='Moscow' or location='Piter';
--объединение
select * from "order" as m1 INNER JOIN work_station ct on ct.id = m1.work_station_id where location='Moscow'
UNION
select * from "order" as m1 INNER JOIN work_station ct on ct.id = m1.work_station_id where location='Piter';
--пересечение
SELECT o.id from "order" as o
    inner join "order_employee" as oe on o.id = oe.order_id
    where oe.employee_id=1 and exists(
        select oe2.order_id from order_employee as oe2
        where oe2.order_id=oe.order_id and oe2.employee_id=2);
--разность
SELECT o.id from "order" as o
    INNER JOIN "order_employee" as oe on o.id = oe.order_id
    where oe.employee_id = 1 and not exists(
        select oe2.order_id from order_employee as oe2
        where oe2.order_id = oe.order_id and oe2.employee_id = 2);
--группировка
select status_order_id, name, count('') from "order" JOIN
    status_order sm on sm.id = "order".status_order_id
    group by status_order_id, name;
select status_order_id, name, count('') from "order" JOIN
    status_order sm on sm.id = "order".status_order_id
    group by status_order_id, name having count('') > 2;
--сортировка
select * from detail ORDER BY name;
select * from detail ORDER BY name DESC;
-- деление
SELECT e.id FROM "employee" e WHERE NOT EXISTS (
    SELECT o.id FROM "order" o WHERE NOT EXISTS (
        SELECT * FROM "order_employee" oe WHERE oe.employee_id = e.id AND oe.order_id = o.id));



CREATE OR REPLACE view order_with_status as
select m.order_date, m.order_deadline, s.name
from "order" as m JOIN status_order as s on s.id = m.status_order_id;
select * from order_with_status where order_with_status.name = 'DONE';



CREATE OR REPLACE FUNCTION get_top_3_expensive_order()
RETURNS TABLE (
    model VARCHAR,
    total_price DECIMAL,
    description VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT ct.model, rd.total_price, "order".description
        FROM "order"
            JOIN order_document rd on rd.id = "order".order_document_id
            JOIN user_transport ct on ct.id = "order".user_transport_id
        ORDER BY total_price DESC
        LIMIT 3;
END;
$$;

select get_top_3_expensive_order();



CREATE OR REPLACE FUNCTION get_count_crashed_by_model(_name varchar)
RETURNS int
AS
$$
DECLARE
    product_count int;
BEGIN
        SELECT count(ct.id)
        INTO product_count
        FROM "order"
            JOIN user_transport ct on ct.id = "order".user_transport_id
        WHERE ct.model = _name;

    RETURN product_count;
END;
$$
LANGUAGE plpgsql;

select get_count_crashed_by_model('Boeing 747');




CREATE OR REPLACE FUNCTION get_top_1_spending_customer()
RETURNS TABLE (
    user_id INTEGER,
    total_price DECIMAL
)
AS
$$
BEGIN
    RETURN QUERY select ct.user_id, sum(rd.total_price) as q from "user"
        JOIN user_transport ct on "user".id = ct.user_id
        JOIN "order" m on ct.id = m.user_transport_id
        JOIN order_document rd on rd.id = m.order_document_id
        group by ct.user_id ORDER BY q desc limit 1;
END;
$$
LANGUAGE plpgsql;

select get_top_1_spending_customer();



CREATE OR REPLACE FUNCTION update_overdue_order() returns bool
AS
$$
BEGIN
    UPDATE "order" SET status_order_id = 5 WHERE order_deadline < now() and status_order_id != 4;
    RETURN TRUE;
END;
$$
LANGUAGE plpgsql;

select * from "order" JOIN status_order sm on sm.id = "order".status_order_id;
select update_overdue_order();
select * from "order" JOIN status_order sm on sm.id = "order".status_order_id;


CREATE OR REPLACE FUNCTION remove_old_order() returns bool
AS
$$
    DECLARE
        list_order_id bigint[];
BEGIN
    select array_agg("order".id) into list_order_id FROM "order" WHERE "order".id in (select "order".id from "order"
        JOIN order_document rd on rd.id = "order".order_document_id
                                                               where rd.date_end < current_timestamp - interval '100 day') ;
    DELETE from order_employee AS m where m.order_id = any(list_order_id);
    DELETE from order_detail AS w where w.order_id = any(list_order_id);
    DELETE from "order" AS m where m.id = any(list_order_id);

    RETURN TRUE;
END;
$$
LANGUAGE plpgsql;

select m.order_date, m.description, rd.date_end from "order" as m JOIN order_document rd on rd.id = m.order_document_id;
select remove_old_order();
select m.order_date, m.description, rd.date_end from "order" as m JOIN order_document rd on rd.id = m.order_document_id;


CREATE OR REPLACE FUNCTION make_discounts_on_spare_details(
    detail_list TEXT[]
) RETURNS VOID AS $$
BEGIN
    UPDATE detail SET price = price * 0.95 where name = any(detail_list);
    RETURN;
END;
$$ LANGUAGE plpgsql;

select * from detail;
SELECT make_discounts_on_spare_details('{Fuel Tank}'::TEXT[]);
select * from detail;



-- триггер

CREATE OR REPLACE FUNCTION make_discount_for_sbp()
  RETURNS TRIGGER AS
$$
BEGIN
  UPDATE payment_method
  SET total_sum = NEW.total_sum * 0.95
  WHERE transaction_number like 'SBP%' and payment_method.id=NEW.id;
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_amount_for_sbp
AFTER INSERT ON payment_method
FOR EACH ROW
EXECUTE FUNCTION make_discount_for_sbp();

select * from payment_method;
insert into payment_method (payment_date, status, total_sum, transaction_number) values
(current_timestamp, false, 4000.00, 'SBP-213-4123-43');
select * from payment_method;


CREATE OR REPLACE FUNCTION set_order_end_date()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status_order_id = 4 THEN
    UPDATE order_document SET date_end = current_timestamp where id = NEW.order_document_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_set_order_end_date
AFTER UPDATE ON "order"
FOR EACH ROW
EXECUTE FUNCTION set_order_end_date();

select m.id, m.description, m.status_order_id, rd.date_start, rd.date_end from "order" as m join order_document rd on rd.id = m.order_document_id;
UPDATE "order" set status_order_id = 4 where id = 8;
select m.id, m.description, m.status_order_id, rd.date_start, rd.date_end from "order" as m join order_document rd on rd.id = m.order_document_id;


CREATE OR REPLACE FUNCTION make_discount_for_start_mouth()
RETURNS TRIGGER AS $$
BEGIN
  IF EXTRACT(DAY FROM NEW.payment_date) = 1 THEN
    NEW.total_sum = NEW.total_sum * 0.95;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_apply_discount
BEFORE INSERT ON payment_method
FOR EACH ROW
EXECUTE FUNCTION make_discount_for_start_mouth();


select * from payment_method;
insert INTO payment_method (payment_date, status, total_sum, transaction_number) values
('2020-01-01', false, 1200, '9999-9999-9999');
select * from payment_method;