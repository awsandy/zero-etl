CREATE TABLE ant307_das.cust_payment_tx_202301 AS
SELECT *
FROM ant307_external.cust_payment_tx_history
WHERE d_year = 2023 AND d_month = 1;
