#!/bin/bash
# author: cesar.alcancio@gmail.com
# This script is to download logs from CloudWatch

scriptName=$0
if [ "$1" == "-h" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "--help" ]; then
    echo "Usage: $scriptName [logGroupName] [maxItems]"
    echo "Description: It needs to install the jq to parse JSON response from AWS CLI"
    echo "LogGroupName: CloudWatch logGroupName. Default: /ecs/prod1-service-loans"
    echo "MaxItems: Last Streams Name that the script will download. Default: 5. The 5 last items."
	echo "AWSProfile: AWS Profile with credentials to download the log from CloudWatch. Default: clip-prod."
    exit 1
fi

logGroupName=${1:-/ecs/prod1-service-loans}
maxItems=${2:-5}
AWSProfile=${3:-clip-prod}

# Create folder if it doesn't exist
mkdir -p ./local-logs/

# Getting the streams name
echo "Getting $maxItems streams for group $logGroupName using the profile $AWSProfile"
echo ""
logStreamsName=$(aws logs describe-log-streams --log-group-name $logGroupName --order-by LastEventTime --descending --max-items $maxItems --profile $AWSProfile --region us-west-2 | jq -r '.logStreams[].logStreamName')

echo "$logStreamsName" |
while read -r line; do
	logStreamName=$line
	logLocalFileName=${logStreamName//\//-}.log
	echo "Downloading log stream $logStreamName of group name $logGroupName into file $logLocalFileName"
	aws logs get-log-events --log-group-name $logGroupName --log-stream-name $logStreamName --profile clip-prod --region us-west-2 --output text > ./local-logs/$logLocalFileName
	count=0
	cat ./local-logs/$logLocalFileName |
	while read -r inline; do
		count=$((count + 1))
		json=${inline:21:${#inline}-14}}
		curl -XPOST http://localhost:12201/gelf -p0 -d "$json" --write-out '%{http_code}'
		echo "..."
	done
	echo "Finished log stream $logStreamName of group name $logGroupName into file $logLocalFileName"
	echo "..."
done

# AWS CLI commands
# aws logs describe-log-streams --log-group-name /ecs/dev1-service-loans --order-by LastEventTime --descending --max-items 5
# aws logs describe-log-streams --log-group-name /ecs/prod1-service-loans --order-by LastEventTime --descending --max-items 5 --profile clip-prod --region us-west-2
# aws logs get-log-events --log-group-name /ecs/dev1-service-loans --log-stream-name $logStreamName --output text > ./service-loans-logs/$logLocalFileName
# End commands
# /ecs/prod1-service-loans