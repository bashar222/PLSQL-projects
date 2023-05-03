DROP TABLE HR.COUNTRIES CASCADE CONSTRAINTS;

CREATE TABLE HR.COUNTRIES
(
  COUNTRY_ID    CHAR(2 BYTE) CONSTRAINT COUNTRY_ID_NN NOT NULL,
  COUNTRY_NAME  VARCHAR2(40 BYTE),
  REGION_ID     NUMBER, 
  CONSTRAINT COUNTRY_C_ID_PK
 PRIMARY KEY
 (COUNTRY_ID)
)
ORGANIZATION INDEX
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL
MONITORING;

COMMENT ON TABLE HR.COUNTRIES IS 'country table. Contains 25 rows. References with locations table.';

COMMENT ON COLUMN HR.COUNTRIES.COUNTRY_ID IS 'Primary key of countries table.';

COMMENT ON COLUMN HR.COUNTRIES.COUNTRY_NAME IS 'Country name';

COMMENT ON COLUMN HR.COUNTRIES.REGION_ID IS 'Region ID for the country. Foreign key to region_id column in the departments table.';




CREATE OR REPLACE TRIGGER HR.casc_country 
before delete on  countries 
for each row
DISABLE
begin 

delete from employees 
where department_id in (select department_id from departments where location_id in
(select location_id from locations where country_id = :old.country_id )) ;

delete from departments 
where 
location_id in (select location_id from locations where country_id = :old.country_id) ;

delete from locations 
where country_id = :old.country_id ; 

end ;
/


ALTER TABLE HR.COUNTRIES ADD (
  CONSTRAINT COUNTR_REG_FK 
 FOREIGN KEY (REGION_ID) 
 REFERENCES HR.REGIONS (REGION_ID));
