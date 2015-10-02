FROM felipesere/erlang18:8ff211e35cf2798f73215bd57e71a1cf76429a08

EXPOSE 4001

RUN mkdir -p /etc/services.d/faros && echo -e "#!/usr/bin/with-contenv sh \n /faros/bin/faros foreground" >> /etc/services.d/faros/run
ENV MIGRATION_PATH /migrations
ENV RELX_REPLACE_OS_VARS=true

ADD priv/repo/migrations /migrations
ADD rel/faros  /faros

ENTRYPOINT ["/init"]
