#!/bin/bash

backup_dir=/data/fi_attachments/
logfile=/var/log/rsync_files.log

# echo a string to screen and log
function echo_and_log {
    logstring="[ `date` ] : $*"
    echo $logstring
    echo $logstring >> $logfile
}

# print error to screen and exit
function exit_with_error {
    echo_and_log "Error: $*"
    echo_and_log "Exit code: 1."
    exit 1
}



#Rsync paramaters -z is compress -r is recursive -a is archive mode
#IMPORTANT Note: RSYNC synchronizes one way Source --> Destination; If the paramater --delete is used, the files that do not exist on the source will be deleted on the destination.
transfer_command="rsync -z -r -a $backup_dir/ root@10.10.20.6:$backup_dir"

eval $transfer_command
if [ "$?" == "0" ]; then
  echo_and_log "Exit code: 0. Files transfered." > $logfile
else
  exit_with_error "Failed to rsync fi_attachments."
fi
