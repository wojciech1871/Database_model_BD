CREATE TABLE article (
    article_id   INTEGER NOT NULL,
    name         VARCHAR2(25 CHAR) NOT NULL,
    category     VARCHAR2(25 CHAR) NOT NULL,
    value        INTEGER NOT NULL
);

ALTER TABLE article ADD CONSTRAINT article_pk PRIMARY KEY ( article_id );

CREATE TABLE control_station (
    control_station_id   INTEGER NOT NULL,
    name                 VARCHAR2(25 CHAR) NOT NULL,
    address              VARCHAR2(25 CHAR) NOT NULL,
    phone_number         INTEGER NOT NULL
);

ALTER TABLE control_station ADD CONSTRAINT control_station_pk PRIMARY KEY ( control_station_id );

CREATE TABLE employee (
    employee_id              INTEGER NOT NULL,
    employee_type            CHAR(1 CHAR) NOT NULL,
    name                     VARCHAR2(25 CHAR) NOT NULL,
    surname                  VARCHAR2(25 CHAR) NOT NULL,
    date_of_birth            DATE NOT NULL,
    phone_number             INTEGER,
    salary                   INTEGER NOT NULL,
    warehouse_warehouse_id   INTEGER,
    office_office_id         INTEGER
);

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employee_id );

CREATE TABLE office (
    office_id        INTEGER NOT NULL,
    address          VARCHAR2(25 CHAR) NOT NULL,
    max_efficiency   INTEGER NOT NULL
);

ALTER TABLE office ADD CONSTRAINT office_pk PRIMARY KEY ( office_id );

CREATE TABLE "Order" (
    order_id                   INTEGER NOT NULL,
    date_of_start              DATE NOT NULL,
    date_of_end                DATE,
    obligatory_date_of_end     DATE NOT NULL,
    transporting_cost          INTEGER NOT NULL,
    reciepient_reciepient_id   INTEGER NOT NULL,
    orderer_orderer_id         INTEGER NOT NULL,
    office_office_id           INTEGER NOT NULL,
    vehicle_vehicle_id         INTEGER NOT NULL
);

ALTER TABLE "Order" ADD CONSTRAINT order_pk PRIMARY KEY ( order_id );

CREATE TABLE order_article (
    order_order_id       INTEGER NOT NULL,
    quantity             INTEGER NOT NULL,
    diiscount            INTEGER,
    article_article_id   INTEGER NOT NULL
);

ALTER TABLE order_article ADD CONSTRAINT order_article_pk PRIMARY KEY ( order_order_id,
article_article_id );

CREATE TABLE orderer (
    orderer_id     INTEGER NOT NULL,
    name           VARCHAR2(25 CHAR) NOT NULL,
    surname        VARCHAR2(25 CHAR) NOT NULL,
    address        VARCHAR2(25 CHAR) NOT NULL,
    phone_number   INTEGER NOT NULL
);

ALTER TABLE orderer ADD CONSTRAINT orderer_pk PRIMARY KEY ( orderer_id );

CREATE TABLE reciepient (
    reciepient_id   INTEGER NOT NULL,
    name            VARCHAR2(25 CHAR) NOT NULL,
    surname         VARCHAR2(25 CHAR) NOT NULL,
    address         VARCHAR2(25 CHAR) NOT NULL,
    phone_number    INTEGER NOT NULL
);

ALTER TABLE reciepient ADD CONSTRAINT reciepient_pk PRIMARY KEY ( reciepient_id );

CREATE TABLE repair (
    vehicle_vehicle_id      INTEGER NOT NULL,
    cs_control_station_id   INTEGER NOT NULL,
    date_of_start           DATE NOT NULL,
    date_of_end             DATE,
    value                   INTEGER NOT NULL
);

ALTER TABLE repair ADD CONSTRAINT repair_pk PRIMARY KEY ( vehicle_vehicle_id,
cs_control_station_id );

CREATE TABLE vehicle (
    vehicle_id             INTEGER NOT NULL,
    car_brand              VARCHAR2(25 CHAR) NOT NULL,
    car_model              VARCHAR2(25 CHAR) NOT NULL,
    registration_number    VARCHAR2(25 CHAR) NOT NULL,
    date_of_production     DATE,
    employee_employee_id   INTEGER NOT NULL
);

CREATE UNIQUE INDEX vehicle__idx ON
    vehicle ( employee_employee_id ASC );

ALTER TABLE vehicle ADD CONSTRAINT vehicle_pk PRIMARY KEY ( vehicle_id );

CREATE TABLE warehouse (
    warehouse_id   INTEGER NOT NULL,
    address        VARCHAR2(25 CHAR) NOT NULL,
    capacity       INTEGER NOT NULL
);

ALTER TABLE warehouse ADD CONSTRAINT warehouse_pk PRIMARY KEY ( warehouse_id );

CREATE TABLE warehouse_article (
    warehouse_warehouse_id   INTEGER NOT NULL,
    quantity                 INTEGER NOT NULL,
    expiration_date          DATE NOT NULL,
    batch_number             INTEGER NOT NULL,
    article_article_id       INTEGER NOT NULL
);

ALTER TABLE warehouse_article ADD CONSTRAINT warehouse_article_pk PRIMARY KEY ( warehouse_warehouse_id,
article_article_id );

ALTER TABLE employee
    ADD CONSTRAINT employee_office_fk FOREIGN KEY ( office_office_id )
        REFERENCES office ( office_id );

ALTER TABLE employee
    ADD CONSTRAINT employee_warehouse_fk FOREIGN KEY ( warehouse_warehouse_id )
        REFERENCES warehouse ( warehouse_id );

ALTER TABLE order_article
    ADD CONSTRAINT order_article_article_fk FOREIGN KEY ( article_article_id )
        REFERENCES article ( article_id );

ALTER TABLE order_article
    ADD CONSTRAINT order_article_order_fk FOREIGN KEY ( order_order_id )
        REFERENCES "Order" ( order_id );

ALTER TABLE "Order"
    ADD CONSTRAINT order_office_fk FOREIGN KEY ( office_office_id )
        REFERENCES office ( office_id );

ALTER TABLE "Order"
    ADD CONSTRAINT order_orderer_fk FOREIGN KEY ( orderer_orderer_id )
        REFERENCES orderer ( orderer_id );

ALTER TABLE "Order"
    ADD CONSTRAINT order_reciepient_fk FOREIGN KEY ( reciepient_reciepient_id )
        REFERENCES reciepient ( reciepient_id );

ALTER TABLE "Order"
    ADD CONSTRAINT order_vehicle_fk FOREIGN KEY ( vehicle_vehicle_id )
        REFERENCES vehicle ( vehicle_id );

ALTER TABLE repair
    ADD CONSTRAINT repair_control_station_fk FOREIGN KEY ( cs_control_station_id )
        REFERENCES control_station ( control_station_id );

ALTER TABLE repair
    ADD CONSTRAINT repair_vehicle_fk FOREIGN KEY ( vehicle_vehicle_id )
        REFERENCES vehicle ( vehicle_id );

ALTER TABLE vehicle
    ADD CONSTRAINT vehicle_employee_fk FOREIGN KEY ( employee_employee_id )
        REFERENCES employee ( employee_id );

ALTER TABLE warehouse_article
    ADD CONSTRAINT warehouse_article_article_fk FOREIGN KEY ( article_article_id )
        REFERENCES article ( article_id );

ALTER TABLE warehouse_article
    ADD CONSTRAINT warehouse_article_warehouse_fk FOREIGN KEY ( warehouse_warehouse_id )
        REFERENCES warehouse ( warehouse_id );
