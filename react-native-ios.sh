#!/bin/bash
#react-native-ios.sh

if [ "$1" = "debug" ]; then
    react-native run-ios --scheme 'hk01-debug' --simulator='iPhone 6s'
elif [ "$1" = "iphonex" ]; then
    react-native run-ios --scheme 'hk01-release' --simulator='iPhone X'
else
    react-native run-ios --scheme 'hk01-release' --simulator='iPhone 6s'
fi
