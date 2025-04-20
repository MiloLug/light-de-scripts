scripts_root="$(dirname $0)/../.."

function get_focused_monitor() {
    hyprctl monitors all \
    | grep -E 'ID|at -?[0-9]+x|focused:' \
    | tr '\n' '|' \
    | sed -r 's/\|M/\nM/' \
    | grep 'focused: yes' \
    | sed -r 's/Monitor (.+) \(ID ([0-9]+)\):\|\s+([0-9]+)x([0-9]+)@.+ at (-?[0-9]+)x(-?[0-9]+)\|.*/\1:\2:\3:\4:\5:\6/' \
    | tr '\n' ','
}
