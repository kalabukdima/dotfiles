#!/bin/sh

player_bg="colour233"
player_fg="colour247"

line="#[fg=$player_bg]#[default, bg=$player_bg, fg=$player_fg]"
cmus_status="$(cmus-remote -C 'format_print \ %l\ -\ %n.\ %t')"
line+="${cmus_status:0:60} "

echo "$line"
