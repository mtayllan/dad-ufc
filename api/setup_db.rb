require './db'

DB.create_table :clients do
  primary_key :id
end

DB.create_table :generations do
  String :url, null: false
  foreign_key :client_id, :clients
end

