import Config

config :n2o, port: 4000,
  pickler: :n2o_secret,
  mq: :n2o_syn,
  upload: "./priv/static",
  protocols: [:n2o_nitro, :n2o_ftp],
  routes: Sample.Routes

config :nitro,
  http: [port: 4000]

config :kvs,
  dba: :kvs_rocks,
  dba_st: :kvs_st,
  schema: [:kvs, :kvs_stream]

config :sample, room: "1"
