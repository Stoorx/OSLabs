#!/bin/bash
nice -n 7 ./inf1.bash &
nice -n 0 ./inf2.bash &
