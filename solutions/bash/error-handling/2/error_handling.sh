#!/usr/bin/env bash

# try/catch in bash
(($# != 1)) && { 
  echo "Usage: ${0##*/} <person>" >&2
  exit 1 
} || { 
  echo "Hello, $1"
}

