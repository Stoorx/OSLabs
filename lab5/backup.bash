#!/bin/bash

if [[ ! -d "~/source" ]]
then
    echo "$HOME/source not found!"
    exit 1
fi


currentDate=$(date +%s)
lastBackupDate=$(date -d "$(ls '~' | egrep 'Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}' | egrep -o '[0-9]{4}-[0-9]{2}-[0-9]{2}' | tail -n1)" +%s)

let difference=$currentDate-$lastBackupDate/604800

if [[ difference < 7 ]]
then
    log="$(date +'%F %T') $validBackupName is modified."
    newFiles=""
    renamedFiles=""

    validBackupName= $(ls '~' | egrep 'Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}' | tail -n1)
    validBackup=$(ls -R "~/$validBackupName")
    filesForBackup=$(ls -R "~/source")
    dateInRFC=$(date +%F)
    for FILE in $filesForBackup
    do
        if [[ ! -e "~/$validBackupName/$FILE" ]]
        then
            cp -t "~/source/$FILE" "~/$validBackupName/" && newFiles="$newFiles\n$FILE"
        else
            backupFileSize=$(wc -c ~/$validBackupName/$FILE | awk '{print $1}')
            fileSize=$(wc -c ~/source/$FILE | awk '{print $1}')
            
            if[[ $backupFileSize == $fileSize ]]
            then
                mv "~/$validBackupName/$FILE" "~/$validBackupName/$FILE.$dateInRFC" && cp "~/source/$FILE" "~/$validBackupName/$FILE" && renamedFiles="$renamedFiles\n$FILE $FILE.$dateInRFC"
            else
            fi
        fi
    done
    log="$log\nNew files:\n$newFiles\nRenamed files:\n$renamedFiles"
    echo -e $log >> "~/backup-report"
else
    backupName="Backup-$(date +%F)"
    echo "$(date +'%F %T') Try to make the $backupName"
    mkdir $backupName && echo "$(date +'%F %T') $backupName directory created." >> "~/backup-report" && cp -rxt "~/source/*" "~/backupName/" && echo "$(date +'%F %T') Copying done." >> "~/backup-report" && echo "$(date +'%F %T') Copied files:" >> "~/backup-report" && echo $(ls -RFC "~/$backupName") >> "~/backup-report" || echo "$(date +'%F %T') Backup error." 2> /dev/null
fi
