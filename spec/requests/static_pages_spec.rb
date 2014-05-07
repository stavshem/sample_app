require 'spec_helper'

describe "Static pages" do
	describe "Home page" do
		it "should have 'Sample App'" do
			visit '/home'
			page.should have_selector('h1', :text => 'Home')
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
