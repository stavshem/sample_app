require 'reply_extractor'
class Micropost < ActiveRecord::Base
  attr_accessible :content, :in_reply_to
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope order: 'microposts.created_at DESC'

  before_save :handle_replies

  private

  def handle_replies
    extractor = ReplyExtractor.new(self.content)
    self.in_reply_to = extractor.reply_user_id
  end
end
