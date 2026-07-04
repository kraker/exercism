#!/usr/bin/env bash

msg="Hello, $1"
err="Usage: error_handling.sh <person>"

(($# == 1)) && echo "$msg" && exit 0 || echo "$err" && exit 1

