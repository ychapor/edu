#!/bin/bash
#
# Scenario of creating database backup.
#
# You have to create default configuration file named '.<your_db_name>.cnf'
# in your home directory or provide pathname of such file below in 'CREDENTIALS' in order to run the script.
# This file must contain your credentials to access the database.
#
# Example of .<your_db_name>.cnf:
# [mysqldump]
# user=mysql_user
# password=mysql_password

# Change these constants for backing up different DBs.
BACKUP_DIR=${HOME}/db_backups
DB_NAME=test_db
CREDENTIALS=${HOME}/.${DB_NAME}.cnf

if [[ ! -f /run/mysqld/mysqld.pid ]]; then
  echo "MySQL service is not running!" >&2
  exit 1
fi

mkdir -p ${BACKUP_DIR}
mysqldump --defaults-extra-file=CREDENTIALS --no-tablespaces ${DB_NAME} \
  > ${BACKUP_DIR}/${DB_NAME}_$(date +'%Y-%m-%d_%H:%M:%S').sql