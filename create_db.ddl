BEGIN;
CREATE TABLE "user"
(
    "id"         bigint       NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "first_name" varchar(127) NOT NULL,
    "username"   varchar(127) NOT NULL,
    "last_name"  varchar(127) NOT NULL,
    "phone"      varchar(12)  NOT NULL,
    "email"      varchar(127) NULL,
    "password"   varchar(127) NOT NULL
);
--
-- Create model Detail
--
CREATE TABLE "detail"
(
    "id"            bigint        NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "name"          varchar(127)  NOT NULL,
    "detail_code"   varchar(127)  NOT NULL,
    "price"         numeric(8, 2) NOT NULL,
    "quantity"      integer       NOT NULL CHECK ("quantity" >= 0),
    "serial_number" varchar(127)  NOT NULL
);
--
-- Create model Employee
--
CREATE TABLE "employee"
(
    "id"          bigint        NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "first_name"  varchar(127)  NOT NULL,
    "middle_name" varchar(127)  NULL,
    "last_name"   varchar(127)  NOT NULL,
    "phone"       varchar(12)   NOT NULL,
    "salary"      numeric(8, 2) NOT NULL,
    "age"         integer       NOT NULL CHECK ("age" >= 0),
    "degree"      varchar(127)  NOT NULL,
    "email"       varchar(127)  NOT NULL,
    "sex"         varchar(127)  NOT NULL
);
--
-- Create model Malfunction
--
CREATE TABLE "malfunction"
(
    "id"          bigint                   NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "date_create" timestamp with time zone NOT NULL,
    "description" varchar(511)             NOT NULL
);
--
-- Create model Order
--
CREATE TABLE "order"
(
    "id"             bigint                   NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "order_date"     timestamp with time zone NOT NULL,
    "order_deadline" timestamp with time zone NOT NULL,
    "description"    varchar(511)             NOT NULL,
    "malfunction_id" bigint                   NULL UNIQUE
);
CREATE TABLE "order_employee"
(
    "id"          bigint NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "order_id"    bigint NOT NULL,
    "employee_id" bigint NOT NULL
);
--
-- Create model PaymentMethod
--
CREATE TABLE "payment_method"
(
    "id"                 bigint                   NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "payment_date"       timestamp with time zone NOT NULL,
    "status"             boolean                  NOT NULL,
    "total_sum"          numeric(8, 2)            NOT NULL,
    "transaction_number" varchar(511)             NOT NULL
);
--
-- Create model StatusOrder
--
CREATE TABLE "status_order"
(
    "id"   bigint       NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "name" varchar(127) NOT NULL
);
--
-- Create model WorkStation
--
CREATE TABLE "work_station"
(
    "id"       bigint       NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "name"     varchar(127) NOT NULL,
    "location" varchar(255) NOT NULL
);
--
-- Create model UserTransport
--
CREATE TABLE "user_transport"
(
    "id"            bigint       NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "model"         varchar(127) NOT NULL,
    "color"         varchar(127) NOT NULL,
    "serial_number" varchar(127) NOT NULL,
    "weight"        varchar(127) NOT NULL,
    "user_id"       integer      NOT NULL
);
--
-- Create model OrderDocument
--
CREATE TABLE "order_document"
(
    "id"                bigint                   NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "date_start"        timestamp with time zone NOT NULL,
    "date_end"          timestamp with time zone NOT NULL,
    "description"       varchar(511)             NOT NULL,
    "total_price"       numeric(8, 2)            NOT NULL,
    "advice"            varchar(511)             NOT NULL,
    "payment_method_id" bigint                   NULL UNIQUE
);
--
-- Create model OrderDetail
--
CREATE TABLE "order_detail"
(
    "id"          bigint       NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "description" varchar(127) NULL,
    "quantity"    integer      NOT NULL CHECK ("quantity" >= 0),
    "detail_id"   bigint       NOT NULL,
    "order_id"    bigint       NOT NULL
);
--
-- Add field order_document to order
--
ALTER TABLE "order"
    ADD COLUMN "order_document_id" bigint NULL UNIQUE
        CONSTRAINT "order_order_document_id_274c59cd_fk_order_document_id" REFERENCES "order_document" ("id") DEFERRABLE INITIALLY DEFERRED;
SET CONSTRAINTS "order_order_document_id_274c59cd_fk_order_document_id" IMMEDIATE;
--
-- Add field status_order to order
--
ALTER TABLE "order"
    ADD COLUMN "status_order_id" bigint NOT NULL
        CONSTRAINT "order_status_order_id_125a3508_fk_status_order_id" REFERENCES "status_order" ("id") DEFERRABLE INITIALLY DEFERRED;
SET CONSTRAINTS "order_status_order_id_125a3508_fk_status_order_id" IMMEDIATE;
--
-- Add field user_transport to order
--
ALTER TABLE "order"
    ADD COLUMN "user_transport_id" bigint NOT NULL
        CONSTRAINT "order_user_transport_id_c0d8eb87_fk_user_transport_id" REFERENCES "user_transport" ("id") DEFERRABLE INITIALLY DEFERRED;
SET CONSTRAINTS "order_user_transport_id_c0d8eb87_fk_user_transport_id" IMMEDIATE;
--
-- Add field work_station to order
--
ALTER TABLE "order"
    ADD COLUMN "work_station_id" bigint NOT NULL
        CONSTRAINT "order_work_station_id_4986e4ef_fk_work_station_id" REFERENCES "work_station" ("id") DEFERRABLE INITIALLY DEFERRED;
SET CONSTRAINTS "order_work_station_id_4986e4ef_fk_work_station_id" IMMEDIATE;
ALTER TABLE "order"
    ADD CONSTRAINT "order_malfunction_id_d1a0cdba_fk_malfunction_id" FOREIGN KEY ("malfunction_id") REFERENCES "malfunction" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "order_employee"
    ADD CONSTRAINT "order_employee_order_id_employee_id_15361970_uniq" UNIQUE ("order_id", "employee_id");
ALTER TABLE "order_employee"
    ADD CONSTRAINT "order_employee_order_id_14c70897_fk_order_id" FOREIGN KEY ("order_id") REFERENCES "order" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "order_employee"
    ADD CONSTRAINT "order_employee_employee_id_406e1405_fk_employee_id" FOREIGN KEY ("employee_id") REFERENCES "employee" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "order_employee_order_id_14c70897" ON "order_employee" ("order_id");
CREATE INDEX "order_employee_employee_id_406e1405" ON "order_employee" ("employee_id");
CREATE INDEX "user_transport_user_id_b2fb2829" ON "user_transport" ("user_id");
ALTER TABLE "order_document"
    ADD CONSTRAINT "order_document_payment_method_id_2c30ec1e_fk_payment_method_id" FOREIGN KEY ("payment_method_id") REFERENCES "payment_method" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "order_detail"
    ADD CONSTRAINT "order_detail_detail_id_286fda3b_fk_detail_id" FOREIGN KEY ("detail_id") REFERENCES "detail" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "order_detail"
    ADD CONSTRAINT "order_detail_order_id_b97dfbdf_fk_order_id" FOREIGN KEY ("order_id") REFERENCES "order" ("id") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "user_transport"
    ADD CONSTRAINT "client_transport_client_id_a2ee6445_fk_client_id" FOREIGN KEY ("user_id") REFERENCES "user" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "order_detail_detail_id_286fda3b" ON "order_detail" ("detail_id");
CREATE INDEX "order_detail_order_id_b97dfbdf" ON "order_detail" ("order_id");
CREATE INDEX "order_status_order_id_125a3508" ON "order" ("status_order_id");
CREATE INDEX "order_user_transport_id_c0d8eb87" ON "order" ("user_transport_id");
CREATE INDEX "order_work_station_id_4986e4ef" ON "order" ("work_station_id");
COMMIT;
