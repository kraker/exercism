#!/usr/bin/env bash

GIGASECOND=1000000000
START_DATE="$1"
SINCE_EPOCH="$(date --utc --date "$START_DATE" '+%s')"
DATE=$(bc -l <<< "$SINCE_EPOCH + $GIGASECOND")

date --utc "--date=@$DATE" '+%Y-%m-%dT%H:%M:%S'
