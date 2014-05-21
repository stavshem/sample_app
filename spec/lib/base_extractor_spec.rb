require 'spec_helper'
describe "Extractor" do

  subject { BaseExtractor.new(@content) }

  describe "Reply" do
    describe "user id" do
      context "content without reply" do
        before {@content = "hello this is a post"}
        its(:user_id) { should be_nil }
        its(:content_type) { should be_nil }
      end

      context "content with reply" do
        before {@content = "@stav-sh hello stav"}
        context "reply user exists" do
          before { @user = FactoryGirl.create(:user, name: "Stav Sh")}
          its(:user_id) { should == @user.id}
          its(:content_type) { should eq :reply }
        end

        context "reply user doest not exist" do
          before {@content = "@inmemoryuser hello non existing user"}
          context "reply user exists" do
            before {@user = FactoryGirl.create(:user, name: "stav")}
            its(:user_id) {should be_nil}
          end
        end
      end

      describe "sanity user name extraction" do
        before { @content = "@some-user hello" }
        its(:user_string) { should eq "some-user" }
        its(:user_db_name) { should eq "Some User" }
      end

      describe "user name extraction when content contains @" do
        before { @content = "@some-user hello user@gmail.com" }
        its(:user_db_name) { should eq "Some User" }
      end

      describe "long user name extraction" do
        before { @content = "@long_user_name hello micropost for long named user" }
        its(:user_db_name) { should eq "Long User Name" }
      end
    end
  end

  describe "Message" do
    context "content is a private message" do
      before {@content = "dddstav-sh hello stav"}
      context "reply user exists" do
        before { @user = FactoryGirl.create(:user, name: "Stav Sh")}
        its(:user_string) { should == "stav-sh"}
        its(:user_id) { should == @user.id}
        its(:content_type) { should eq :message }
      end
    end
  end

end
