Feature: Setup Local and Remote Backups

	Scenario: Install dependencies
		When I install dependencies
		Then it should be successfull

	Scenario: Set up Local Backup
		When I set up Local Backup
		Then it should be successfull

	Scenario: Create test Mysql database
		When I create test Mysql database
		Then it should be successfull
		And it should

	Scenario: Restore the local backups to the test database
		When I restore the local backups to the test database
		Then it should be successfull
		And it should

Compare the databases

	Scenario: Restore the local backups to the test database
		When I restore the local backups to the test database
		Then it should be successfull
		And it should


	Scenario: Create S3 Bucket
		When I create S3 Bucket
		Then it should be successfull
		And the bucket should exists on AWS

	Scenario: Set up Remote Backup
		When I set up Remote Backup
		Then it should be successfull