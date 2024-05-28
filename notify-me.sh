#!/bin/bash

{
    # get arguments
    whole_timer_string=$1   # timer value in HH:MM:SS
    shift                   # move arguments so that e.g. the 2nd arg is at the 1st position
    timer_description=$*    # description for the timer

    # seperate string into three time parts
    IFS=":" read -ra time_parts <<< "$whole_timer_string"

    hours="${time_parts[0]}"
    minutes="${time_parts[1]}"
    seconds="${time_parts[2]}"

    # check element count
    element_count=${#time_parts[@]}

    if [ $element_count != 3 ]; then
        echo "Invalid format: Use HH:MM:SS."
        exit 1
    fi

    # check for empty elements in array
    for ((i=0; i<${#time_parts[@]}; i++)); do
        # check if the current element is empty
        if [[ -z ${time_parts[i]} ]]; then
            echo "Invalid format: Element at index $i is empty. Use HH:MM:SS."
            exit 1
        fi

        # check if current element is not an integer
        if ! [[ ${time_parts[i]} =~ ^[0-9]+$ ]]; then
            echo "Invalid format: Element at index $i is not an integer."
            exit 1
        fi
    done

    # check if minutes and seconds have valid values
    if [ $minutes -gt 59 ] || [ $seconds -gt 59 ]; then
        echo "Invalid value: Value for minutes and/or seconds is greater than 59."
        exit 1
    fi

    if [ $hours -lt 0 ] || [ $minutes -lt 0 ] || [ $seconds -lt 0 ]; then
        echo "Invalid value: Value for hours, minutes and/or seconds is less than 0."
        exit 1
    fi

    # user input is valid, so notify the user of timer starting
    echo "Set timer for $hours hours, $minutes minutes and $seconds seconds."

    # calculate the total amount of seconds
    seconds_total=$(($seconds + 60 * $minutes + 3600 * $hours))

    # wait the total amount of seconds
    for ((i=$seconds_total; i > 0; i--)); do
        sleep 1
    done

    # send a notification
    notify-send "Timer has ended" "$timer_description"

    # play notificaton sound
    aplay ./assets/notification.wav > /dev/null 2>&1 # mute output

    # exit
    exit 0
} &