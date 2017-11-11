#!/bin/bash
echo -ne "Выберите программу:\n1. Nano\n2. Vi\n3. Links\n4. Выход\n>>"
tmp=''
read tmp
case $tmp in
    1)
    nano
    ;;
    2)
    vi
    ;;
    3)
    links
    ;;
    4)
    echo "Пока!"
    exit 0
    ;;
esac
