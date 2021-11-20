FROM debian:buster-slim
ARG DEBIAN_FRONTEND=noninteractive

RUN useradd -m -s /bin/bash quake2 \
      && apt-get update \
      && apt-get install bash wget libcurl4-gnutls-dev -y \
      && dpkg --add-architecture i386 \
      && apt-get update \
      && apt-get install lib32gcc1 -y \
      && rm -rf /var/lib/apt/lists/*

ADD . /home/quake2
WORKDIR /home/quake2
RUN chown -R quake2:quake2 /home/quake2
USER quake2
RUN chmod +x /home/quake2/docker-entrypoint.sh

ENTRYPOINT ["/home/quake2/docker-entrypoint.sh"]
