xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do

  xml.channel do
    # Required to pass W3C validation.
    #xml.atom :link, nil, {
    #:href => users_url(:format => 'rss'),
    #:rel => 'self', :type => 'application/rss+xml'
    #}

    # Feed basics
    xml.title             "RSS for " + @user.name
    xml.description       "This is an RSS feed contains all user's microposts" 
    xml.link              user_url(@user, :format => 'rss')

    # User's microposts 
    for micropost in @user.microposts do
      xml.item do
        xml.title          micropost.content.split[0..3].join(' ') + "..." 
        #xml.link          
        xml.description    micropost.content 
        xml.pubDate        micropost.created_at.to_s(:rfc822)
        xml.guid           micropost.id, isPermaLink: false
      end
    end
  end
end
