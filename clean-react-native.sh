#!/bin/bash
#clean-react-native.sh

watchman watch-del-all && rm -rf ios/build && rm -rf $TMPDIR/react-* && rm -rf $TMPDIR/react-native-packager-cache-* && rm -rf $TMPDIR/metro-cache-* && rm -rf $TMPDIR/metro-bundler-cache-* && rm -rf node_modules && yarn cache clean && yarn
