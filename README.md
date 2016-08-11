# BACKUP-RESTORE-CONFIG
This Ansible playbook:
  - Sets up recurring automatic backups of a MySQL database on a system
  - Sets up scripts to verify the backups to ensure it is valid and restorable
  - Sets up scripts to move the backup data to an external store (AWS S3)


**Requirements**

- Before running this playbook, you must have Python >= 2.6 installed on your local machine. Head over [here](http://docs.python-guide.org/en/latest/starting/install/osx/) to install Python.

**Clone The Project**
```
git clone https://github.com/andela-ayusuf/backup-restore-config.git
```

**Variables**

You will need to update the variables files i.e. **vars.yml** and **vars.rb** files with the appropriate variables. Currently there are only dummy variables in the variable files and this will not work. The **hosts.ini** file also has to be updated with the public IP address of the VM which is about to be configured.

**Running The Project**

From your terminal, enter into this project directory:

```
$ cd backup-restore-config
```
Run the playbook:
```
$ ansible-playbook playbook.backup.yml
```
OR
```
$ cucumber features/config.feature
```
And with that done, you have a set up a recurring config that backups you MySQL db locally and remotely on AWS S3.

**Issues**

If you happen to run into any problems while using this playbook or you would like to make contributions to it, please endeavour to open an issue [here](https://github.com/andela-ayusuf/backup-restore-config/issues).

Best regards :)