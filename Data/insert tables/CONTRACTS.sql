SET DEFINE OFF;
Insert into HR.CONTRACTS
   (CONTRACT_ID, CONTRACT_STARTDATE, CONTRACT_ENDDATE, CONTRACT_TOTAL_FEES, CLIENT_ID, CONTRACT_PAYMENT_TYPE)
 Values
   (101, TO_DATE('01/01/2021 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/01/2023 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 500000, 
    1, 'ANNUAL');
Insert into HR.CONTRACTS
   (CONTRACT_ID, CONTRACT_STARTDATE, CONTRACT_ENDDATE, CONTRACT_TOTAL_FEES, CONTRACT_DEPOSIT_FEES, CLIENT_ID, CONTRACT_PAYMENT_TYPE)
 Values
   (102, TO_DATE('03/01/2021 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/01/2024 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 600000, 10000, 
    2, 'QUARTER');
Insert into HR.CONTRACTS
   (CONTRACT_ID, CONTRACT_STARTDATE, CONTRACT_ENDDATE, CONTRACT_TOTAL_FEES, CONTRACT_DEPOSIT_FEES, CLIENT_ID, CONTRACT_PAYMENT_TYPE)
 Values
   (103, TO_DATE('05/01/2021 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('05/01/2023 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 400000, 50000, 
    3, 'QUARTER');
Insert into HR.CONTRACTS
   (CONTRACT_ID, CONTRACT_STARTDATE, CONTRACT_ENDDATE, CONTRACT_TOTAL_FEES, CLIENT_ID, CONTRACT_PAYMENT_TYPE)
 Values
   (104, TO_DATE('03/01/2021 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('03/01/2024 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 700000, 
    2, 'MONTHLY');
Insert into HR.CONTRACTS
   (CONTRACT_ID, CONTRACT_STARTDATE, CONTRACT_ENDDATE, CONTRACT_TOTAL_FEES, CONTRACT_DEPOSIT_FEES, CLIENT_ID, CONTRACT_PAYMENT_TYPE)
 Values
   (105, TO_DATE('04/01/2021 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('04/01/2026 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 900000, 300000, 
    1, 'ANNUAL');
Insert into HR.CONTRACTS
   (CONTRACT_ID, CONTRACT_STARTDATE, CONTRACT_ENDDATE, CONTRACT_TOTAL_FEES, CONTRACT_DEPOSIT_FEES, CLIENT_ID, CONTRACT_PAYMENT_TYPE)
 Values
   (106, TO_DATE('01/01/2021 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/01/2026 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1000000, 200000, 
    2, 'HALF_ANNUAL');
COMMIT;
