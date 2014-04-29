require 'spec_helper'

describe "Static pages" do
	describe "Home page" do
		it "should have 'Sample App'" do
			visit '/static_pages/home'
			page.should have_selector('h1', :text => 'Sample App')
		end
		it "should have title" do
			visit '/static_pages/home'
			page.should have_selector('h1', :text => 'Sample App')
		end
	end

	describe "Help page" do
		it "should have 'Help'" do
			visit '/static_pages/help'
			page.should have_selector('h1', :text => 'Help')
		end
	end

	describe "About page" do
		it "should have 'About Us'" do
			visit '/static_pages/about'
			page.should have_selector('h1', :text => 'About Us')
			page.should have_selector('title', :text => 'BLA')
		end
	end

end
