#!/bin/bash

if [[ ! -d "$HOME/source" ]]
then
    echo "$HOME/source not found!"
    exit 1
fi

lastPWD=$PWD
cd $HOME
currentDate=$(date +%s)

lastBackupName="$(ls $HOME | egrep 'Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}' | egrep -o '[0-9]{4}-[0-9]{2}-[0-9]{2}' | tail -n1)"

if [[ $lastBackupName == "" ]]
then
	lastBackupDate=0
else
	lastBackupDate=$(date -d $lastBackupName +%s)
fi

difference=$[$[$currentDate-$lastBackupDate]/604800]

if [[ difference < 7 ]]
then
    log="$(date +'%F %T') $validBackupName is modified."
    newFiles=""
    renamedFiles=""

    validBackupName=$(ls "$HOME" | egrep 'Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}' | tail -n1)
    validBackup=$(ls -R "$HOME/$validBackupName")
    filesForBackup=$(ls -R "$HOME/source")
    dateInRFC=$(date +%F)
    for FILE in $filesForBackup
    do

        if [[ ! -e "$HOME/$validBackupName/$FILE" ]]
        then
        	cp -tp "$HOME/source/$FILE" "$HOME/$validBackupName/"
		newFiles="$newFiles\n$FILE"
        else
            backupFileSize=$(wc -c $HOME/$validBackupName/$FILE | awk '{print $1}')
            fileSize=$(wc -c $HOME/source/$FILE | awk '{print $1}')
            
            if [[ $backupFileSize -ne $fileSize ]]
            then
                mv "$HOME/$validBackupName/$FILE" "$HOME/$validBackupName/$FILE.$dateInRFC" && cp -p "$HOME/source/$FILE" "$HOME/$validBackupName/$FILE" && renamedFiles="$renamedFiles\n$FILE $FILE.$dateInRFC"	
		
            fi
        fi
    done
    log="$log\nNew files:\n$newFiles\nRenamed files:\n$renamedFiles"
    echo -e $log >> "$HOME/backup-report"
else
    backupName="Backup-$(date +%F)"
    echo "$(date +'%F %T') Try to make the $backupName"
    mkdir $backupName
    echo "$(date +'%F %T') $backupName directory created." >> "$HOME/backup-report" 
	for file in $(find "$HOME/source" -depth -type f)
	do
	cp $file "$HOME/$backupName/" #2> /dev/null #|| ( echo "$(date +'%F %T') Backup error." 2> /dev/null && exit 1)
	done	
	echo "$(date +'%F %T') Copying done." >> "$HOME/backup-report"
	echo "$(date +'%F %T') Copied files:" >> "$HOME/backup-report"
	echo $(ls -RFC "$HOME/$backupName") >> "$HOME/backup-report"
fi
cd $lastPWD
