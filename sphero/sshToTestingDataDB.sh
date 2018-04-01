#!/bin/bash

if [ $# -gt 0 ]; then
  ssh "$1"@188.166.241.172
else
  ssh root@188.166.241.172
fi
