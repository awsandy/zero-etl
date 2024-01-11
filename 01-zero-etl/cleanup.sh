intid=$(aws rds describe-integrations --query 'Integrations[].IntegrationArn' --output text | rev | cut -f1 -d':' | rev) 
aws rds delete-integration -integration-identifier $intid
sleep 10
export ENDPOINT=$(aws redshift-serverless  list-workgroups --query 'workgroups[].endpoint.address' --output text | grep zero-etl-destination)
export PGPASSWORD=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .password)
export PGUSER=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .username)
psql dev -h $ENDPOINT -U $PGUSER -p 5439 -f ./cleanup1.sql
export ENDPOINT=$(aws rds describe-db-instances --query 'DBInstances[].Endpoint.Address' | grep ant307-zeroetl-sourceamscluster | tr -d ' |,|"')
export PGUSER=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .username)
export MYSQL_PWD=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .password)
echo "create demodb in rds mysql"
mysql -h $ENDPOINT -P 3306 -u $PGUSER < cleanup2.sql