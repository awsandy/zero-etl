CREATE TABLE cust_payment_tx_history
(
    TRANSACTION_ID integer,
    TX_DATETIME timestamp,
    CUSTOMER_ID integer,
    TERMINAL_ID integer,
    TX_AMOUNT decimal(9,2),
    TX_TIME_SECONDS integer,
    TX_TIME_DAYS integer,
    TX_FRAUD integer,
    TX_FRAUD_SCENARIO integer,
    TX_DURING_WEEKEND integer,
    TX_DURING_NIGHT integer,
    CUSTOMER_ID_NB_TX_1DAY_WINDOW decimal(9,2),
    CUSTOMER_ID_AVG_AMOUNT_1DAY_WINDOW decimal(9,2),
    CUSTOMER_ID_NB_TX_7DAY_WINDOW decimal(9,2),
    CUSTOMER_ID_AVG_AMOUNT_7DAY_WINDOW decimal(9,2),
    CUSTOMER_ID_NB_TX_30DAY_WINDOW decimal(9,2),
    CUSTOMER_ID_AVG_AMOUNT_30DAY_WINDOW decimal(9,2),
    TERMINAL_ID_NB_TX_1DAY_WINDOW decimal(9,2),
    TERMINAL_ID_RISK_1DAY_WINDOW decimal(9,2),
    TERMINAL_ID_NB_TX_7DAY_WINDOW decimal(9,2),
    TERMINAL_ID_RISK_7DAY_WINDOW decimal(9,2),
    TERMINAL_ID_NB_TX_30DAY_WINDOW decimal(9,2),
    TERMINAL_ID_RISK_30DAY_WINDOW decimal(9,2)
);

COPY cust_payment_tx_history
FROM 's3://redshift-immersionday-labs/ri2023/ant307/data/cust_payment_tx_history/'
IAM_ROLE default
PARQUET;
