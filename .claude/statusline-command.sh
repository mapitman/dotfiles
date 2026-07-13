#!/bin/bash
input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name')
context_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
effort=$(echo "$input" | jq -r '.effort.level // empty')

branch=$(git --no-optional-locks branch --show-current 2>/dev/null)

status="\033[1;36m${model}\033[0m"

if [ -n "$effort" ]; then
  status="${status}   \033[1;32m${effort}\033[0m"
fi

if [ -n "$context_pct" ]; then
  status="${status}   \033[1;35m${context_pct}%% ctx\033[0m"
fi

if [ -n "$branch" ]; then
  status="${status}   on \033[1;33m${branch}\033[0m"
fi

printf "${status}\n"
