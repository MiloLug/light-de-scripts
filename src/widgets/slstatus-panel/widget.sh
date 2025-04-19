#!/bin/sh

cursor_pos=$(hyprctl cursorpos | sed 's/, /:/'):10

light-status \
    -i 'slstatus -s' \
    -l C -t U -b 100 -w 700 -h 50 \
    -Xp $cursor_pos
