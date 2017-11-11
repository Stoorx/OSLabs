#!/bin/bash
mkdir test 2> /dev/null && echo "catalog test was created successfully" >> ~/report && touch "./test/$(ps --no-headers -p $$ -o lstart)"
ping "www.net_nikogo.ru" 2>> ~/report

