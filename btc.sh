#!/bin/bash
# Fetches current, opening BTC price from bitstamp
# and sends it via dbus to notification server 
# interval of half hour
INTERVAL=1800

function run {
  JSON=$(curl "https://www.bitstamp.net/api/v2/ticker/btcusd/")
  CURRENT=$(echo $JSON | jq '.last' | sed -e 's/^"//' -e 's/"$//')
  OPEN=$(echo $JSON | jq '.open' | sed -e 's/^"//' -e 's/"$//')
  PCT=$(bc -l <<< "scale=2;($CURRENT / $OPEN - 1) * 100")

  notify-send -i 'https://bitcoin.org/img/icons/opengraph.png' \
    "Bitcoin now: $CURRENT USD" \
    "Change $PCT\%"
}

run

# run periodically
if [[ "$1" == "--poll" ]]; then
  if [[ ! -z $2 ]]; then
    INTERVAL=$2;
  fi
  while [ 1 ]
  do
    sleep $INTERVAL;
    run
  done
fi

