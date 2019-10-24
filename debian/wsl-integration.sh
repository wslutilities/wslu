# set DISPLAY if there is an X11 server running
if which xvinfo > /dev/null && env DISPLAY=:0 xvinfo > /dev/null 2>&1; then
    export DISPLAY=:0
    export LIBGL_ALWAYS_INDIRECT=1
fi

# set up audio if pulse server is reachable only via tcp
if which pactl > /dev/null \
        && (! pactl info > /dev/null 2>&1 || pactl info 2> /dev/null | grep -q 'Default Sink: auto_null' ) \
        && env PULSE_SERVER=tcp:localhost pactl info > /dev/null 2>&1; then
    export PULSE_SERVER=tcp:localhost
fi
