#!/bin/bash

WINS=0
TOTAL=0

while read keypressed; do
    if [ -z $keypressed ]; then
        echo "No input!"
        continue
    fi

    if [ $keypressed == "w" ]; then
        ((TOTAL++))
        ((WINS++))
    elif [ $keypressed == "l" ]; then
        ((TOTAL++))
    else
        echo "Wrong input! (must be: w or l)"
        continue
    fi

    echo "Current: $WINS/$TOTAL"
done
