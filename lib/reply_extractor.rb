class ReplyExtractor

  REPLY_CONTENT_RE = /@((\w|-)+)/ 

  def initialize(content)
    @content = content
  end

  def get_user
    @content.match(/@((\w|-)+)/)[1]
  end
 
  def reply_user_id
    reply_user_name = user_name
    reply_user = User.find_by_name(reply_user_name)
    reply_user ? reply_user.id : nil
  end

  def user_string
    ans = @content.match(REPLY_CONTENT_RE)
    ans ? ans[1] : nil
  end

  def user_name
    user_string ? user_string.sub("-", " ").titleize : nil
  end

  def self.raw_name_to_reply_name(raw_name)
    return raw_name.downcase.sub(" ", "-") 
  end


  
end
