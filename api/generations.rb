require './db'
require './get_image'

class Generations
  def self.create(client_id, html)
    url = GetImage.call(html)
    DB[:generations]
      .returning(:url)
      .insert(url: url, client_id: client_id)

    url
  end

  def self.from_client(client_id)
    DB[:generations]
      .where(client_id: client_id)
      .all
      .map { |g| g[:url] }
  end
end
