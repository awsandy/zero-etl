SELECT TO_CHAR(TX_DATETIME, 'YYYY-MM-DD'),sum(tx_fraud)
FROM ant307_external.cust_payment_tx_history
WHERE d_year = 2023 and d_month = 01
GROUP BY 1
ORDER BY 2 desc;
