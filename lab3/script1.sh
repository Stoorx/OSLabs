#!/bin/bash

ps x | awk '{printf "%s:%s\n",$1,$5}' | sed "1d" > proc.tmp
wc -l < proc.tmp > proc.info
cat < proc.tmp >> proc.info
rm proc.tmp
