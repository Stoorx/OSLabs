#!/bin/bash

if [[ $# -ne 1 ]]
then
    echo "Incorrect parameters"
    exit -1
fi

#else

trashFile="$1"

dotTrash="~/.trash"
dotTrashLog="~/.trash.log"
idStore=$dotTrash"/.trashId"

if [[ ! -d $dotTrash]]
then
    mkdir $dotTrash
    echo "1" > "$idStore"
fi

newId=$($(cat $idStore)+1)
echo $newId > $idStore

ln "./$trashFile" $dotTrash/$newId

echo $PWD/$1**$newId >> $dotTrashLog
rm "./$trashFile"

