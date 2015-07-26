FROM felipesere/erlang17:latest

EXPOSE 4001
RUN mkdir -p /etc/services.d/lighthouse && echo -e "#!/usr/bin/with-contenv sh \n /lighthouse/bin/lighthouse foreground" >> /etc/services.d/lighthouse/run
ENV MIGRATION_PATH /migrations

ADD priv/repo/migrations /migrations
ADD rel/lighthouse  /lighthouse

ENTRYPOINT ["/init"]
