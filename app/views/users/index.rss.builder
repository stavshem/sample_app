xml.channel do
  # Required to pass W3C validation.
  xml.atom :link, nil, {
    :href => 'google.com', 
    #:href => users_url(:format => 'rss'),
    :rel => 'self', :type => 'application/rss+xml'
  }

  # Feed basics.
  xml.title             "RSS"
  xml.description       "world" 
  #xml.link              users_url(:format => 'rss')

  # News items.
  @users.each do |user|
    xml.item do
      xml.title         user.name
      xml.link          user_url(user)
      xml.description   "hello" 
      #xml.pubDate       user.publish_date.to_s(:rfc822)
      xml.guid          user_url(user)
    end
  end
end
