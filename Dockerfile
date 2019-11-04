FROM alpine:3.10 AS build

ARG SITE_PATH=/site

COPY . $SITE_PATH

WORKDIR $SITE_PATH

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing/ >> /etc/apk/repositories \
 && apk add --update --no-cache zola git \
 && git submodule init \
 && git submodule update \
 && /usr/bin/zola build

FROM nginx:1.17-alpine

MAINTAINER Ryota Kota <ryota.kota@member.fsf.org>

COPY --from=build /site/public /usr/share/nginx/html

EXPOSE 80
