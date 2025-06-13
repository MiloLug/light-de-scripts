#!/bin/sh

root=$(dirname "$0")/..
. "$root/common.sh"

sound="$scripts_root/control/sound"
monitor=$(get_focused_monitor)

light-status \
    -i 'while true; do
            echo $('$sound' value)%;
            sleep 0.2;
        done' \
    -l 50 -t 100 -w 100 -h 50 \
    -Xd $monitor \
    &

light-status \
    -i 'while true; do
            '$sound' muted && echo 🔇 || (test $('$sound' value) -gt 60 && echo 🔊 || echo 🔉);
            sleep 0.2;
        done' \
    -l 160 -t 100 -w 50 -h 50 \
    -Tf "monospace:size=30" -Tt 1 \
    -Xd $monitor \
    &

wait
