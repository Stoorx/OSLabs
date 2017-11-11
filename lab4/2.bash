#!/bin/bash

at -f ./1.bash now+2minutes
tail -n 0 -f ~/report
