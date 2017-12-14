#!/bin/sh

gmail_bg="colour88"
gmail_fg="colour244"
vk_bg="colour25"
vk_fg="colour233"
player_bg="colour233"
player_fg="colour247"
battery_bg="colour234"
time_bg="colour236"
time_fg="colour155"

vk_update_interval=1800
gmail_update_interval=7200


line="#[bg=colour0]"

# Gmail {{{
gmail_status="/tmp/gmail_status"

function update_gmail_status {
    gmail_messages=$(/home/dima/space/scripts/mail.sh)
    if [[ $gmail_messages ]]; then
        echo $gmail_messages > $gmail_status
    fi
    echo $gmail_messages
}

gmail_messages=0
if [[ -f $gmail_status ]]; then
    last_update=$(($(date +%s) - $(stat -c %Y $gmail_status)))
    if [[ $last_update -gt $gmail_update_interval || $(<$gmail_status) -gt "0" ]]; then
        gmail_messages=$(update_gmail_status)
    else
        gmail_messages=$(<$gmail_status)
    fi
else
    gmail_messages=$(update_gmail_status)
fi

if [[ $gmail_messages -gt 0 ]]; then
    line+="#[fg=$gmail_bg]#[default, bg=$gmail_bg, fg=$gmail_fg]"
    line+="#[bold]✉ $gmail_messages "
fi
# }}}

# Vk {{{
vk_status="/tmp/vk_status"

function update_vk_status {
    vk_messages=$(/home/dima/space/scripts/vk.py)
    if [[ $vk_messages ]]; then
        echo $vk_messages > $vk_status
    fi
    echo $vk_messages
}

vk_messages=0
if [[ -f $vk_status ]]; then
    last_update=$(($(date +%s) - $(stat -c %Y $vk_status)))
    if [[ $last_update -gt $vk_update_interval || $(<$vk_status) -gt "0" ]]; then
        vk_messages=$(update_vk_status)
    else
        vk_messages=$(<$vk_status)
    fi
else
    vk_messages=$(update_vk_status)
fi

if [[ $vk_messages -gt 0 ]]; then
    line+="#[fg=$vk_bg]#[default, bg=$vk_bg, fg=$vk_fg]"
    line+="#[bold]vk: $vk_messages "
fi
# }}}

# Cmus {{{
line+="#[fg=$player_bg]#[default, bg=$player_bg, fg=$player_fg]"
cmus_status="$(cmus-remote -C 'format_print \ %l\ -\ %n.\ %t')"
line+="${cmus_status:0:60} "
# }}}

# Battery {{{
if grep -q "harging" /sys/class/power_supply/BAT0/status; then
    current=$(</sys/class/power_supply/BAT0/energy_now)
    full=$(</sys/class/power_supply/BAT0/energy_full)
    percentage=$(($current * 100 / $full))
    if [ $percentage -gt "63" ]; then
        battery_fg="colour70"
    elif [ $percentage -gt "17" ]; then
        battery_fg="colour142"
    else
        battery_fg="colour160"
    fi
    line+="#[fg=$battery_bg]#[bold, bg=$battery_bg, fg=$battery_fg]"
    line+=" $percentage% "
fi
# }}}

# Time {{{
line+="#[fg=$time_bg]#[bold, bg=$time_bg, fg=$time_fg]"
line+=" #(date +'%a %F %H:%M ')"
# }}}

echo $line

# vim:foldmethod=marker
