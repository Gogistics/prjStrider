#!/bin/bash
# Program:
# Automation of dependencies installation
# Author: Alan Tai
# Date: 01/08/2017

while true
do
  # set timestamp
  timestamp=$(date +"%s")
  backup_file_name="mongodump-$timestamp"
  # backup mongodb
  mongodump --db test --username $backup_user --password $user_pwd --out /data/backup/$backup_file_name
  sleep 6h
done
