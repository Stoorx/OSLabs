#!/bin/bash

cat `ps aux | awk '{printf "/proc/%d/stat\n",$2}'` | awk '{printf "%d:%d\n", $1, ($23-$24-$24)/4096}' | less

#pid 3189 
#comm (gedit) 
#status R 
#ppid 1212 
#pgrp 1438 
#session 1438 
#tty 0 
#tpgid -1 
#flags 4194304 
#min_flt 3294 
#cmin_flt 0 
#maj_flt 0 
#cmaj_flt 0 
#utime 891 
#stime 89 
#cutime 0 
#cstime 0 
#counter 20 
#priority 0 
#timeout 5 
#it_real_value 0 
#start_time 428801 
#(23)vsize 598384640 
#rss 9874 
#25rlim 18446744073709551615 
#start_code 4194304 
#end_code 4198572 
#start_stack 140724259007072 
#kstk_esp 140724259006024 
#30kstk_eip 139717596203241 
#signal 0
#blocked 0 4096 0 0 0 0 17 0 0 0 3 0 0 6299072 6299824 36564992 140724259010644 140724259010703 140724259010703 #140724259012585 0
