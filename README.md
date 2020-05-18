# Graylog
Download log from CloudWatch and upload to local GrayLog.

# Versions
Docker:
Docker version 18.09.2, build 6247962

Bash:
GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin18)
Copyright (C) 2007 Free Software Foundation, Inc.

# Run the run-docker-compose.sh
run-docker-compose.sh script will up Mongo DB, ElasticSearch and GrayLog

# Configure GELF INPUT
The GELF INPUT is to enable GrayLog to receive log using HTTP REQUESTS in JSON format.
![GELF INPUT](https://github.com/cesaralcancio/graylog/blob/master/images/graylog1.png?raw=true)

# Run the run-download-log-from-cloudwatch-upload-to-graylog.sh
run-download-log-from-cloudwatch-upload-to-graylog.sh script will download the logs from CloudWatch according to explicit params (or default params) and it will upload the logs to GELF HTTP port using the curl command.
Read "run-download-log-from-cloudwatch-upload-to-graylog.sh --help" for more information.

# Search the logs using the User Interface
![SEARCH LOG](https://github.com/cesaralcancio/graylog/blob/master/images/graylog2.png?raw=true)

# Kill all containers and data
Use the run-remove-docker-containers.sh script to kill all containers and data
