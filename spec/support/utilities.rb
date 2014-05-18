include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

#def sign_in(user, options={})
  #if options[:no_capybara]
     #Sign in when not using Capybara.
    #remember_token = User.new_remember_token
    #cookies[:remember_token] = remember_token
    #user.update_attribute(:remember_token, User.digest(remember_token))
  #else
    #visit '/signin'
    #fill_in "Email",    with: user.email
    #fill_in "Password", with: user.password
    #click_button "Sign in"
  #end
#end


def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end
