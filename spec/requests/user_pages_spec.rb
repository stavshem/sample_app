require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }

  end

  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe "followed users" do
      before do
        sign_in user
        visit following_user_path(user)
      end

      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.name, href: user_path(other_user)) }
    end

    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe "after submission" do
        before { click_button submit }

        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name)}
      end

    end

    #describe "edit" do
    #let(:user) { FactoryGirl.create(:user) }
    #before { visit edit_user_path(user) }

    #describe "page" do
    #it { should have_content("Update your profile") }
    #it { should have_selector('title', text: 'Edit user') }
    #it { should have_link('change', href: 'http://gravatar.com/emails') }
    #end

    #describe "with invalid information" do
    #before { click_button "Save changes" }

    #it { should have_content('error') }
    #end
    #end

  end

  describe "RSS feed" do

    before do
      @user = FactoryGirl.create(:user)
      sign_in @user
      visit user_url(@user, :format => 'rss')
    end

    context "contains RSS header" do
      it { should have_selector('title', text: 'RSS') }
    end

    context "user doesn't have microposts" do
      it { should_not have_selector('item') }
    end

    context "user has a micropost" do
      before do 
        FactoryGirl.create(:micropost, user: @user)
        visit user_url(@user, :format => 'rss')
      end
      it { should have_selector('item') }
    end

    context "user has multiple microposts" do
      before do 
        FactoryGirl.create(:micropost, user: @user)
        FactoryGirl.create(:micropost, user: @user)
        FactoryGirl.create(:micropost, user: @user)
        visit user_url(@user, :format => 'rss')
      end
      it { expect(@user.microposts.count).to be > 1 }
      it { expect(page).to have_selector('item', count: @user.microposts.count) }

      it "should have the contnet of each of the user's posts" do
        @user.microposts.each do |micropost|
          expect(page).to have_selector("description", text: micropost.content)
        end # foreach
      end # it
    end #context


  end

end