# Rails6系は2.5.0以降のRuby、Ruby2系が良いので安定版の2.7.6
FROM ruby:2.7.6-alpine

ARG FRONT_URL
ARG API_URL
ARG IMAGE_URL
ARG DB_NAME
ARG DB_HOSTNAME
ARG DB_USERNAME
ARG DB_PASSWORD
ARG RUNTIME_PACKAGES="nodejs tzdata postgresql-dev postgresql git"
ARG DEV_PACKAGES="build-base curl-dev"

ENV FRONT_URL    $FRONT_URL
ENV API_URL      $API_URL
ENV IMAGE_URL    $IMAGE_URL
ENV DB_NAME      $DB_NAME
ENV DB_HOSTNAME  $DB_HOSTNAME
ENV DB_USERNAME  $DB_USERNAME
ENV DB_PASSWORD  $DB_PASSWORD
ENV WORKDIR      app
ENV LANG         C.UTF-8
ENV TZ           Asia/Tokyo

WORKDIR ${WORKDIR}

COPY Gemfile* ./

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    bundle install -j4 && \
    apk del build-dependencies && \
    apk add vim

COPY . ./
