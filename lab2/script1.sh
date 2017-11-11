#!/bin/bash
file=errors.log
grep -Ehr "ACPI" /var/log/ > $file
grep -E " /[A-Za-z0-9/]+[ \t$]" $file | less 
