#!/bin/sh

bg="colour88"
fg="colour244"
update_interval=7200

gmail_status="/tmp/gmail_status"

function update_gmail_status {
    messages=$(~/config/scripts/mail.sh)
    if [[ $messages ]]; then
        echo $messages > $gmail_status
    fi
    echo $messages
}

messages=0
if [[ -f $gmail_status ]]; then
    last_update=$(($(date +%s) - $(stat -c %Y $gmail_status)))
    if [[ $last_update -gt $update_interval || $(<$gmail_status) -gt "0" ]]; then
        messages=$(update_gmail_status)
    else
        messages=$(<$gmail_status)
    fi
else
    messages=$(update_gmail_status)
fi

line=""
if [[ $messages -gt 0 ]]; then
    line+="#[fg=$bg]#[default, bg=$bg, fg=$fg]"
    line+="#[bold]✉ $messages "
fi

echo "$line"
