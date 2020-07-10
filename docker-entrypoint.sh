#!/bin/sh
# https://stackoverflow.com/questions/25503412/how-do-i-know-when-my-docker-mysql-container-is-up-and-mysql-is-ready-for-taking
set -e

echo "run ..."

#DATASOURCE_URL="jdbc:mysql://127.0.0.1:3306/open_platform?characterEncoding=utf8&useSSL=true"
#DATASOURCE_URL="jdbc:mysql://127.0.0.1:3306/open_platform"
DATASOURCE_URL="jdbc:mysql://rds426h9unrjjen77935362.mysql.rds.aliyuncs.com/tm_show"
echo $DATABASE_HOST
DATABASE_HOST=$( expr $DATASOURCE_URL : '.*//\(.*\):.*' )

DATABASE_NAME=$( expr $DATASOURCE_URL : '.*:[0-9]\+/\([^?]*\)\(?.+\)\?' )
PORT=$( expr $DATASOURCE_URL : '.*:\([0-9]\+\)/.*')
echo $DATABASE_HOST

until nc -z -v -w30 $DATABASE_HOST $PORT
do
  echo "Waiting for database connection..."
  # wait for 5 seconds before check again
  sleep 5
done

echo "Mysql is up - executing command"

xmysql -h $DATABASE_HOST -p $DATABASE_PASSWORD -o $PORT -d $DATABASE_NAME -u $DATABASE_USER -r 0.0.0.0
