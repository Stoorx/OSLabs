#!/bin/bash
ls -p /var/log | sed '/.*\//d' | awk '{ printf "%s\n\n", $1 }' > example.txt
less example.txt
