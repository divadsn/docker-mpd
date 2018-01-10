#!/bin/sh

# expect music passed in from mount, fail otherwise (mount not available?)
[ ! -d "/var/lib/mpd/music" ] && exit

# fix permissions
chown -R mpd:audio /var/lib/mpd
chown -R mpd:audio /run/mpd/

# start mpd
exec mpd --no-daemon --stdout --verbose /var/lib/mpd/mpd.conf "$@"
