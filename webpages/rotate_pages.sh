#!/bin/bash

TARGET="/usr/share/nginx/html/index.html"
SRC_DIR="/usr/share/nginx/html"

PAGES=("index1.html" "index2.html" "index3.html")

DURATION=300
INTERVAL=5

END_TIME=$((SECONDS + DURATION))

while [ $SECONDS -lt $END_TIME ]
do
  for page in "${PAGES[@]}"
  do
    QUOTE=$(/usr/games/fortune -s)

    awk -v q="$QUOTE" '{gsub(/{{QUOTE}}/, q)}1' "$SRC_DIR/$page" > "$TARGET"
    
    sleep $INTERVAL

    if [ $SECONDS -ge $END_TIME ]; then
      break
    fi
  done
done
