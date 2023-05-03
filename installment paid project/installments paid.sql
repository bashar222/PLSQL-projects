declare 

cursor client_cur is 
select  *
 from CLIENTS clt inner join contracts con
on CLT.CLIENT_ID = con.client_id ;

v_total number (20) ; 
v_months number (10) ; 
v_num_fees number(10) ;
v_inst_amount number(10,2) ; 
v_inst_date date ;
v_count number(8) ;

begin 

for v_record in client_cur loop 

    v_total := v_record.contract_total_fees - nvl(v_record.contract_deposit_fees, 0) ;
    v_months := months_between ( v_record.contract_enddate , v_record.contract_startdate ) ;
  
    v_num_fees := func_inst_amount ( v_record.contract_payment_type , v_months) ; 
        
        v_inst_amount := v_total / v_num_fees ;   
           v_inst_date := v_record.contract_startdate ;    
           v_count := v_num_fees ;
    while v_count > 0 
    loop
    
        -- while v_num_fees > 0 
        -- loop 
             
                 insert_inst_paid(v_record.contract_id , v_inst_date , v_inst_amount ) ; 
                
                v_total := v_total - v_inst_amount ; 
                --if v_inst_date < v_record.contract_enddate then 
                    v_inst_date := add_months( v_inst_date  , ( v_months / v_num_fees )) ;
                    v_count := v_count - 1 ;
                    
                --end if ;
                --end loop;
            
            
                
        end loop ; 
    
            
    end loop ;
    

end ;

