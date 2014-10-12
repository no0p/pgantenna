#!/bin/bash
service postgresql restart
# service pgantenna start
cron -f &
cd /opt/pgantenna; SECRET_KEY_BASE=`date | md5sum` RACK_ENV=production puma -p 80 config.ru &
cd /opt/pgantenna; ./start
