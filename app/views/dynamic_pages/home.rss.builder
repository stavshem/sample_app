xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  if signed_in?
    xml.channel do

      # Feed basics
      xml.title             "RSS " + current_user.name 
      xml.description       "This is an RSS feed contains all user's microposts" 
      #xml.link              user_url(@user, :format => 'rss')

      # User's feed  
      for micropost in GenerateFeed.for_user(current_user) do
        xml.item do
          xml.title          micropost.content.split[0..3].join(' ') + "..." 
          xml.description    micropost.content 
          xml.pubDate        micropost.created_at.to_s(:rfc822)
          xml.guid           micropost.id, isPermaLink: false
          xml.link           user_url(micropost.user)
        end
      end #for
    end # channel
  else
    xml.title                "Error"
  end
end

