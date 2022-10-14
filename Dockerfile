# Rails6系は2.5.0以降のRuby、Ruby2系が良いので安定版の2.7.6
FROM ruby:2.7.6-alpine

ARG WORKDIR
ARG RUNTIME_PACKAGES="nodejs tzdata postgresql-dev postgresql git"
ARG DEV_PACKAGES="build-base curl-dev"

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
	# Rails ENV["TZ"] => Asia/Tokyo
    TZ=Asia/Tokyo

WORKDIR ${HOME}

COPY Gemfile* ./


RUN apk update && \
    apk upgrade && \
	# --no-cache: イメージ軽量化
    apk add --no-cache ${RUNTIME_PACKAGES} && \
	# apk delでまとめて削除するために仮想パッケージ名を指定
    apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    # -jobs=4: インストール高速化
	bundle install -j4 && \
	# gemインストール後、build-dependenciesはいらないためイメージ軽量化の目的
    apk del build-dependencies

COPY . ./

# CMD ["rails", "server", "-b", "0.0.0.0"]
