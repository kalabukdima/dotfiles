#!/bin/sh

time_bg="colour236"
time_fg="colour155"

line="#[fg=$time_bg]#[bold, bg=$time_bg, fg=$time_fg] #(date +'%a %F %H:%M ')"
echo "$line"
