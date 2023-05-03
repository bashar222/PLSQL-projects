ALTER TABLE HR.EMPLOYEES
 DROP PRIMARY KEY CASCADE;

DROP TABLE HR.EMPLOYEES CASCADE CONSTRAINTS;

CREATE TABLE HR.EMPLOYEES
(
  EMPLOYEE_ID     NUMBER(6),
  FIRST_NAME      VARCHAR2(20 BYTE),
  LAST_NAME       VARCHAR2(25 BYTE) CONSTRAINT EMP_LAST_NAME_NN NOT NULL,
  EMAIL           VARCHAR2(25 BYTE) CONSTRAINT EMP_EMAIL_NN NOT NULL,
  PHONE_NUMBER    VARCHAR2(20 BYTE),
  HIRE_DATE       DATE CONSTRAINT EMP_HIRE_DATE_NN NOT NULL,
  JOB_ID          VARCHAR2(10 BYTE) CONSTRAINT EMP_JOB_NN NOT NULL,
  SALARY          NUMBER(8,2),
  COMMISSION_PCT  NUMBER(2,2),
  MANAGER_ID      NUMBER(6),
  DEPARTMENT_ID   NUMBER(11),
  EMPLOYEE_NOTES  VARCHAR2(250 BYTE),
  RETIRED_BONUS   NUMBER(8,2),
  RETIRED         NUMBER(1)
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

COMMENT ON TABLE HR.EMPLOYEES IS 'employees table. Contains 107 rows. References with departments,
jobs, job_history tables. Contains a self reference.';

COMMENT ON COLUMN HR.EMPLOYEES.EMPLOYEE_ID IS 'dfkvjdmvfds';

COMMENT ON COLUMN HR.EMPLOYEES.FIRST_NAME IS 'First name of the employee. A not null column.';

COMMENT ON COLUMN HR.EMPLOYEES.LAST_NAME IS 'Last name of the employee. A not null column.';

COMMENT ON COLUMN HR.EMPLOYEES.EMAIL IS 'Email id of the employee';

COMMENT ON COLUMN HR.EMPLOYEES.PHONE_NUMBER IS 'Phone number of the employee; includes country code and area code';

COMMENT ON COLUMN HR.EMPLOYEES.HIRE_DATE IS 'Date when the employee started on this job. A not null column.';

COMMENT ON COLUMN HR.EMPLOYEES.JOB_ID IS 'Current job of the employee; foreign key to job_id column of the
jobs table. A not null column.';

COMMENT ON COLUMN HR.EMPLOYEES.SALARY IS 'Monthly salary of the employee. Must be greater
than zero (enforced by constraint emp_salary_min)';

COMMENT ON COLUMN HR.EMPLOYEES.COMMISSION_PCT IS 'Commission percentage of the employee; Only employees in sales
department elgible for commission percentage';

COMMENT ON COLUMN HR.EMPLOYEES.MANAGER_ID IS 'Manager id of the employee; has same domain as manager_id in
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)';

COMMENT ON COLUMN HR.EMPLOYEES.DEPARTMENT_ID IS 'Department id where employee works; foreign key to department_id
column of the departments table';


CREATE INDEX HR.EMP_DEPARTMENT_IX ON HR.EMPLOYEES
(DEPARTMENT_ID)
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


CREATE UNIQUE INDEX HR.EMP_EMAIL_UK ON HR.EMPLOYEES
(EMAIL)
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


CREATE UNIQUE INDEX HR.EMP_EMP_ID_PK ON HR.EMPLOYEES
(EMPLOYEE_ID)
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


CREATE INDEX HR.EMP_JOB_IX ON HR.EMPLOYEES
(JOB_ID)
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


CREATE INDEX HR.EMP_MANAGER_IX ON HR.EMPLOYEES
(MANAGER_ID)
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


CREATE INDEX HR.EMP_NAME_IX ON HR.EMPLOYEES
(LAST_NAME, FIRST_NAME)
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


CREATE OR REPLACE TRIGGER HR.secure_employees
  BEFORE INSERT OR UPDATE OR DELETE ON HR.EMPLOYEES 
DISABLE
BEGIN
  secure_dml;
END secure_employees;
/


CREATE OR REPLACE TRIGGER HR.update_job_history
  AFTER UPDATE OF job_id, department_id ON HR.EMPLOYEES   FOR EACH ROW
DISABLE
BEGIN
  add_job_history(:old.employee_id, :old.hire_date, sysdate,
                  :old.job_id, :old.department_id);
END;
/


CREATE OR REPLACE TRIGGER HR.upd_job_sal 
after insert or update ON HR.EMPLOYEES 
for each row
DISABLE
declare 

v_job_id number(8) ;
v_min number(8) ; 
v_max number(8) ; 

begin 
select job_id , min_salary , max_salary 
into v_job_id , v_min , v_max 
from jobs 
where job_id = :old.job_id ;
insert into control_jobs_sal 
(job_id , min_salary , max_salary ) 
values 
(v_job_id , v_min , v_max ) ;

end;
/


CREATE OR REPLACE TRIGGER HR.upd_jobs_store 
before update or insert of salary ON HR.EMPLOYEES 
for each row
DISABLE
declare 

v_min number(8) ; 
v_max number(8) ;
begin 
select min_salary , max_salary 
into v_min , v_max 
from jobs 
where job_id = :old.job_id ;
if :new.salary not between v_min and v_max then 
     raise_application_error( -20001, 'you should put the salary between  ' || v_min || ' and ' || v_max );
     end if ;
end ;
/


CREATE OR REPLACE TRIGGER HR.audit_user_r
after update of salary  ON HR.EMPLOYEES for each row
DISABLE
begin 
insert into emp_audit 
(employee_id , user_name , upd_time , old_sal , new_sal )
values 
(:new.employee_id , user , sysdate , :old.salary , :new.salary ) ;

end ;
/


CREATE OR REPLACE TRIGGER HR.check_hire_date_emp 
before insert or update of hire_date ON HR.EMPLOYEES 
for each row
DISABLE
declare 
v_notes varchar2(500) ; 
v_title varchar2(100) ; 
v_years number(8) ;

begin 

select job_title 
into v_title 
from jobs 
where job_id = :old.job_id ; 
v_notes := 'emp named ' || :old.first_name || ' last salary = ' || :old.salary || ', last job = ' || v_title ;

v_years := trunc(months_between(sysdate , :old.hire_date ) /12 ) ;

if v_years > 10 then 
  insert into retired_employees 
  (employee_id , retired_notes) 
  values 
  (:old.employee_id , v_notes ) ;
  end if ;

end ;
/


CREATE OR REPLACE TRIGGER HR.EMPLOYEES_trig  before insert ON HR.EMPLOYEES for each row
begin  :new.EMPLOYEE_ID := EMPLOYEES_SEQ.nextval ;   end ;
/


ALTER TABLE HR.EMPLOYEES ADD (
  CONSTRAINT EMP_SALARY_MIN
 CHECK (salary > 0),
  CONSTRAINT EMP_EMP_ID_PK
 PRIMARY KEY
 (EMPLOYEE_ID)
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
               ),
  CONSTRAINT EMP_EMAIL_UK
 UNIQUE (EMAIL)
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

ALTER TABLE HR.EMPLOYEES ADD (
  CONSTRAINT EMP_DEPT_FK 
 FOREIGN KEY (DEPARTMENT_ID) 
 REFERENCES HR.DEPARTMENTS (DEPARTMENT_ID),
  CONSTRAINT EMP_JOB_FK 
 FOREIGN KEY (JOB_ID) 
 REFERENCES HR.JOBS (JOB_ID),
  CONSTRAINT EMP_MANAGER_FK 
 FOREIGN KEY (MANAGER_ID) 
 REFERENCES HR.EMPLOYEES (EMPLOYEE_ID));
