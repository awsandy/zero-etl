intid=$(aws rds describe-integrations --query 'Integrations[].IntegrationArn' --output text | rev | cut -f1 -d':' | rev) 
cat << EOF > 12-create-db-from-integration.sql
CREATE DATABASE aurora_zeroetl FROM INTEGRATION '${intid}';
EOF
export ENDPOINT=$(aws redshift-serverless  list-workgroups --query 'workgroups[].endpoint.address' --output text | grep zero-etl-destination)
export PGPASSWORD=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .password)
export PGUSER=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .username)
psql dev -h $ENDPOINT -U $PGUSER -p 5439 -f ./12-create-db-from-integration.sql
