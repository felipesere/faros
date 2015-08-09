FROM smebberson/alpine-base

MAINTAINER felipesere@gmail.com

RUN apk --update add nginx wget tar && rm -rf /var/cache/apk/* && rm /etc/nginx/nginx.conf.default && rm -rf /etc/nginx/conf.d/*
ADD nginx.conf /etc/nginx/nginx.conf

RUN wget --no-check-certificate -qO - https://github.com/hashicorp/consul-template/releases/download/v0.10.0/consul-template_0.10.0_linux_386.tar.gz | tar -C /usr/local/bin --strip-components 1 -zxf -

ADD app.conf.ctmpl        /etc/consul-templates/app.conf.ctmpl
ADD nginx.run             /etc/services.d/nginx/run
ADD consul-template.run   /etc/services.d/consul-template/run

RUN chmod u=rwx,g=rw,a=rw /etc/services.d/nginx/run && chmod u=rwx,g=rw,a=rw /etc/services.d/consul-template/run

ENTRYPOINT ["/init"]
