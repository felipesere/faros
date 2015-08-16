FROM smebberson/alpine-base

MAINTAINER felipesere@gmail.com

RUN echo "@main http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN apk --update add mysql-client ncurses erlang-erts@main erlang-sasl@main erlang-syntax-tools@main erlang-crypto@main && rm -rf /var/cache/apk/*
