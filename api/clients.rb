require './db'

class Clients
  def self.create
    DB[:clients].insert
  end
end
