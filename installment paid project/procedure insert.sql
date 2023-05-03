 create or replace procedure insert_inst_paid ( v_contract_id number , v_inst_date date , v_inst_amount varchar2 , v_paid number default 0 ) 
 is 
 
 begin 
 
              insert into installments_paid
                (installment_id , contract_id , installment_date , installment_amount , paid)
                values 
                (INSTALLMENTS_PAID_SEQ.nextval , v_contract_id , v_inst_date  , v_inst_amount , v_paid ) ; 
                
 end ;