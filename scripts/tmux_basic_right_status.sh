#!/bin/sh

time_bg="colour236"
time_fg="colour155"

line="#[bg=colour0]"

# Time {{{
line+="#[fg=$time_bg]#[bold, bg=$time_bg, fg=$time_fg]"
line+=" #(date +'%a %F %H:%M ')"
# }}}

echo $line

# vim:foldmethod=marker
