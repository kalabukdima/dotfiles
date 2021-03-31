#!/bin/sh

line="#[bg=colour0]"
line+="$(~/config/tmux/battery.sh)"
line+="$(~/config/tmux/time.sh)"

echo $line
