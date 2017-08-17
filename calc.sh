#!/bin/bash
# Calculator script, sends result as notification
# Easy to use from dmenu or rofi
# Usage: 
# calc.sh 12 + 3 * 12 * (32 + 3)
# => Shows notification with arguments and result

PARAM=$@
RES=$(bc <<< "$PARAM")

if [[ ! -z "$RES" ]]; then
  notify-send "$PARAM" "= $RES"
fi

