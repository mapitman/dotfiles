#!/bin/bash
input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name')

branch=$(git --no-optional-locks branch --show-current 2>/dev/null)

if [ -n "$branch" ]; then
  printf "\033[1;36m%s\033[0m on \033[1;33m%s\033[0m\n" "$model" "$branch"
else
  printf "\033[1;36m%s\033[0m\n" "$model"
fi
