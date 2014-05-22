class GenerateFeed

    def self.for_user(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"

    Micropost.where("(private = 'f')
    				 AND
	    			( user_id IN (#{followed_user_ids}) OR user_id = :user_id 
	          		OR in_reply_to IN (#{followed_user_ids}) OR in_reply_to = :user_id )",
          			user_id: user.id)
  end
end


