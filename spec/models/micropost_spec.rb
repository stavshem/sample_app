require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  #before { @micropost = user.microposts.first }
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end

  describe "replies" do
    context "micropost without reply" do
      before { @micropost.content = "a" * 141 }
      its(:in_reply_to) { should be_nil }
    end
    context "micropost with reply" do
      before { @micropost.content = "@bla hello" }
      context "reply user exists" do
          before do
            @user_1 = FactoryGirl.create(:user, name: "Stav")
            @user_2 = FactoryGirl.create(:user, name: "Erez")
            @user_3 = FactoryGirl.create(:user, name: "Bla")
            @micropost.save()
          end
          its(:in_reply_to) {should == @user_3.id}
          it { should_not be_private }
      end
    end
  end

  describe "messaging" do
    context "is not a private message" do
      before { @micropost.content = "a" * 141 }
      it { should_not be_private }
    end
    context "is a private message" do
      context "repicient exists" do
          before do
            @user_1 = FactoryGirl.create(:user, name: "Erez")
            @user_2 = FactoryGirl.create(:user, name: "Bla")
            @user_3 = FactoryGirl.create(:user, name: "Stav")
            @micropost = FactoryGirl.create(:micropost,
              content: "dstav this is a private message")
          end
          its(:in_reply_to) { should ==  @user_3.id}
          it { should be_private }
      end
    end
  end


end
