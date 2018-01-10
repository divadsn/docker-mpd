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
        /var/lib/mpd/music \
        /var/lib/mpd/playlists && \
    touch /var/lib/mpd/{tag_cache,state,sticker.sql} && \
    # Clean-up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

USER mpd

VOLUME ["/var/lib/mpd/"]
COPY mpd.conf /var/lib/mpd/mpd.conf

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
