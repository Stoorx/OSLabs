#!/bin/bash

lastBackupName=$(ls '~' | egrep 'Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}' | tail -n1)
if [[ $lastBackupName == "" ]]
then
    echo "The valid backup not found!"
    exit 1
fi

if [[ ! -d "~/restore"]]
then
    mkdir "~/restore" || exit 2
fi

filesForCopy=$(ls -r "~/$lastBackupName" | egrep -v '.[0-9]{4}-[0-9]{2}-[0-9]{2}$')
cp -rxtp "~/$lastBackupName/$filesForCopy" "~/restore/" && echo "Upback done!"