require 'spec_helper'

describe GenerateFeed do

  describe "feed" do

    subject { GenerateFeed.for_user(@user) }

    context "a reply micropost" do

      before do
        @user = FactoryGirl.create(:user)
        @reply_to = FactoryGirl.create(:user)
        @reply_to_name = ReplyExtractor.raw_name_to_reply_name(@reply_to.name)
        @reply_micropost = FactoryGirl.create(:micropost,
                                              content: "@#{@reply_to_name} some reply micropost")
      end

      context "to an unfollowed user" do
        context "if not the sender" do
          it { should_not include(@reply_micropost) }
        end

        context "if is the sender" do 
          before { @reply_micropost.update_attribute(:user, @user) }
          it {should include(@reply_micropost)}
        end
      end

      context "to a followed user" do 
        before do
          @reply_micropost.update_attribute(:user, FactoryGirl.create(:user))
          @user.follow!(@reply_to)
        end
        it { should include(@reply_micropost) }
      end
    end


    describe "micropost associations" do

      before { @user = FactoryGirl.create(:user) }
      let!(:older_micropost) do
        FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
      end
      let!(:newer_micropost) do
        FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
      end

      it "should have the right microposts in the right order" do
        expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
      end

      describe "status" do
        let(:unfollowed_post) do
          FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
        end

        it { should include(newer_micropost) }
        it { should include(older_micropost) }
        it { should_not include(unfollowed_post) }
      end
    end
  end


end

