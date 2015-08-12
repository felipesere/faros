#!/usr/bin/with-contenv sh

cat > "/lighthouse/releases/0.0.1/sys.config" <<- EOM
[{sasl,[{errlog_type,error}]},
 {lighthouse,
     [{'Elixir.Lighthouse.Endpoint',
          [{url,[{host,<<"example.com">>}]},
           {root,            <<"/Users/felipe/Development/elixir/lighthouse">>},
           {secret_key_base, <<"l3UUT5Pj0LXll1yor/ZRAGuCjgYrREGHCiEAMSfOFc22zXxDAukzMn27aRr8zfhH">>},
           {debug_errors,false},
           {pubsub,
               [{name,'Elixir.Lighthouse.PubSub'},
                {adapter,'Elixir.Phoenix.PubSub.PG2'}]},
           {http,[{port,4001}]},
           {cache_static_manifest,<<"priv/static/manifest.json">>},
           {server,true}]},
      {'Elixir.Lighthouse.Repo',
          [{adapter,'Elixir.Ecto.Adapters.MySQL'},
           {username,<<"$DB_USER_NAME">>},
           {password,<<"$DB_USER_PASSWORD">>},
           {database,<<"$DATABASE_NAME">>},
           {pool,'Elixir.Ecto.Adapters.SQL.Sandbox'},
           {hostname,<<"$DATABASE_HOST">>},
           {size,10}]}]},
 {logger,
     [{console,
          [{format,<<"\$time \$metadata[\$level] \$message\n">>},
           {metadata,[request_id]}]},
      {level,info}]}].
EOM