FROM felipesere/erlang18:latest

EXPOSE 4001

ADD create-config.sh /create-config.sh
RUN chmod +x /create-config.sh
RUN mkdir -p /etc/services.d/lighthouse && echo -e "#!/usr/bin/with-contenv sh \n /create-config.sh \n /lighthouse/bin/lighthouse foreground" >> /etc/services.d/lighthouse/run
ENV MIGRATION_PATH /migrations

ADD priv/repo/migrations /migrations
ADD rel/lighthouse  /lighthouse

ENTRYPOINT ["/init"]
