bn=$(aws s3 ls | grep ri2023-ant307-file-store | awk '{print $3}')
cat << EOF > 24-create-model.sql
CREATE MODEL cust_cc_txn_fd
FROM (
    SELECT 
        TX_AMOUNT ,
        TX_FRAUD ,
        TX_DURING_WEEKEND ,
        TX_DURING_NIGHT ,
        CUSTOMER_ID_NB_TX_1DAY_WINDOW ,
        CUSTOMER_ID_AVG_AMOUNT_1DAY_WINDOW ,
        CUSTOMER_ID_NB_TX_7DAY_WINDOW ,
        CUSTOMER_ID_AVG_AMOUNT_7DAY_WINDOW ,
        CUSTOMER_ID_NB_TX_30DAY_WINDOW ,
        CUSTOMER_ID_AVG_AMOUNT_30DAY_WINDOW ,
        TERMINAL_ID_NB_TX_1DAY_WINDOW ,
        TERMINAL_ID_RISK_1DAY_WINDOW ,
        TERMINAL_ID_NB_TX_7DAY_WINDOW ,
        TERMINAL_ID_RISK_7DAY_WINDOW ,
        TERMINAL_ID_NB_TX_30DAY_WINDOW ,
        TERMINAL_ID_RISK_30DAY_WINDOW
    FROM cust_payment_tx_history
    WHERE cast(tx_datetime as date) BETWEEN '2022-06-01' AND '2022-09-30'
) 
TARGET tx_fraud
FUNCTION fn_customer_cc_fd
IAM_ROLE default
AUTO OFF
MODEL_TYPE XGBOOST
OBJECTIVE 'binary:logistic'
PREPROCESSORS 'none'
HYPERPARAMETERS DEFAULT EXCEPT (NUM_ROUND '100')
SETTINGS (
    S3_BUCKET '${bn}',
    S3_GARBAGE_COLLECT off,
    MAX_RUNTIME 1200
);
SHOW MODEL cust_cc_txn_fd;
EOF


export ENDPOINT=$(aws redshift-serverless  list-workgroups --query 'workgroups[].endpoint.address' --output text | grep zero-etl-destination)
export PGPASSWORD=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .password)
export PGUSER=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .username)
me=$(basename "$0")
fn=$(echo $me | cut -d '.' -f 1)
sfln="./24-create-model.sql"
echo "running $sfln"
psql dev -h $ENDPOINT -U $PGUSER -p 5439 -f $sfln
echo "done"

