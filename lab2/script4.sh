#!/bin/bash
p="/bin/*"
grep -Eohs  "^#!\s*/\S+$" $p | sed -E "s/^#!\s*(\/\S+)$/\1/" | awk '{w=tolower($1); a[w]++} END {for (k in a) {print k, a[k]}}' | sort -nrk 2 | sed 1q | tr -d "[0-9]$"


