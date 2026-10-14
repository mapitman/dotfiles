#!/usr/bin/env bash
#
# Opens markdown files in mdview once per turn instead of once per edit.
#
# Two modes, wired to two hook events in ~/.claude/settings.json:
#
#   record  PostToolUse on Write|Edit — queues the markdown path, opens nothing.
#   open    Stop — opens each queued file once, then clears the queue.
#
# A PostToolUse hook fires on every edit, so it cannot know whether Claude has
# finished with the file. Editing a document ten times used to open ten browser
# tabs, each showing a half-written draft. Queue now, open at the end of the turn.
#
# Which files qualify (unchanged from the original inline hook):
#   - must end in .md
#   - anything under a .claude/ directory is skipped, except .claude/plans/
#
# The queue is one file per session id, so concurrent sessions never open each
# other's documents. Never exits non-zero: a hook failure must not break a turn.

set -uo pipefail

QUEUE_DIR="${HOME}/.claude/.mdview-queue"

mode="${1:-}"
payload=$(cat)

session=$(printf '%s' "$payload" | jq -r '.session_id // "nosession"' 2>/dev/null)
# Guard against a session id containing a path separator.
session="${session//[^A-Za-z0-9_-]/_}"
[[ -z "$session" ]] && session="nosession"

queue="${QUEUE_DIR}/${session}"

case "$mode" in
    record)
        file=$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

        [[ -z "$file" ]] && exit 0
        [[ "$file" != *.md ]] && exit 0

        # Skip .claude/ internals, but keep plans — those are written for the user.
        if [[ "$file" == */.claude/* && "$file" != */.claude/plans/* ]]; then
            exit 0
        fi

        mkdir -p "$QUEUE_DIR" 2>/dev/null
        printf '%s\n' "$file" >> "$queue" 2>/dev/null
        ;;

    open)
        [[ -f "$queue" ]] || exit 0

        # Remove the queue first, so a failure below cannot strand it and
        # reopen the same files on the next turn.
        files=$(sort -u "$queue" 2>/dev/null)
        rm -f "$queue" 2>/dev/null

        while IFS= read -r file; do
            [[ -n "$file" && -f "$file" ]] && mdview "$file" >/dev/null 2>&1
        done <<< "$files"
        ;;
esac

exit 0
