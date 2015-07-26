FROM smebberson/alpine-base

MAINTAINER felipesere@gmail.com

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk --update add mysql-client ncurses erlang17-erts@testing erlang17-sasl@testing erlang17-syntax-tools@testing erlang17-crypto@testing && rm -rf /var/cache/apk/*
