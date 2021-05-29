FROM golang:1.16-alpine

RUN go get -u github.com/m3ng9i/ran
RUN rm -rf $GOPATH/pkg
RUN rm -rf $GOPATH/src

RUN apk update
RUN apk add --upgrade wget tar

ENV HUGO_DOWNLOAD_LINK https://github.com/gohugoio/hugo/releases/download/v0.83.1/hugo_0.83.1_Linux-64bit.tar.gz
ENV HUGO_TAR hugo_0.83.1_Linux-64bit.tar.gz

WORKDIR /tmp
RUN wget $HUGO_DOWNLOAD_LINK
RUN tar xzf $HUGO_TAR
RUN mv hugo $GOPATH/bin
RUN rm -rf ./*

WORKDIR /app
COPY . .

RUN hugo
RUN rm $GOPATH/bin/hugo

ENV SITE_PORT 4000
ENV SITE_BIND 0.0.0.0
