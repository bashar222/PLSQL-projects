# PLSQL-projects


   ## Auto sequence project with trigger (project 1) : 

   ### The Auto sequence project with trigger project is an Oracle PL/SQL procedure that generates sequence triggers for all tables in a given schema that have a primary key of data type NUMBER. The procedure utilizes dynamic SQL to create a sequence for each table and then creates a row-level BEFORE INSERT trigger for that table, which populates the primary key column with the next sequence value.

  ### The project is designed to automate the creation of sequence triggers in Oracle databases, which can save time and effort for developers and DBAs who need to create primary keys for multiple tables. The procedure uses cursor and loop constructs to iterate through all relevant tables and dynamically generate the required SQL statements for creating sequences and triggers.

  ### The project can be run in any Oracle database environment where the user has privileges to execute PL/SQL procedures. The code is well-documented and can be customized to fit specific needs, such as adjusting the starting value and increment of the generated sequences.

  ### Overall, the "create_seq_trigger" project is a useful tool for streamlining the process of creating primary keys in Oracle databases and can help improve the efficiency and productivity of database development and maintenance tasks.
  
  ## -------------------------------------------------------------------------------------------------------------------------------------------------------
  





