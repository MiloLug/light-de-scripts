#!/bin/sh
root=$(dirname "$0")/..
. "$root/common.sh"

backlight="$scripts_root/control/backlight"


light-status \
    -i 'while true; do
            echo $('$backlight' value)%;
            sleep 0.1;
        done' \
    -l 50 -t 100 -w 100 -h 50 \
    &

light-status \
    -i 'while true; do
            test $('$backlight' value) -gt 60 && echo 🔆 || echo 🔅;
            sleep 0.1;
        done' \
    -l 160 -t 100 -w 50 -h 50 \
    -Tf "monospace:size=30" -Tt 1 \
    &

wait
