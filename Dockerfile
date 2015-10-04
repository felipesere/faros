FROM felipesere/erlang18:045a39206c5d02429d32c82fd32419acc3637d8b

EXPOSE 4001

RUN mkdir -p /etc/services.d/faros && echo -e "#!/usr/bin/with-contenv sh \n /faros/bin/faros foreground" >> /etc/services.d/faros/run
ENV MIGRATION_PATH /migrations
ENV RELX_REPLACE_OS_VARS=true

ADD priv/repo/migrations /migrations
ADD rel/faros  /faros

ENTRYPOINT ["/init"]
