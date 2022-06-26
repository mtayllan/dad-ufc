require "roda"
require './clients'
require './generations'

class App < Roda
  plugin :json
  plugin :json_parser

  route do |r|
    r.post "clients" do
      id = Clients.create
      { id: id }
    end

    r.on "generations" do
      r.is Integer do |client_id|
        r.get do
          Generations.from_client(client_id)
        end

        r.post do
          { url: Generations.create(client_id, r.params['html']) }
        end
      end
    end
  end
end
