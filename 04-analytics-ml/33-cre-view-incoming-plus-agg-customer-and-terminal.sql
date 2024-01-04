CREATE VIEW public.cust_payment_tx_fraud_predictions
AS SELECT
    A.APPROXIMATE_ARRIVAL_TIMESTAMP,
    D.FULL_NAME, 
    D.EMAIL_ADDRESS, 
    D.PHONE_NUMBER,
    A.TRANSACTION_ID, 
    A.TX_DATETIME, 
    A.CUSTOMER_ID, 
    A.TERMINAL_ID,
    A.TX_AMOUNT ,
    A.TX_TIME_SECONDS ,
    A.TX_TIME_DAYS ,
    fn_customer_cc_fd(
        A.TX_AMOUNT ,
        A.TX_DURING_WEEKEND,
        A.TX_DURING_NIGHT,
        C.CUSTOMER_ID_NB_TX_1DAY_WINDOW ,
        C.CUSTOMER_ID_AVG_AMOUNT_1DAY_WINDOW ,
        C.CUSTOMER_ID_NB_TX_7DAY_WINDOW ,
        C.CUSTOMER_ID_AVG_AMOUNT_7DAY_WINDOW ,
        C.CUSTOMER_ID_NB_TX_30DAY_WINDOW ,
        C.CUSTOMER_ID_AVG_AMOUNT_30DAY_WINDOW ,
        T.TERMINAL_ID_NB_TX_1DAY_WINDOW ,
        T.TERMINAL_ID_RISK_1DAY_WINDOW ,
        T.TERMINAL_ID_NB_TX_7DAY_WINDOW ,
        T.TERMINAL_ID_RISK_7DAY_WINDOW ,
        T.TERMINAL_ID_NB_TX_30DAY_WINDOW ,
        T.TERMINAL_ID_RISK_30DAY_WINDOW
    ) FRAUD_PREDICTION
FROM(
    SELECT
        APPROXIMATE_ARRIVAL_TIMESTAMP,
        TRANSACTION_ID, 
        TX_DATETIME, 
        CUSTOMER_ID, 
        TERMINAL_ID,
        TX_AMOUNT,
        TX_TIME_SECONDS,
        TX_TIME_DAYS,
        CASE WHEN extract(dow from cast(TX_DATETIME as timestamp)) in (1,7) then 1 else 0 end as TX_DURING_WEEKEND,
        CASE WHEN extract(hour from cast(TX_DATETIME as timestamp)) BETWEEN 00 and 06 then 1 else 0 end as TX_DURING_NIGHT
    FROM public.cust_payment_tx_stream
) a
JOIN public.terminal_transformations t ON a.terminal_id = t.terminal_id
JOIN public.customer_transformations c ON a.customer_id = c.customer_id
JOIN postgres.customer_info d ON a.customer_id = d.customer_id
WITH NO SCHEMA BINDING;
