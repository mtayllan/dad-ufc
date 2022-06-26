require 'sequel'

DB = Sequel.connect(
  adapter: :postgres,
  user: ENV['DB_USER'],
  password: ENV['DB_PWD'],
  host: ENV['DB_HOST'],
  port: ENV['DB_PORT'],
  database: ENV['DB_NAME'],
  max_connections: 10
)
