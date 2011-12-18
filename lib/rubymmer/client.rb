require 'oauth'

module Rubymmer
  class Client
    SITE = 'https://www.yammer.com'

    attr_reader :oauth_key, :oauth_secret, :access_token

    def initialize(options={})
      @consumer_key    = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
      @oauth_key       = options[:oauth_key]
      @oauth_secret    = options[:oauth_secret]
      create_access_token if @oauth_key && @oauth_secret
    end

    def authorize_url
      @authorize_url ||= request_token.authorize_url
    end

    def verified?
      !!@access_token
    end

    def verify_with(verifier)
      create_access_token(verifier)
    end

    def user_token
      {
        :provider => 'yammer',
        :consumer_key => @consumer_key,
        :consumer_secret => @consumer_secret,
        :oauth_key => access_token.token,
        :oauth_secret => access_token.secret
      }
    end

    def messages
      MultiJson.decode MessageList.all(self)
    end

private

    def create_access_token(verifier = nil)
      if(verifier)
        @access_token = request_token.get_access_token(:oauth_verifier => verifier)
        @oauth_key    = @access_token.params[:oauth_token]
        @oauth_secret = @access_token.params[:oauth_token_secret]
      elsif oauth_key && oauth_secret
        @access_token = OAuth::AccessToken.new(consumer, oauth_key, oauth_secret)
      end
      @access_token
    end

    def consumer
      @consumer ||= OAuth::Consumer.new(@consumer_key, @consumer_secret, {:site => SITE})
    end

    def request_token
      @request_token ||= consumer.get_request_token
    end
  end
end
