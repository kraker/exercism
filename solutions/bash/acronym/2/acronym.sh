#!/usr/bin/env bash

IFS=" -"
read -r -a phrase <<< "$1"

for word in "${phrase[@]}"; do
  word="${word//[^[:alpha:]]/}"
  acronym+="${word:0:1}"
done

echo "${acronym^^}"
