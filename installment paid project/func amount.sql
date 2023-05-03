create or replace function func_inst_amount ( v_payment_type varchar2 ,  v_months number )
return number   
is 

v_num_fees number(10) ;

begin  

 if v_payment_type = 'ANNUAL' then 
            v_num_fees := v_months / 12 ;
           
  elsif v_payment_type = 'QUARTER' then 
            v_num_fees := v_months / 3 ; 
            
  elsif v_payment_type = 'HALF_ANNUAL' then 
            v_num_fees := v_months / 6 ; 
            
  elsif v_payment_type = 'MONTHLY' then 
                v_num_fees := v_months  ; 
            
   end if ;
   
   return v_num_fees  ;
        
 end ;
 
 show errors; 