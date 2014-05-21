class GenerateMessageQueue
    def self.for_user(user)
    	Micropost.where(private: true, in_reply_to: user.id)
  	end
end


