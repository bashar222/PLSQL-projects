# PLSQL-projects


   ## Auto sequence project with trigger (project 1) : 

   ### The Auto sequence project with trigger project is an Oracle PL/SQL procedure that generates sequence triggers for all tables in a given schema that have a primary key of data type NUMBER. The procedure utilizes dynamic SQL to create a sequence for each table and then creates a row-level BEFORE INSERT trigger for that table, which populates the primary key column with the next sequence value.

  ### The project is designed to automate the creation of sequence triggers in Oracle databases, which can save time and effort for developers and DBAs who need to create primary keys for multiple tables. The procedure uses cursor and loop constructs to iterate through all relevant tables and dynamically generate the required SQL statements for creating sequences and triggers.

  ### The project can be run in any Oracle database environment where the user has privileges to execute PL/SQL procedures. The code is well-documented and can be customized to fit specific needs, such as adjusting the starting value and increment of the generated sequences.

  ### Overall, the "create_seq_trigger" project is a useful tool for streamlining the process of creating primary keys in Oracle databases and can help improve the efficiency and productivity of database development and maintenance tasks.
  
  ## -------------------------------------------------------------------------------------------------------------------------
  
  ## installment paid project (project 2 ) : 
  
  ### This project is a PL/SQL script for automating the insertion of installment payments into a database table called installments_paid. The script is made up of three parts: a function to calculate the number of installment payments for a given contract, a procedure to insert a new installment payment into the installments_paid table, and a main program that uses a cursor to loop through all contracts and insert the corresponding installment payments.

### The func_inst_amount function takes in two parameters: the payment type (annual, quarterly, half-annual, or monthly) and the number of months between the start and end dates of a contract. Based on the payment type, it calculates the number of installment payments required and returns this value.

### The insert_inst_paid procedure takes in four parameters: the contract ID, the installment date, the installment amount, and an optional parameter indicating whether the installment has already been paid. This procedure inserts a new record into the installments_paid table with the provided values.

### The main program uses a cursor to loop through all contracts and calculate the corresponding installment payments using the func_inst_amount function. It then uses the insert_inst_paid procedure to insert each installment payment into the installments_paid table.

### This project can be useful for automating the process of adding installment payments to a database table, saving time and reducing the risk of errors. The code can be modified as needed to fit specific requirements and can be easily integrated into existing PL/SQL scripts.
  





