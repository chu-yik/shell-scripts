#!/bin/bash
#react-native-ios.sh

if [ "$1" = "debug" ]; then
    react-native run-ios --scheme 'hk01-debug'
else
    react-native run-ios --scheme 'hk01-release'
fi
