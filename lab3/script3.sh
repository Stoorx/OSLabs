#!/bin/bash

ps axu | grep -Es " /sbin/" | sort -rk9 | sed "1d" | sort -k9 | awk '{print $2}' > PIDs.info
