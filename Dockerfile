FROM alpine:3.10 AS build

COPY . /site

WORKDIR /site

RUN set -x && \
    apk add --update hugo git && \
    git submodule init && \
    git submodule update

RUN /usr/bin/hugo

FROM nginx:1.17-alpine

MAINTAINER Ryota Kota <ryota.kota@member.fsf.org>

COPY --from=build /site/public /usr/share/nginx/html

EXPOSE 80
