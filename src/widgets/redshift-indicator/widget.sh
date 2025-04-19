#!/bin/sh
root=$(dirname "$0")/..
. "$root/common.sh"

redshift="$scripts_root/control/redshift"
cursor_pos=$(hyprctl cursorpos | sed 's/, /:/'):10


light-status \
    -i 'while true; do
            echo $('$redshift' value)%;
            sleep 0.2;
        done' \
    -l 50 -t 100 -w 100 -h 50 \
    -Xp $cursor_pos \
    &

light-status \
    -i 'while true; do
            '$redshift' enabled && echo 🌌 || echo 🌤️;
            sleep 0.2;
        done' \
    -l 160 -t 100 -w 50 -h 50 \
    -Tf "monospace:size=30" -Tt 1 \
    -Xp $cursor_pos \
    &

wait
