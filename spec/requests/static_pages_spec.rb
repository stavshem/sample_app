require 'spec_helper'

describe "Static pages" do
	describe "Home page" do
		it "should have 'Sample App'" do
			visit '/home'
			page.should have_selector('h1',    :text => 'Sample App')
		end
	end

	describe "for signed-in users" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
			FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
			sign_in user
			visit '/home'
		end

		it "should render the user's feed" do
      		GenerateFeed.for_user(user).each do |item|
				expect(page).to have_selector("li##{item.id}", text: item.content)
			end
		end

		it "should render user's message box" do
				expect(page).to have_selector("h1", text: "Message Box")
			end
		end

	describe "Help page" do
		it "should have 'Help'" do
			visit '/help'
			page.should have_selector('h1', :text => 'Help')
		end
	end

	describe "About page" do
		it "should have 'About Us'" do
			visit '/about'
			page.should have_selector('h1', :text => 'About Us')
		end
	end
end
