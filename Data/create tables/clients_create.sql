ALTER TABLE HR.CLIENTS
 DROP PRIMARY KEY CASCADE;

DROP TABLE HR.CLIENTS CASCADE CONSTRAINTS;

CREATE TABLE HR.CLIENTS
(
  CLIENT_ID    NUMBER(4),
  CLIENT_NAME  VARCHAR2(50 BYTE),
  MOBILE       VARCHAR2(50 BYTE),
  ADDRESS      VARCHAR2(100 BYTE),
  NID          VARCHAR2(100 BYTE)
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


CREATE UNIQUE INDEX HR.CLIENTS_PK ON HR.CLIENTS
(CLIENT_ID)
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


CREATE OR REPLACE TRIGGER HR.CLIENTS_trig  before insert ON HR.CLIENTS for each row
begin  :new.CLIENT_ID := CLIENTS_SEQ.nextval ;   end ;
/


ALTER TABLE HR.CLIENTS ADD (
  CONSTRAINT CLIENTS_PK
 PRIMARY KEY
 (CLIENT_ID)
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
