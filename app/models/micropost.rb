require 'content_extractor'
class Micropost < ActiveRecord::Base
  attr_accessible :content, :in_reply_to
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope order: 'microposts.created_at DESC'

  before_save :handle_irregular_micropost

  private

  def handle_irregular_micropost
    extractor = ContentExtractor.new(self.content)
    
    case extractor.content_type
    when :reply
      self.in_reply_to = extractor.user_id
    when :message
      self.in_reply_to = extractor.user_id
      self.private = true
    end
  end

end
