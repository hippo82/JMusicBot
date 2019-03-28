FROM ubuntu:18.04

ARG USER=jmusicbot
ARG GROUP=jmusicbot
ARG PUID=845
ARG PGID=845

ENV VERSION=0.2.2 \
    PLAYLIST=/jmusicbot/playlist \
	CONFIG=/jmusicbot/config 

RUN mkdir -p /opt /jmusicbot && \
    mkdir -p /opt /jmusicbot/playlist && \
	mkdir -p /opt /jmusicbot/config && \
    add-apt-repository ppa:webupd8team/java && \
	apt-get update && \
	apt-get install -y oracle-java8-installer && \
	wget --directory-prefix=/opt/jmusicbot/ https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-Linux.jar
	wget --directory-prefix=/opt/jmusicbot/config/ https://github.com/jagrosh/MusicBot/releases/download/$VERSION/config.txt
	wget --directory-prefix=/opt/jmusicbot/playlist/ https://github.com/jagrosh/MusicBot/releases/download/$VERSION/example_playlist.txt
    addgroup -g $PGID -S $GROUP && \
    adduser -u $PUID -G $GROUP -s /bin/sh -SDH $USER && \
    chown -R $USER:$GROUP /opt/jmusicbot /jmusicbot

VOLUME /jmusicbot

COPY files/ /

ENTRYPOINT ["/docker-entrypoint.sh"]
