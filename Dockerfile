FROM debian:stretch-slim
MAINTAINER David Sn "divad.nnamtdeis@gmail.com"

RUN set -ex && \
    # Install mpd along with mpc for easy control
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        bash \
        mpc \
        mpd && \
    # Stop systemd service and setup directories
    service mpd stop && \
    mkdir -p \
        /run/mpd \
        /var/lib/mpd/music \
        /var/lib/mpd/playlists && \
    touch \
      /var/lib/mpd/tag_cache \
      /var/lib/mpd/state \
      /var/lib/mpd/sticker.sql && \
    # Fix permissions
    chown -R mpd:audio /run/mpd && \
    chown -R mpd:audio /var/lib/mpd && \
    # Clean-up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

USER mpd

VOLUME ["/var/lib/mpd/"]
COPY mpd.conf /var/lib/mpd/mpd.conf

EXPOSE 6600 8000
CMD ["mpd", "--no-daemon", "--stdout", "--verbose", "/var/lib/mpd/mpd.conf"]
