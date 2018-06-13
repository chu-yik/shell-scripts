#!/bin/bash
#display.sh

if [ "$1" = "sit" ]; then
    displayplacer 'id:69733378 res:1680x1050 scaling:off origin:(0,0) degree:0' 'id:731408963 res:1080x1920 scaling:off origin:(1680,-870) degree:270'
else
    if [ "$1" = "stand" ]; then
        displayplacer 'id:69733378 res:1680x1050 scaling:off origin:(0,0) degree:0' 'id:731408963 res:1080x1920 scaling:off origin:(1680,0) degree:270'
    else
        echo 'USAGE: ./display.sh [sit|stand]'
    fi
fi
