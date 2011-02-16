module Rubymmer
  class MessageList
    def self.all( client )
      client.access_token.get('/api/v1/messages.json').read_body
    end
  end
end
