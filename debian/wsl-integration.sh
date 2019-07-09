# set DISPLAY if there is an X11 server running
if which xvinfo > /dev/null && env DISPLAY=:0 xvinfo > /dev/null 2>&1; then
    export DISPLAY=:0
    export LIBGL_ALWAYS_INDIRECT=1
fi
