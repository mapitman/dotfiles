# =============================================================================
# herdr — keep tab label in sync with current directory
# =============================================================================

# Herdr has no tab-title template, so the label is only settable via the CLI.
# Sets the tab label to "zsh:<dir>" at the prompt, and to the bare command
# name while one runs.

# True when this pane hosts an agent, whose tab label is set deliberately
# (e.g. "cache-token") and must not be overwritten. A pane's occupant cannot
# change for the life of this shell, so the answer is cached: the hooks below
# run on every prompt and must not spawn a subprocess each time.
_herdr_is_agent_pane() {
    if [[ -z $_HERDR_AGENT_CHECKED ]]; then
        local pane
        pane=$(herdr pane get "$HERDR_PANE_ID" 2>/dev/null)
        [[ $pane == *'"agent":'* ]] && _HERDR_IS_AGENT=1
        _HERDR_AGENT_CHECKED=1
    fi

    [[ -n $_HERDR_IS_AGENT ]]
}

_herdr_tab_rename() {
    [[ ${HERDR_ENV:-} == 1 && -n $HERDR_TAB_ID ]] || return
    _herdr_is_agent_pane && return
    herdr tab rename "$HERDR_TAB_ID" "$1" >/dev/null 2>&1
}

# Restores the directory label once a command finishes, so precmd undoes
# whatever preexec set.
_herdr_tab_name_shell() {
    local dir="${PWD/#$HOME/~}"
    dir="${dir##*/}"
    _herdr_tab_rename "zsh:$dir"
}

_herdr_tab_name_cmd() {
    local cmd="${1%% *}"  # just the command name, no args
    _herdr_tab_rename "$cmd"
}

chpwd_functions+=(_herdr_tab_name_shell)
precmd_functions+=(_herdr_tab_name_shell)
preexec_functions+=(_herdr_tab_name_cmd)
