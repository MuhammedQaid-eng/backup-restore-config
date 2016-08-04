require "open3"
require_relative "vars"

# Scenario: Install dependencies
When(/^I install dependencies$/) do
	cmd = "ansible-playbook playbook.backup.yml -i host.ini --tags 'setup'"
	output, error, @status = Open3.capture3 "#{cmd}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

# Scenario: Set up Local Backup
When(/^I set up Local Backup$/) do
	cmd = "ansible-playbook playbook.backup.yml -i host.ini --tags 'local_backup'"
	output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Create S3 Bucket
When(/^I create S3 Bucket$/) do
	cmd = "ansible-playbook playbook.backup.yml -i host.ini --tags 'create_s3'"
	output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^the bucket should exists on AWS$/) do
	cmd = "aws s3 ls | grep #{BUCKETNAME}"
	output, error, @status = Open3.capture3 "#{cmd}"
	expect(status.success?).to eq(true)
  expect(output).to match("#{BUCKETNAME}")
end

# Scenario: Set up Remote Backup
When(/^I set up Remote Backup$/) do
	cmd = "ansible-playbook playbook.backup.yml -i host.ini --tags 'remote_backup'"
	output, error, @status = Open3.capture3 "#{cmd}"
end