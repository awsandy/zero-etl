intid=$(aws rds describe-integrations --query 'Integrations[].IntegrationArn' --output text | rev | cut -f1 -d':')
cat << EOF > 12-create-db-from-integration.sql
CREATE DATABASE aurora_zeroetl FROM INTEGRATION ${intid};
EOF