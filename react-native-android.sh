#!/bin/bash
#react-native-android.sh

if [ "$1" = "staging" ]; then
    react-native run-android --variant='stagingdebug'
else 
    if [ "$1" = "release" ]; then
        react-native run-android --variant='productionrelease'
    else 
        react-native run-android --variant='productiondebug'
    fi
fi
