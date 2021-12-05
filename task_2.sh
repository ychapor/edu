#!/bin/bash
#
# Scenario of creating database backup.
#
# You have to create default configuration file named '.<yourDBname>.cnf'
# in your home directory in order to run the script.
# This file must contain your credentials to access the database.
#
# Example of .<yourDBname>.cnf:
# [mysqldump]
# user=mysqluser
# password=secret

# Change these constants for backuping different DBs.
DB_NAME=test_db
BACKUP_DIR=$HOME/db_backups

if [[ ! -f /run/mysqld/mysqld.pid ]]; then
  echo "MySQL service is not running!" >&2
  exit 1
fi

mkdir -p ${BACKUP_DIR}
mysqldump --defaults-extra-file=${HOME}/.${DB_NAME}.cnf --no-tablespaces ${DB_NAME} \
  > ${BACKUP_DIR}/${DB_NAME}_$(date +'%Y-%m-%d_%H:%M:%S').sql