SELECT 
    count(1) 
FROM 
    cust_payment_tx_history;
----
SELECT 
    to_char(tx_datetime, 'YYYYMM') AS YearMonth,
    sum(case when tx_fraud=1 then 1 else 0 end) AS fraud_tx,
    sum(case when tx_fraud=0 then 1 else 0 end) AS non_fraud_tx,
    count(*) AS total_tx
FROM cust_payment_tx_history
GROUP BY YearMonth;
