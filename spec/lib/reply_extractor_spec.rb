require 'spec_helper'

describe ReplyExtractor do

  subject { ReplyExtractor.new(@content) }

  describe "user id" do
    context "content without reply" do
      before {@content = "hello this is a post"}
      its(:reply_user_id) { should be_nil }
    end

    context "content with reply" do
      before {@content = "@stav-sh hello stav"}
      context "reply user exists" do
        before {@user = FactoryGirl.create(:user, name: "Stav Sh")}
        its(:reply_user_id) {should == @user.id}
      end

      context "reply user doest not exist" do
        before {@content = "@inmemoryuser hello non existing user"}
        context "reply user exists" do
          before {@user = FactoryGirl.create(:user, name: "stav")}
          its(:reply_user_id) {should be_nil}
        end
      end
    end

    describe "sanity user name extraction" do
      before { @content = "@some-user hello" }
      its(:user_string) { should eq "some-user" }
      its(:user_name) { should eq "Some User" }
    end

    describe "user name extraction when content contains @" do
      before { @content = "@some-user hello user@gmail.com" }
      its(:user_name) { should eq "Some User" }
    end

    describe "long user name extraction" do
      before { @content = "@long_user_name hello micropost for long named user" }
      its(:user_name) { should eq "Long User Name" }
    end

  end
end
