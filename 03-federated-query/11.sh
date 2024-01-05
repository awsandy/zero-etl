export ENDPOINT=$(aws redshift-serverless  list-workgroups --query 'workgroups[].endpoint.address' --output text | grep zero-etl-destination)
export PGPASSWORD=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .password)
export PGUSER=$(aws secretsmanager get-secret-value --secret-id "RedshiftServerlessSecret" --query SecretString --output text | jq -r .username)
me=$(basename "$0")
fn=$(echo $me | cut -d '.' -f 1)
sfln=$(find . -name $fn*.sql)
echo $sfln
#psql dev -h $ENDPOINT -U $PGUSER -p 5439 -f $sfln

