LAMBDA=`aws lambda list-functions --query 'Functions[*].FunctionName' --output text | tr '\t' '\n' | fzf`
LOG_GROUP="/aws/lambda/$LAMBDA"
LOG_STREAM=`aws logs describe-log-streams --log-group-name "$LOG_GROUP" --query 'logStreams[].logStreamName' --output text --max-items 10 --descending | tr '\t' '\n' | fzf`
LOG=`aws logs get-log-events --log-group-name "$LOG_GROUP" --log-stream-name "$LOG_STREAM" --output text --query 'events[].message'`
echo "$LOG"