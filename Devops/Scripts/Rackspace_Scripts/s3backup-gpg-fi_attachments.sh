#!/bin/bash

#Backup to AWS:23 AES-256 Serverside and locl with GPG

# Backup directory specific
loca="fi_attachments"
basedir="/data"
s3path="fi-attachments"

# Largely static (server specific at least)
hashdir="/var/backuphashes-fi_attachments"


cd $basedir/$loca

if [ ! -d "$hashdir/$loca" ]
then
        mkdir -p "$hashdir/$loca"
fi

#Find all files within this directory and it's subdirs
find * -type f | while read -r a
do

        fnamehash=`echo "$a" | sha1sum | cut -d\  -f1`
        filehash=`sha1sum "$a" | cut -d\  -f1`
        source "$hashdir/$loca/$fnamehash" 2> /dev/null

        if [ "$filehash" != "$storedhash" ]
        then
                /usr/bin/s3cmd put -e $a s3://$s3path/$loca/$a
                echo "storedhash='$filehash'" > "$hashdir/$loca/$fnamehash"
        else
                # Hashes match, no need to push
                echo "$a unchanged, skipping......"
        fi

done
