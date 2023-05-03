create or replace procedure create_seq_trigger 
is
 
cursor seq_trigger is
   select con.table_name , con.constraint_name , concol.column_name 
    from user_constraints con inner join user_cons_columns concol
    on con.constraint_name = concol.constraint_name 
    inner join user_objects obj 
    on obj.object_name = concol.table_name 
    inner join user_tab_columns tbc 
    on tbc.column_name = concol.column_name and tbc.table_name = concol.table_name 
    where con.constraint_type = 'P' 
    and obj.object_type = 'TABLE' 
    and tbc.data_type = 'NUMBER' ;

v_max number(8) ;
seq_exists number(8);

begin 


for v_seq_trig in seq_trigger loop 
-- ?? ???? ????? 

 
 execute immediate 'select max('  ||  v_seq_trig.column_name || ')' || ' from '  || v_seq_trig.table_name into v_max  ;
 
select count(*) into seq_exists from all_sequences where sequence_name = v_seq_trig.table_name||'_SEQ';

if seq_exists > 0 then 
        execute immediate 'drop sequence ' || v_seq_trig.table_name || '_SEQ' ;
        
      end if ;
        
         execute immediate 'create sequence '   || v_seq_trig.table_name || '_SEQ ' ||   ' start with ' || v_max || ' increment by 1 ' ;
   
          execute immediate 'create or replace trigger '   ||  v_seq_trig.table_name || '_trig ' ||  ' before insert on '  ||  v_seq_trig.table_name || ' for each row  ' ||   ' begin ' ||   ' :new.'   || v_seq_trig.column_name || ' := '  || v_seq_trig.table_name || '_SEQ' || '.nextval ;   end ;' ;   
  end loop ;                                                       
   

end ;

show errors ;

------------------------------------------------------------------------------------------------------


