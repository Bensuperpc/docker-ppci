ARG DOCKER_IMAGE=alpine:latest
FROM $DOCKER_IMAGE

LABEL author="Bensuperpc <bensuperpc@gmail.com>"
LABEL mantainer="Bensuperpc <bensuperpc@gmail.com>"

ARG VERSION="1.0.0"
ENV VERSION=$VERSION

RUN apk add --no-cache git python3 py3-setuptools \
	&& git clone --recurse-submodules https://github.com/windelbouwman/ppci.git \
	&& cd ppci \
	&& python3 setup.py install && apk del git \
	&& cd .. && rm -rf ppci

RUN ppci-build -h && ppci-cc -h

CMD ["ppci-build", "-h"]


#ENV PATH="/usr/local:${PATH}"

#ENV CC=/usr/local/bin/sjasmplus
#WORKDIR /usr/src/myapp

LABEL org.label-schema.schema-version="1.0" \
	  org.label-schema.build-date=$BUILD_DATE \
	  org.label-schema.name="bensuperpc/ppci" \
	  org.label-schema.description="build tinycc compiler" \
	  org.label-schema.version=$VERSION \
	  org.label-schema.vendor="Bensuperpc" \
	  org.label-schema.url="http://bensuperpc.com/" \
	  org.label-schema.vcs-url="https://github.com/Bensuperpc/docker-ppci" \
	  org.label-schema.vcs-ref=$VCS_REF \
	  org.label-schema.docker.cmd="docker build -t bensuperpc/ppci -f Dockerfile ."