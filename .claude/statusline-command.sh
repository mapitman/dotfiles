#!/usr/bin/env bash
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty' | sed "s|^$HOME|~|")
model=$(echo "$input" | jq -r '.model.display_name // empty')
style=$(echo "$input" | jq -r '.output_style.name // empty')
effort=$(echo "$input" | jq -r '.effort.level // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Git branch (suppresses errors when not in a git repo)
git_branch=$(git -C "$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')" \
    --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
branch_segment=""
if [ -n "$git_branch" ] && [ "$git_branch" != "HEAD" ]; then
    branch_segment=$(printf " \033[36m(%s)\033[0m" "$git_branch")
fi

# Build context usage segment
ctx_segment=""
if [ -n "$used_pct" ]; then
    used_int=$(printf '%.0f' "$used_pct")
    if [ "$used_int" -ge 75 ]; then
        ctx_color="\033[31m"   # red
    elif [ "$used_int" -ge 50 ]; then
        ctx_color="\033[33m"   # yellow
    else
        ctx_color="\033[32m"   # green
    fi
    ctx_segment=$(printf " ${ctx_color}ctx:%d%%\033[0m" "$used_int")
fi

# Rate limit segments (claude.ai subscribers only)
rate_segment=""
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
if [ -n "$five_pct" ] || [ -n "$week_pct" ]; then
    rate_segment=" |"
    if [ -n "$five_pct" ]; then
        rate_segment="$rate_segment $(printf '5h:%.0f%%' "$five_pct")"
    fi
    if [ -n "$week_pct" ]; then
        rate_segment="$rate_segment $(printf '7d:%.0f%%' "$week_pct")"
    fi
fi

# Build output style segment
style_segment=""
if [ -n "$style" ] && [ "$style" != "default" ]; then
    style_segment=$(printf " \033[96m[%s]\033[0m" "$style")
fi

# Build effort segment
effort_segment=""
if [ -n "$effort" ]; then
    effort_segment=$(printf " \033[32m%s\033[0m" "$effort")
fi

printf "\033[34m%s\033[0m%s | \033[35m%s\033[0m%s%s%s%s" "$cwd" "$branch_segment" "$model" "$style_segment" "$effort_segment" "$ctx_segment" "$rate_segment"
