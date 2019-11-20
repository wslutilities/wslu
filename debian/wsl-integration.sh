if type pactl > /dev/null 2>&1 || type xvinfo > /dev/null 2>&1; then
    # detect WSL host
    if type systemd-detect-virt > /dev/null 2>&1 && test "$(systemd-detect-virt -c)" != wsl -a -e /etc/resolv.conf; then
        WSL_HOST=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null)
    fi
    WSL_HOST=${WSL_HOST:-localhost}

    # set DISPLAY if there is an X11 server running
    if type xvinfo > /dev/null 2>&1 && env DISPLAY=${WSL_HOST}:0 xvinfo > /dev/null 2>&1; then
        export DISPLAY=${WSL_HOST}:0
        export LIBGL_ALWAYS_INDIRECT=1
    fi

    # set up audio if pulse server is reachable only via tcp
    if type pactl > /dev/null 2>&1 \
           && (! pactl info > /dev/null 2>&1 || pactl info 2> /dev/null | grep -q 'Default Sink: auto_null' ) \
           && env PULSE_SERVER=tcp:${WSL_HOST} pactl info > /dev/null 2>&1; then
        export PULSE_SERVER=tcp:${WSL_HOST}
    fi

    unset WSL_HOST
fi
