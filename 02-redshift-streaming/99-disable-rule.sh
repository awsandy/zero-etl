rn=$(aws events list-rules --query 'Rules[].Name' --output text | grep zeroetl)
aws events disable-rule --name $rn