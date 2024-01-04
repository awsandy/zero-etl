#PARAMETERS="[\
#    {\"name\": \"param1\", \"value\": \"${PARAM1}\"}, \
#    {\"name\": \"param2\", \"value\": \"${PARAM2}\"}, \
#    {\"name\": \"param3\", \"value\": \"${PARAM3}\"}, \
#    {\"name\": \"param4\", \"value\": \"${PARAM4}\"}, \
#    {\"name\": \"param5\", \"value\": \"${PARAM5}\"}, \
#    {\"name\": \"param6\", \"value\": \"${PARAM6}\"}\
#    ]"
CLUSTER_IDENTIFIER="zero-etl-destination-dw-wg-db265cc0.008088116876.us-west-2.redshift-serverless.amazonaws.com:5439/dev"
ENDPOINT=$(aws redshift-serverless  list-workgroups --query 'workgroups[].endpoint.address' --output text | grep zero-etl-destination)
#CREDENTIALS_ARN=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text)
CREDENTIALS_ARN=$(aws secretsmanager list-secrets --query 'SecretList[].ARN' | grep RedshiftServerless | tr -d ' |,|"')
SCRIPT_SQL=$(tr -d '\n' <./11-query-integration.sql)

AWS_RESPONSE=$(aws redshift-data execute-statement \
    --cluster-identifier $CLUSTER_IDENTIFIER \
    --sql "$SCRIPT_SQL" \
    --region us-west-2 \
    --database dev \
    --secret $CREDENTIALS_ARN)

# on EC2 instance
export PGPASSWORD=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .password)
export PGUSER=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .username)
psql dev -h $ENDPOINT -U $PGUSER -p 5439 -f ./01-zero-etl/11-query-integration.sql

