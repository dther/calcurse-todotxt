#!/bin/sh

calcurse_todo=~/.local/share/calcurse/todo
date="$(date +%Y-%m-%d)"

while read -r current_task; do
    # Get the one field that tells us everything we need to know...
    task_status=${current_task%% *}
    # strip it off so that we have the task itself
    current_task=${current_task#* }

    # Remove the hash string if it exists, we won't need it.
    task_status=${task_status%%>*}
    # faster than sed...
    task_status=${task_status%]}
    task_status=${task_status#[}

    # change priority number to todotxt letter + parens
    priority="($(echo "${task_status#-}" | tr '1-9' 'A-I')) "
    [ "$priority" = "(0) " ] && priority=""

    # change calcurse done flag to todotxt done flag
    is_done=${task_status%[0-9]}
    [ -z "$is_done" ] || is_done="x "

    # if done, add today's date
    [ -z "$is_done" ] || add_date="$date "

    echo "$is_done$priority$add_date$current_task"
done < $calcurse_todo
