#!/bin/bash
man bash | grep -ois "[a-zA-Z]\{4,\}" | tr "[:upper:]" "[:lower:]" | sort | uniq -c | sort -rn | head -3
