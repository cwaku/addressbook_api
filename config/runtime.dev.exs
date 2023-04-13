import Config

config :addressbook, Addressbook.Repo,
  database: System.fetch_env!("TEST_DATABASE"),
  username: System.fetch_env!("TEST_USER"),
  password: System.fetch_env!("TEST_PASSWORD"),
  hostname: System.fetch_env!("TEST_HOST"),
  pool_size: 2,
  port: System.fetch_env!("TEST_PORT")
