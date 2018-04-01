#!/bin/bash
LOCAL_DB="/Users/MC/Documents/Playgrounds/Mongo/data/db"

if [ $# -gt 0 ] && [ $1 = "auth" ]; then
  echo "----------------------"
  echo "starting DB with auth."
  echo "----------------------"
  mongod --auth --dbpath "$LOCAL_DB"
else
  mongod --dbpath "$LOCAL_DB"
fi

