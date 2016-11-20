#!/usr/bin/env sh

# Take a screenshot and blur it
image_file=/tmp/screen_lock.png
resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')
filters='noise=alls=10,scale=iw*.05:-1,scale=iw*20:-1:flags=neighbor'
#filters='noise=alls=10,gblur=sigma=8'
ffmpeg -y -loglevel 0 -s "$resolution" -f x11grab -i $DISPLAY -vframes 1 -vf "$filters" "$image_file"

revert() {
    xset dpms 0 0 0

    # Resume notifications
    pkill -USR2 dunst
}
trap revert SIGHUP SIGINT SIGTERM

# Turn the screen off 5 seconds after locking
xset +dpms dpms 5 5 5

# Pause notifications
pkill -USR1 dunst

i3lock \
    --nofork \
    --ignore-empty-password \
    --image="$image_file_out" \
    --clock \
    --timestr="%H:%M" \
    --datestr="%e %B %Y" \
    --line-uses-inside \
    --textcolor=ffffffff \
    --separatorcolor=ffffffff \
    --keyhlcolor=ffffffff \
    --bshlcolor=ffffffff \
    \
    --ringcolor=ffffff00 \
    --insidecolor=00000066 \
    \
    --ringvercolor=ffffff00 \
    --insidevercolor=00000066 \
    \
    --ringwrongcolor=ff0000ff \
    --insidewrongcolor=ff000066 \

revert
