#!/bin/sh

todo_file=~/docs/todo/todo.txt

while read -r current_line; do
    #skip if line empty
    [ -z "$current_line" ] && continue

    # check if task done- if it is, $is_done will be '-'
    is_done=$(echo "${current_line%% *}" | grep -e"x" - | tr 'x' '-' )
    # truncate off x
    current_line=${current_line#x }

    # check if has priority
    # TODO: handle cases of priority lower than I
    # what happens? UNDOCUMENTED BEHAVIOUR!!!
    has_priority=$(echo "${current_line%% *}" | tr 'ABCDEFGHI' '123456789' | grep "(.)")
    has_priority=$(echo "$has_priority" | sed "s/[()]//g")
    [ -z "$has_priority" ] && has_priority="0"
    current_line=${current_line#(*) }

    # Okay, so: there is between zero and two dates on the next two fields.
    # If there's two, only retain the latter.
    # (technically, this should only happen on "done" tasks.)
    # If there's one, retain it.
    # If there's none, just print the rest of the line.
    # TODO: handle todo things that start with a lot of dashes, like "cul-de-sac"
    date_1="${current_line%% *} "
    case $date_1 in
        *-*-*) current_line=${current_line#*-*-* }
            # check for second date
            date_2=${current_line%% *}
            case $date_2 in
                *-*-*)
                    current_line=${current_line#*-*-* }
                    date_1="$date_2 " #discard date 1, retain date 2
                    ;;
            esac
            ;;
        *) date_1="" ;; #no date 1
    esac

    echo "[$is_done$has_priority]" "$date_1$current_line"
done < $todo_file
