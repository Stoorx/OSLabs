 #!/bin/bash
inf="\\(II\\)"
war="\\(WW\\)"
grep -Ehs $war /var/log/Xorg.0.log | sed -E "s/$war/Warning: /" > full.log
grep -Ehs $inf /var/log/Xorg.0.log | sed -E "s/$inf/Information: /" >> full.log
