#!/usr/bin/env bash

ICON_NORMAL=""
ICON_SILENT=""
ICON_WIFI=""
ICON_BT=""
ICON_NOINT="󰅛"

if ping -q -c 1 -W 1 8.8.8.8 >/dev/null 2>&1; then
    NET_ICON="$ICON_WIFI"
else
    NET_ICON="$ICON_NOINT"
fi

STATUS=$(swaync-client -D 2>/dev/null)

if [[ "$STATUS" == "true" ]]; then
    echo " $ICON_SILENT   $NET_ICON   $ICON_BT"
elif [[ "$STATUS" == "false" ]]; then
    echo " $ICON_NORMAL   $NET_ICON   $ICON_BT"
else
    echo " $ICON_NORMAL   $NET_ICON   $ICON_BT"
fi
