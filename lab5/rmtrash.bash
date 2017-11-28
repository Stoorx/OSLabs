#!/bin/bash

if [[ $# -ne 1 ]]
then
    echo "Incorrect parameters"
    exit -1
fi

#else

trashFile="$1"

if [[ -d "$trashFile" ]]
then
    echo "$trashFile -- this is catalog"
    exit -2
fi

if [[ ! -f "$trashFile" ]]
then
    echo "File not found"
    exit -3
fi

dotTrash="$HOME/.trash"
dotTrashLog="$HOME/.trash.log"
idStore="$dotTrash/.trashId"

if [[ ! -d "$dotTrash" ]]
then
    mkdir "$dotTrash"
    echo "1" > "$idStore"
fi

newId=$[$(cat "$idStore")+1]
echo "$newId" > "$idStore"

ln "./$trashFile" "$dotTrash/$newId"
echo "$PWD/$1*$newId" >> "$dotTrashLog"



rm -f "./$trashFile"

