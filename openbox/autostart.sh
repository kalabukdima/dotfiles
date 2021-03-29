#!/bin/sh
xset r rate 200 37
xfce4-terminal --fullscreen -x tmux&
syndaemon -m 50 -i 0.35 -d -t
telegram-desktop&
xcape&
