#!/bin/sh

# expect music passed in from mount, fail otherwise (mount not available?)
[ ! -d "/var/lib/mpd/music" ] && exit

# touch missing files
touch \
  /var/lib/mpd/tag_cache \
  /var/lib/mpd/state \
  /var/lib/mpd/sticker.sql

# fix permissions
chown -R mpd:audio /var/lib/mpd

# start mpd
exec mpd --no-daemon --stdout --verbose /var/lib/mpd/mpd.conf "$@"
