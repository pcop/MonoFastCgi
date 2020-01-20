#!/bin/bash

function start_fastcgi {
  mkdir /var/log/mono/
  nginx &
  screen -dmS fastcgi fastcgi-mono-server4 /applications=/:/var/www/default /socket=tcp:127.0.0.1:9000 /logfile=/var/log/mono/fastcgi.log /printlog=True
  screen -dmS aspstate asp-state4
}

function wait_for_exit {
  while pgrep -f "fastcgi-mono-server4" > /dev/null; do
    /bin/sleep 1
  done
  echo "All fastcgi process have stopped."
}

start_fastcgi

echo "Listening for termination signals..."

wait_for_exit

