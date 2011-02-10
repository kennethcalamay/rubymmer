require 'oauth'
require 'hpricot'

module Rubymmer
  def establish_connection(key = nil, secret = nil)
    consumer = OAuth::Consumer.new("QWp8Km7FgkqLJ3RffesQ", "fLbqgpDqIj9ApTGRoDmQu10adDkOBanFRAhvRY5BChA", {:site=>"https://www.yammer.com"})
    self.request_token = consumer.get_request_token
    request_token.authorize_url # go to that url and hit authorize.  then copy the oauth_verifier code on that page.
  end

  def set_token(token)
    self.access_token = self.request_token.get_access_token(:oauth_verifier => token)
    self.yammer_access_token = access_token.token
    self.yammer_secret_token = access_token.secret
  end

  def parse_response(response)
    urls = []

    doc = Hpricot.parse(response)
    (doc/ :response/ :messages/ :message).each do |msg|
      urls << msg.search("/web-url").first.children.first.raw_string
    end
    urls
  end

  def all
    parse_response self.access_token.get('/api/v1/messages.xml').read_body
  end

  def sent
    parse_response self.access_token.get('/api/v1/messages/sent.xml').read_body
  end

  def received
    parse_response self.access_token.get('/api/v1/messages/received.xml').read_body
  end

  def following
    parse_response self.access_token.get('/api/v1/messages/following.xml').read_body
  end

  def access_token
    @access_token ||= if yammer_access_token && yammer_secret_token
      consumer = OAuth::Consumer.new("QWp8Km7FgkqLJ3RffesQ", "fLbqgpDqIj9ApTGRoDmQu10adDkOBanFRAhvRY5BChA", {:site=>"https://www.yammer.com"})  
      self.access_token = OAuth::AccessToken.new(consumer, yammer_access_token, yammer_secret_token)
    end
  end

end


