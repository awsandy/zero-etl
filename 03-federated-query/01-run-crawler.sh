cn=$(aws glue list-crawlers --query 'CrawlerNames[]' | grep CustPay | tr -d ' |"|,')
aws glue start-crawler --name $cn