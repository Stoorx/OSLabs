#!/bin/bash

dotTrash="$HOME/.trash"
dotTrashLog="$HOME/.trash.log"

if [[ $# -ne 1 ]]
then
	echo "Incorrect parameters!"
	exit -1
fi

if [[ ! -d "$dotTrash" ]]
then
    	echo "Trash directory not found!"
    	exit -2
fi

filesForRestore=$(cat "$dotTrashLog" | egrep "/$1\*[0-9]+$")

IFS=$'\n'
for line in $filesForRestore
do
	filenamefull=$(echo "$line" | cut -d* -f1)
	filepath=$(dirname "$filenamefull")
	fileid=$(echo "$line" | cut -d* -f2)	

	echo -n "Restore $filenamefull? [Y/N]> "
	read userAnswer
	if [[ $userAnswer == "Y" || $userAnswer == "y" ]]
	then
		if [[ ! -d "$filepath" ]]
		then
			echo -n "Restore $1 to $HOME? [Y/N]> "			
			read userAnswer
			if [[ $userAnswer == "Y" || $userAnswer == "y" ]]
			then

				if [[ -f "$HOME/$1" ]]
				then
					echo -n "File is already exists. Add ID or relpace file? [A/R]> "
					read userAnswer
					if [[ $userAnswer == "A" || $userAnswer == "a" ]]
					then
						ln "$dotTrash/$fileid" "$HOME/$1.$fileid"
						rm -f "$dotTrash/$fileid"
						cat $dotTrashLog | egrep -v "\*$fileid$" > "tmp.tmp"
						cat "tmp.tmp" > $dotTrashLog
						rm -f "tmp.tmp"
						echo "File: $1 was restored successfully."
					else
						rm -f "$HOME/$1"
						ln "$dotTrash/$fileid" "$HOME/$1"
						rm -f "$dotTrash/$fileid"
						cat $dotTrashLog | egrep -v "\*$fileid$" > "tmp.tmp"
						cat "tmp.tmp" > $dotTrashLog
						rm -f "tmp.tmp"
						echo "File: $1 was restored successfully."
					fi
				else
					ln "$dotTrash/$fileid" "$HOME/$1"
					rm -f "$dotTrash/$fileid"
					cat $dotTrashLog | egrep -v "\*$fileid$" > "tmp.tmp"
					cat "tmp.tmp" > $dotTrashLog
					rm -f "tmp.tmp"
					echo "File: $1 was restored successfully."
				fi
			else
				echo "File: $filenamefull will not be restored."			
			fi			
		else
			if [[ -f $filenamefull ]]
			then
				echo -n "File is already exists. Add ID or relpace file? [A/R]> "
				read userAnswer				
				if [[ $userAnswer == "A" || $userAnswer == "a" ]]
				then
					ln "$dotTrash/$fileid" "$filenamefull.$fileid"
					rm -f "$dotTrash/$fileid"
					cat $dotTrashLog | egrep -v "\*$fileid$" > "tmp.tmp"
					cat "tmp.tmp" > $dotTrashLog
					rm -f "tmp.tmp"
					echo "File: $1 was restored successfully."
				else
					rm -f "$filenamefull"
					ln "$dotTrash/$fileid" "$filenamefull"
					rm -f "$dotTrash/$fileid"
					cat $dotTrashLog | egrep -v "\*$fileid$" > "tmp.tmp"
					cat "tmp.tmp" > $dotTrashLog
					rm -f "tmp.tmp"
					echo "File: $1 was restored successfully."
				fi
			else
				ln "$dotTrash/$fileid" "$filenamefull"
				rm -f "$dotTrash/$fileid"
				cat $dotTrashLog | egrep -v "\*$fileid$" > "tmp.tmp"
				cat "tmp.tmp" > $dotTrashLog
				rm -f "tmp.tmp"
				echo "File: $1 was restored successfully."
			fi
		fi
	else
		echo "File: $filenamefull will not be restored."
	fi
done


