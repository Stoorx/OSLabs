#!/bin/bash
 
ps axu | sed '1d' | tail -n7 | head -n1 | awk '{print $2, $9}'
