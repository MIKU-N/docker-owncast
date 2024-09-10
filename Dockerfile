FROM jrottenberg/ffmpeg:4.4.5-vaapi2204

LABEL org.opencontainers.image.authors="hi@im.ci"
LABEL org.opencontainers.image.source="https://github.com/MIKU-N/docker-owncast"

ARG MEDIA_DRV_VERSION=21.2.3

RUN apt-get update && \
	apt-get -y install --no-install-recommends wget jq unzip mesa-va-drivers && \
	wget -O /tmp/intel-media.tar.gz https://github.com/ich777/media-driver/releases/download/intel-media-${MEDIA_DRV_VERSION}/intel-media-${MEDIA_DRV_VERSION}.tar.gz && \
	cd /tmp && \
	tar -C / -xvf /tmp/intel-media.tar.gz && \
	rm -rf /tmp/intel-media.tar.gz && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR=/owncast
ENV START_PARAMS=""
ENV OWNCAST_V="latest"
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV DATA_PERM=770

RUN mkdir $DATA_DIR

ADD ./scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]