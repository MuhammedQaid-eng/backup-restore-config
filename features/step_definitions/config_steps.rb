require "open3"
require_relative "vars"

# Scenario: Install dependencies
When(/^I install dependencies$/) do
	cmd = "ansible-playbook playbook.backup.yml -i host.ini --private-key=#{PATHTOKEY} --tags 'setup'"
	output, error, @status = Open3.capture3 "#{cmd}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

# Scenario: Configure automysqlbackup
When(/^I configure automysqlbackup$/) do
	cmd = "ansible-playbook playbook.backup.yml -i host.ini --private-key=#{PATHTOKEY} --tags 'automysqlbackup_config'"
	output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Create S3 Bucket
When(/^I create S3 Bucket$/) do
	cmd = "ansible-playbook playbook.backup.yml -i host.ini --private-key=#{PATHTOKEY} --tags 'create_s3'"
	output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^the bucket should exists on AWS$/) do
	cmd = "aws s3 ls | grep #{BUCKETNAME}"
	output, error, status = Open3.capture3 "#{cmd}"
	expect(status.success?).to eq(true)
  expect(output).to match("#{BUCKETNAME}")
end

# Scenario: Encrypt the S3 bucket with a bucket policy
When(/^I encrypt the S3 bucket with a bucket policy$/) do
	cmd = "ansible-playbook playbook.backup.yml -i host.ini --private-key=#{PATHTOKEY} --tags 'encrypt_s3'"
	output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Copy backup bash script to remote server
When(/^I copy backup bash script to remote server$/) do
	cmd = "ansible-playbook playbook.backup.yml -i host.ini --private-key=#{PATHTOKEY} --tags 'copy_bash'"
	output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^the script should exists on the remote server$/) do
	cmd = "ssh -i '#{PATHTOKEY}' #{PUBDNS} 'sudo ls | grep bash.sh'"
	output, error, status = Open3.capture3 "#{cmd}"
	expect(status.success?).to eq(true)
  expect(output).to match("bash.sh")
end

# Scenario: Run cron job to set up recurring local and remote backups
When(/^I run cron job to set up recurring local and remote backups$/) do
	cmd = "ansible-playbook playbook.backup.yml -i host.ini --private-key=#{PATHTOKEY} --tags 'cron_job'"
	output, error, @status = Open3.capture3 "#{cmd}"
end




