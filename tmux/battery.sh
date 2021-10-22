#!/bin/sh

battery_bg="colour234"

status=$(acpi -b | awk -F '[ ,%]' '{print $3}')
percentage=$(acpi -b | awk -F '[ ,%]' '{print $5}')
if [ $status != "Full" ]; then
    if [ $status = "Discharging" ]; then
        if [ $percentage -gt "63" ]; then
            battery_fg="colour70"
        elif [ $percentage -gt "17" ]; then
            battery_fg="colour142"
        else
            battery_fg="colour160"
        fi
    else
        battery_fg="colour33"
    fi
    line="#[fg=$battery_bg]#[bold, bg=$battery_bg, fg=$battery_fg] $percentage% "
fi

echo "$line"
