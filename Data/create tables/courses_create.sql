ALTER TABLE HR.COURSES
 DROP PRIMARY KEY CASCADE;

DROP TABLE HR.COURSES CASCADE CONSTRAINTS;

CREATE TABLE HR.COURSES
(
  CRS_ID     NUMBER(7),
  CRS_NAME   VARCHAR2(50 BYTE),
  CRS_PRICE  NUMBER(8,2)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE UNIQUE INDEX HR.CRS_PK ON HR.COURSES
(CRS_ID)
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
NOPARALLEL;


CREATE OR REPLACE TRIGGER HR.COURSES_trig  before insert ON HR.COURSES for each row
begin  :new.CRS_ID := COURSES_SEQ.nextval ;   end ;
/


ALTER TABLE HR.COURSES ADD (
  CONSTRAINT CRS_PK
 PRIMARY KEY
 (CRS_ID)
    USING INDEX 
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
               ));
