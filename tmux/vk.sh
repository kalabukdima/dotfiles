#!/bin/sh

bg="colour25"
fg="colour233"
update_interval=1800

vk_status="/tmp/vk_status"

function update_vk_status {
    messages=$(~/config/scripts/vk.py)
    if [[ $messages ]]; then
        echo $messages > $vk_status
    fi
    echo $messages
}

messages=0
if [[ -f $vk_status ]]; then
    last_update=$(($(date +%s) - $(stat -c %Y $vk_status)))
    if [[ $last_update -gt $update_interval || $(<$vk_status) -gt "0" ]]; then
        messages=$(update_vk_status)
    else
        messages=$(<$vk_status)
    fi
else
    messages=$(update_vk_status)
fi

line=""
if [[ $messages -gt 0 ]]; then
    line+="#[fg=$bg]#[default, bg=$bg, fg=$fg]"
    line+="#[bold]vk: $messages "
fi

echo "$line"
