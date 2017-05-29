#!/bin/sh

# Don't forget to create the values for the User, Email variables.
# Maintainer = Jonas Dizon <jdizon@financeit.io>

HOST=127.0.0.1
USER=`cat /etc/.pass/.user`
PASSWORD=`cat /etc/.pass/.ptxt`
PORT=3337
SUBJECT="Looker Mysql replication is down in Canada"
EMAIL=`cat /etc/.pass/.email`

#Check if "Last_Error" is empty
RESULT=`mysql -u check --password=$PASSWORD -P 3337 -h 127.0.0.1 -e 'Show Slave Status\G' | grep Last_Error |  sed -e 's/ *Last_Error: //'`
if [ -n "$RESULT" ]; then
   echo "$RESULT" | mail -s "$SUBJECT" $EMAIL
fi

#Check if "Slave_IO is running"

RESULT=`mysql -u check --password=$PASSWORD -P 3337 -h 127.0.0.1 -e 'Show Slave Status\G' | grep Slave_IO_Running |  sed -e 's/ *Slave_IO_Running: //'`
if [ "$RESULT" != "Yes" ]; then
   echo " Slave_IO_running = $RESULT !" | mail -s "$SUBJECT" $EMAIL
fi

#Check if "Slave_SQL_ is running"

RESULT=`mysql -u check --password=$PASSWORD -P 3337 -h 127.0.0.1 -e 'Show Slave Status\G' | grep Slave_SQL_Running |  sed -e 's/ *Slave_SQL_Running: //'`
if [ "$RESULT" != "Yes" ]; then
   echo " Slave_SQL_Running = $RESULT !" | mail -s "$SUBJECT" $EMAIL
fi
