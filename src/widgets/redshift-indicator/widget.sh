#!/bin/sh
root=$(dirname "$0")/..
. "$root/common.sh"

redshift="$scripts_root/control/redshift"
monitor=$(get_focused_monitor)

light-status \
    -i 'while true; do
            echo $('$redshift' value)%;
            sleep 0.2;
        done' \
    -l 50 -t 100 -w 100 -h 50 \
    -Xd $monitor \
    &

light-status \
    -i 'while true; do
            '$redshift' enabled && echo 🌌 || echo 🌤️;
            sleep 0.2;
        done' \
    -l 160 -t 100 -w 50 -h 50 \
    -Tf "monospace:size=30" -Tt 1 \
    -Xd $monitor \
    &

wait
