require 'spec_helper'

describe DynamicPagesController do
  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET RSS feed" do
    it "returns an RSS feed" do
      get :home, :format => "rss"
      response.should be_success
      response.content_type.should eq("application/rss+xml")
    end
  end
end

