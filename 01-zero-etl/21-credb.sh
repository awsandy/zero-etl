export ENDPOINT=$(aws rds describe-db-instances --query 'DBInstances[].Endpoint.Address' | grep ant307-zeroetl-sourceamscluster | tr -d ' |,|"')
export PGUSER=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .username)
export MYSQL_PWD=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .password)
mysql -h $ENDPOINT -P 3306 -u $PGUSER < 21-credb.sql