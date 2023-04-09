import Config

config :addressbook, Addressbook.Repo,
  database: "gerald_addr_bk",
  username: "gerald",
  password: "test123",
  hostname: "10.136.168.7",
  port: "4044",
  #prepare: :unnamed,
  pool_size: 2
  # config: "config/runtime.dev.exs"
