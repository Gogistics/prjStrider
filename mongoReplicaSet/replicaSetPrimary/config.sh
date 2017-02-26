#!/bin/bash
# Program:
# Automation of dependencies installation
# Author: Alan Tai
# Date: 01/08/2017

source /myScripts/envVariables
echo "$PWD"

echo "rs.initiate()" >> auth.js
echo "rs.status()" >> auth.js
echo "sleep(3000)" >> auth.js
echo "use admin" >> auth.js
echo "db.createUser({user:'$ADMIN',pwd:'$ADMIN_PWD',roles:[{role:'userAdminAnyDatabase',db:'admin'}]})" >> auth.js
echo "db.auth('$ADMIN','$ADMIN_PWD')" >> auth.js
echo "db.createUser({user:'$ROOT_USER',pwd:'$ROOT_PWD',roles:[{role:'root',db:'admin'}]})" >> auth.js
echo "db.auth('$ROOT_USER','$ROOT_PWD')" >> auth.js
echo "use $STRIDER_DB" >> auth.js
echo "db.createUser({user:'$USER',pwd:'$USER_PWD',roles:[{role:'readWrite',db:'$STRIDER_DB'}]})" >> auth.js
echo "db.auth('$USER','$USER_PWD')" >> auth.js
echo "use admin" >> auth.js
echo "db.auth('$ROOT_USER','$ROOT_PWD')" >> auth.js
echo "rs.status()" >> auth.js
echo "rs.conf()" >> auth.js
echo "sleep(1000)" >> auth.js
echo "rs.add('$MONGO_RS_TWO_IP:27017')" >> auth.js
echo "sleep(1000)" >> auth.js
echo "rs.addArb('$MONGO_RS_ARBITER_IP:27017')" >> auth.js
echo "sleep(1000)" >> auth.js
echo "rs.status()" >> auth.js
echo "cfg = rs.conf()" >> auth.js
echo "cfg.members[0].host = '$MONGO_RS_ONE_IP:27017'" >> auth.js
echo "rs.reconfig(cfg)" >> auth.js
echo "sleep(2000)" >> auth.js
echo "rs.conf()" >> auth.js

# run script
mongo < auth.js

# restart supervisord
/etc/init.d/supervisor restart
