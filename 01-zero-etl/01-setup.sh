sudo dnf upgrade --releasever=2023.3.20240108
nsn=$(aws redshift-serverless list-namespaces --query 'namespaces[].namespaceName' --output text | grep zero-etl)
echo $nsn
# namespace resource policy:
# set auth principal ARN User or Role - or Account ID
#
# set integration source ARN Arora MySQL DB Cluster
#( get form RDS, Databases, ant307* - Configuration Tab)
accn=$(aws sts get-caller-identity | jq -r '.Account')
srcarn=$(aws rds describe-db-clusters | jq -r '.DBClusters[] | select(.Engine=="aurora-mysql").DBClusterArn')
echo "set below values  in redshift serverless console - namespace, resource policy tab"
echo $accn
echo $srcarn



