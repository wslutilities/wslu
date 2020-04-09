if [ "$HOME" == "/" ]; then
    CACHE_BASE="/tmp"
else
    CACHE_BASE="$HOME/.cache"
fi
WSL_INTEGRATION_CACHE="${CACHE_BASE}/wslu/integration"

if find -L "$WSL_INTEGRATION_CACHE" -newer /etc/resolv.conf 2> /dev/null | grep -q -m 1 '.'; then
    . $WSL_INTEGRATION_CACHE
elif type pactl > /dev/null 2>&1 || type xvinfo > /dev/null 2>&1; then
    # detect WSL host
    if type systemd-detect-virt > /dev/null 2>&1 && test "$(systemd-detect-virt -c)" != wsl -a -e /etc/resolv.conf; then
        WSL_HOST="$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null)"
        WSL_HOST_X_TIMEOUT=0.2
        WSL_HOST_PA_TIMEOUT=0.3
    else
        WSL_HOST="${WSL_HOST:-localhost}"
        WSL_HOST_X_TIMEOUT=0.6
        WSL_HOST_PA_TIMEOUT=0.8
    fi

    # create empty cache
    [ -d "${CACHE_BASE}/wslu" ] || mkdir -p "${CACHE_BASE}/wslu" 2> /dev/null
    echo -n "" > "$WSL_INTEGRATION_CACHE" 2> /dev/null

    # set DISPLAY if there is an X11 server running
    if type xvinfo > /dev/null 2>&1 && env DISPLAY="${WSL_HOST}:0" timeout "$WSL_HOST_X_TIMEOUT" xvinfo > /dev/null 2>&1; then
        export DISPLAY="${WSL_HOST}:0"
        export LIBGL_ALWAYS_INDIRECT=1
        echo -e "export DISPLAY=$DISPLAY\nexport LIBGL_ALWAYS_INDIRECT=1" >> "$WSL_INTEGRATION_CACHE" 2> /dev/null
    fi

    # set up audio if pulse server is reachable only via tcp
    if type pactl > /dev/null 2>&1 \
           && (! timeout "$WSL_HOST_PA_TIMEOUT" pactl info > /dev/null 2>&1 || timeout "$WSL_HOST_PA_TIMEOUT" pactl info 2> /dev/null | grep -q 'Default Sink: auto_null' ) \
           && env PULSE_SERVER="tcp:${WSL_HOST}" timeout "$WSL_HOST_PA_TIMEOUT" pactl stat > /dev/null 2>&1; then
        export PULSE_SERVER="tcp:${WSL_HOST}"
        echo -e "export PULSE_SERVER=$PULSE_SERVER" >> "$WSL_INTEGRATION_CACHE" 2> /dev/null
    fi

    unset WSL_HOST
    unset WSL_HOST_X_TIMEOUT
    unset WSL_HOST_PA_TIMEOUT
fi

unset WSL_INTEGRATION_CACHE
unset CACHE_BASE
