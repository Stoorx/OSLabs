#!/bin/bash

dotTrash="~/.trash"
dotTrashLog="~/.trash.log"

if [[ ! -d $dotTrash ]]
then
    echo "Trash directory not found!"
    exit -2
fi

allLog=$(cat $dotTrashLog)

for LINE in $allLog
do
    if [[ $LINE == .*/$1\*[0-9]+$ ]]
    then
        filePath=$(echo $LINE | cut -d * -f 1 )
        fileName=$(basename $filePath)
        trashName=$(echo $LINE | cut -d * -f 2)
        echo "Do you want to restore $filePath [Y/N]?"
        read UserAnswer
        if [[ $UserAnswer == "N" || $UserAnswer == "n" ]]
        then
            echo "File will not be restored"
            newLog="$newLog$LINE\n"
        else #if user wants to restore
            if [[ ! -f $dotTrash/$trashName ]]
            then
                echo "File was losted"
                continue
            fi
            if [[ -d $filePath ]]
            then
                echo "Restore to HOME?"
                read UserAnswer
                if [[ $UserAnswer == "Y" || $UserAnswer == "y" ]]
                then
                    if [[ -f ~/$fileName ]] # if same file exists
                    then
                        echo "File with same name exists. Add ID to name or pass it? [Y/N]"
                        read UserAnswer
                        if [[ $UserAnswer == "Y" | $UserAnswer == "y" ]]
                        then
                            ln $dotTrash/$trashName ~/$fileName$trashName
                            rm $dotTrash/$trashName
                        else
                            newLog=$newLog$LINE"\n"
                        fi
                    fi
                else
                    newLog="$newLog$LINE\n"
                fi
            else
                ln $dotTrash/$trashName $filePath && echo "File $fileName was restored" || echo "File $fileName was not restored!"
                rm $dotTrash/$trashName
            fi
        fi
    else
        newLog=$newLog$LINE"\n"
    fi
done

echo $newLog > $dotTrashLog

        
