export pgendp=$(aws rds describe-db-cluster-endpoints --query 'DBClusterEndpoints[].Endpoint' | grep aurorapg | tr -d ' |"|,')
export pgsecarn=$(aws secretsmanager list-secrets --query 'SecretList[].ARN' | grep aurora-pg | tr -d ' |"|,')
cat << EOF > 21-cre-ext-schema.sql
CREATE EXTERNAL SCHEMA postgres
FROM POSTGRES
DATABASE 'postgres'
URI '${pgendp}'
IAM_ROLE default
SECRET_ARN '${pgsecarn}'
EOF
echo "running 21-cre-ext-schema.sql"
export ENDPOINT=$(aws redshift-serverless  list-workgroups --query 'workgroups[].endpoint.address' --output text | grep zero-etl-destination)
export PGPASSWORD=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .password)
export PGUSER=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .username)
psql dev -h $ENDPOINT -U $PGUSER -p 5439 -f ./21-cre-ext-schema.sql