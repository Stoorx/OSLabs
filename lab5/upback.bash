#!/bin/bash

backupName=$(ls "$HOME" | grep -oE "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" | tail -n1)

if [[ "$backupName" == "" ]] ;
then
    echo "Backup not found"
    exit 1
fi

mkdir -p --verbose "$HOME/restore"

for FILE in $(find "$HOME/$backupName/" -type f | grep -Ev '.[0-9]{4}-[0-9]{2}-[0-9]{2}$')
do 
    cp "$FILE" "$HOME/restore" && echo "File $(basename $FILE) was restored" 
done
echo "Upback completed."
