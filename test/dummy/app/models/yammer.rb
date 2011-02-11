class Yammer
  include Mongoid::Document

  validates_uniqueness_of :message_id

  def self.load_from_raw(hash)

    yammer_fields = %w(message_type body system_message network_id client_type url thread_id direct_message sender_type
                       replied_to_id sender_id web_url privacy client_url liked_by attachments)

    hash["response"]["messages"]["message"].each do |s| 
      yammer_message = {}

      yammer_fields.each do |f|
        yammer_message[f.to_sym] = s[f]
      end

      yammer_message[:message_created_at] = s['created_at']
      yammer_message[:message_id] = s['id']
      Yammer.create(yammer_message) 
    end


  end
end
