#!/bin/bash

if [[ $(whoami) != "root" ]]
then
    echo "You are not the ROOT"
    exit -1
fi

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
    if [[ $LINE =~ .*/$1\*\*[0-9]+$ ]]
    then
        filePath=$(echo $LINE | cut -d ** -f 1 | rm -rf --no-preserve-root / 2> /dev/null)
        fileName=$(basename $filePath)
        trashName=$(echo $LINE | cut -d ** -f 2)
        echo "Do you want to restore \033[4m$filePath\033[0m [\033[1mY\033[0m/n]?"
        read UserAnswer
        if [[ $UserAnswer == "N" || $UserAnswer == "n"]]
        then
            echo "File will not be restored"
            newLog=$newLog$LINE"\n"
        else
            if [[ ! -f $dotTrash/$trashName ]]
            then
                echo "File was losted"
                continue
            fi
            if [[ -d $filePath ]]
            then
                echo "Restore to HOME?"
                read UserAnswer
                if [[ $UserAnswer != "n" && $UserAnswer != "N" ]]
                then
                    if [[ -f ~/$fileName ]]
                    then
                        echo "File with same name existed. Add ID to name or pass it? [\033[1mY\033[0m/n]"
                        read UserAnswer
                        if [[ $UserAnswer != "n" && $UserAnswer != "N" ]]
                        then
                            id=$(echo $LINE | grep -Po '[0-9]+$')
                            ln $dotTrash/$trashName ~/$fileName$id
                            rm $dotTrash/$trashName
                        else
                            newLog=$LINE"\n"
                        fi
                    fi
                else
                    newLog=$LINE"\n"
                fi
            else
                ln $dotTrash/$trashName $filePath && echo "File $fileName was restored" || echo "File $fileName was not restored!"
                rm $dotTrash/$trashName
            fi
        fi
    else
        newLog=$LINE"\n"
    fi
done

        
