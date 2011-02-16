module Rubymmer
  autoload :Client,      'rubymmer/client'
  autoload :MessageList, 'rubymmer/message_list'

  CONSUMER_KEY    = 'QWp8Km7FgkqLJ3RffesQ'
  CONSUMER_SECRET = 'fLbqgpDqIj9ApTGRoDmQu10adDkOBanFRAhvRY5BChA'

  attr_accessor :oauth_key, :oauth_secret

  def yammer(options={})
    @client ||= Client.new(
      :consumer_key => options[:consumer_key] || CONSUMER_KEY,
      :consumer_secret => options[:consumer_secret] || CONSUMER_SECRET,
      :oauth_key => oauth_key || options[:oauth_key],
      :oauth_secret => oauth_secret || options[:oauth_secret])
  end
end

