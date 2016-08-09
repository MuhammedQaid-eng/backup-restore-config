#!/bin/bash
set -ex

# variables
DB={{ db_name }}
TEST_DB={{ test_db }}
TEST_DB_USERNAME={{ test_db_username }}
TEST_DB_PASSWORD={{ test_db_password }}
CREATETESTDB="CREATE DATABASE $TEST_DB;"
DROPTESTDB="DROP DATABASE $TEST_DB;"

# automysqlbackup
/usr/sbin/automysqlbackup

# get last modified backup zip file
LASTBACKUP="$(ls /var/lib/automysqlbackup/daily/$DB/ -1t | head -1)"

# unzip it
gunzip "/var/lib/automysqlbackup/daily/$DB/${LASTBACKUP}"

# create test database
mysql -u $TEST_DB_USERNAME -p"${TEST_DB_PASSWORD}" -e "${CREATETESTDB}"

# get unzipped backup file
DBBACKUPFILE="$(ls /var/lib/automysqlbackup/daily/$DB/ -1t | head -1)"

# import the backup file into the test database
mysql -u $TEST_DB_USERNAME -p"${TEST_DB_PASSWORD}" $TEST_DB < /var/lib/automysqlbackup/daily/$DB/$DBBACKUPFILE

# compare the main database with the test database
mysqldbcompare --server1=${TEST_DB_USERNAME}:${TEST_DB_PASSWORD}@localhost $DB:$TEST_DB --run-all-tests --changes-for=server2 -a --difftype=sql
DBCOMPARESTATUS=$?

if [ $DBCOMPARESTATUS -eq 0 ]; then 
	gzip /var/lib/automysqlbackup/daily/$DB/${DBBACKUPFILE}
  {{ aws_path.stdout }} s3 mv /var/lib/automysqlbackup/daily/$DB/${DBBACKUPFILE}.gz s3://{{ s3_bucket_name }} --sse AES256
  rm -rf /var/lib/automysqlbackup/daily/$DB/*
  echo "Database backed up on s3"
else
	echo "Database back up failed"
	exit 1
fi

# drop the test database
mysql -u $TEST_DB_USERNAME -p"${TEST_DB_PASSWORD}" -e "${DROPTESTDB}"

