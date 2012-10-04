#!/bin/bash
RECIPIENT=youremail@yourdomainnamehere.com
mysqlcheck --user=admin --password=password --optimize --all-databases | grep -i '^error' > /tmp/mysql-check-errors.txt

result=$?
if [ $result -ne 1 ]; then
  SUBJECT="$HOSTNAME: MySQL DB Optimisation Check Failed"
  cat /tmp/mysql-check-errors.txt mail -s "$SUBJECT" RECIPIENT
  rm -rf /tmp/mysql-check-errors.txt
  exit 1
fi
