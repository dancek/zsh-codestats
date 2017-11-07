# zsh-codestats
# https://github.com/dancek/zsh-codestats

typeset -i _codestats_keypress_count
typeset -i _codestats_pulse_time

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
    for w in self-insert delete-char backward-delete-char accept-line
    do
        # call the internal version, ie. the one beginning with `.`
        eval "_codestats_${w} () { _codestats_call_widget .${w} -- \"\$@\" }"
        zle -N ${w} _codestats_${w}
    done
}

# Pulse sending function
_codestats_send_pulse()
{
    if [ $_codestats_keypress_count -gt 0 ]; then
        # TODO: http
        echo "Code::Stats keypress count: ${_codestats_keypress_count}"
        _codestats_keypress_count=0
    fi
}

# Check time since last pulse; maybe send pulse
_codestats_poll()
{
    local now=$(date +%s)
    if [ $((now - _codestats_pulse_time)) -gt 10 ]; then
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

_codestats_init
