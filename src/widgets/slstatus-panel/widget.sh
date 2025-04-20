#!/bin/sh

root=$(dirname "$0")/..
. "$root/common.sh"

monitor=$(get_focused_monitor)

light-status \
    -i 'slstatus -s' \
    -l C -t U -b 100 -w 700 -h 50 \
    -Xd $monitor
