#!/bin/sh

battery_bg="colour234"

if grep -q "harging" /sys/class/power_supply/BAT0/status; then
    if grep -q "Discharging" /sys/class/power_supply/BAT0/status; then
        current=$(</sys/class/power_supply/BAT0/charge_now)
        full=$(</sys/class/power_supply/BAT0/charge_full)
        percentage=$(($current * 100 / $full))
        if [ $percentage -gt "63" ]; then
            battery_fg="colour70"
        elif [ $percentage -gt "17" ]; then
            battery_fg="colour142"
        else
            battery_fg="colour160"
        fi
    else
        current=$(</sys/class/power_supply/BAT0/charge_now)
        full=$(</sys/class/power_supply/BAT0/charge_full_design)
        percentage=$(($current * 100 / $full))
        battery_fg="colour33"
    fi
    line="#[fg=$battery_bg]#[bold, bg=$battery_bg, fg=$battery_fg] $percentage% "
fi

echo "$line"
