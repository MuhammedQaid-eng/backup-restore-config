Feature: Setup Local and Remote Backups

	Scenario: Install dependencies
		When I install dependencies
		Then it should be successful

	Scenario: Configure automysqlbackup
		When I configure automysqlbackup
		Then it should be successful

	Scenario: Create S3 Bucket
		When I create S3 Bucket
		Then it should be successful
		And the bucket should exists on AWS

	Scenario: Encrypt the S3 bucket with a bucket policy
		When I encrypt the S3 bucket with a bucket policy
		Then it should be successful

	Scenario: Copy backup bash script to remote server
		When I copy backup bash script to remote server
		Then it should be successful
		And the script should exists on the remote server

	Scenario: Run cron job to set up recurring local and remote backups
		When I run cron job to set up recurring local and remote backups
		Then it should be successful