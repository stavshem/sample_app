class DynamicPagesController < ApplicationController

  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = GenerateFeed.for_user(current_user).paginate(page: params[:page])
      @messages = GenerateMessageQueue.for_user(current_user)
    end
  end
end
