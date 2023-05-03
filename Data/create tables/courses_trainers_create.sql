DROP TABLE HR.COURSES_TRAINERS CASCADE CONSTRAINTS;

CREATE TABLE HR.COURSES_TRAINERS
(
  TR_ID   NUMBER(7)                             NOT NULL,
  CRS_ID  NUMBER(7)                             NOT NULL
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
