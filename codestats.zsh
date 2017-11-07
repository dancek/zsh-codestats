# zsh-codestats
# https://github.com/dancek/zsh-codestats

_codestats_version="0.1.1"

declare -g -i _codestats_keypress_count=0
declare -g -i _codestats_pulse_time=$(date +%s)

# Widget wrapper: add a keypress and call original widget
_codestats_call_widget()
{
    _codestats_keypress_count+=1
    builtin zle "$@"
}

# Rebind widgets
_codestats_rebind_widgets()
{
    local w
    for w in \
        self-insert \
        delete-char \
        backward-delete-char \
        accept-line
    do
        # call the internal version, ie. the one beginning with `.`
        eval "_codestats_${w} () { _codestats_call_widget .${w} -- \"\$@\" }"
        zle -N ${w} _codestats_${w}
    done
}

# Pulse sending function
_codestats_send_pulse()
{
    if (( ${_codestats_keypress_count} > 0 )); then
        local payload=$(_codestats_payload ${_codestats_keypress_count})

        curl \
            --header "Content-Type: application/json" \
            --header "X-API-Token: ${CODESTATS_API_KEY}" \
            --user-agent "zsh-codestats/${_codestats_version}" \
            --data "${payload}" \
            --silent \
            --output /dev/null \
            --show-error \
            --request POST \
            $(_codestats_pulse_url) \
            &|

        _codestats_keypress_count=0
    fi
}

_codestats_pulse_url()
{
    echo "${CODESTATS_API_URL:-https://codestats.net}/api/my/pulses"
}

# Create API payload
_codestats_payload()
{
    cat <<EOF
{
    "coded_at": "$(date +%Y-%m-%dT%H:%M:%S%z)",
    "xps": [{"language": "Terminal (Zsh)", "xp": $1}]
}
EOF
}

# Check time since last pulse; maybe send pulse
_codestats_poll()
{
    local now
    now=$(date +%s)
    if ((${now} - ${_codestats_pulse_time} > 10 )); then
        _codestats_send_pulse
        _codestats_pulse_time=${now}
    fi
}

_codestats_init()
{
    _codestats_rebind_widgets

    # Call the polling function on each new prompt
    autoload -U add-zsh-hook
    add-zsh-hook precmd _codestats_poll

    # FIXME: the last commands before zsh exit are not logged
}

if (( ${+CODESTATS_API_KEY} )); then
    _codestats_init
else
    echo "zsh-codestats requires CODESTATS_API_KEY to be set!"
    false
fi
