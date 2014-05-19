require 'reply_extractor'
class Micropost < ActiveRecord::Base
  attr_accessible :content, :in_reply_to
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope order: 'microposts.created_at DESC'

  before_save :handle_replies

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    #where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
    #user_id: user.id)
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id 
          OR in_reply_to IN (#{followed_user_ids}) OR in_reply_to = :user_id",
          user_id: user.id)
  end


  private

  def handle_replies
    extractor = ReplyExtractor.new(self.content)
    self.in_reply_to = extractor.reply_user_id
  end
end
