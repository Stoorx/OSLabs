 #!/bin/bash

mail="[a-zA-Z0-9_.]+@[a-zA-Z0-9_]+(\\.[a-zA-Z]+)+"
grep -Ehsow $mail /etc/* | awk '{printf("%s, ",$1)}' | sed -E "s/,\s*$//" > emails.lst
