#!/bin/sh
# shellcheck disable=SC2034

monitors="prim mon1"
primary_monitor="prim"

# Primary monitor
prim_port="eDP1"
prim_resolutions="1920x1080"

prim_1920x1080_args=""


# Monitor 1
mon1_port="HDMI-1-0"
mon1_resolutions="2560x1440 1920x1080"

mon1_2560x1440_args="--left-of $prim_port"
mon1_1920x1080_args="--left-of $prim_port"
