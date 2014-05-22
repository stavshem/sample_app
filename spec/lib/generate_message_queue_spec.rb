require 'spec_helper'
require 'content_extractor'

describe GenerateMessageQueue do

  describe "message queue" do

    subject { GenerateMessageQueue.for_user(@repicient) }

    context "a reply micropost and a message micropost" do

      before do
        @repicient = FactoryGirl.create(:user)
        @repicient_name = ContentExtractor.db_name_to_formatted_name(@repicient.name)
        @reply_micropost = FactoryGirl.create(:micropost,
                                              content: "@#{@repicient_name} some reply micropost")
        @message = FactoryGirl.create(:micropost,
                                      content: "ddd#{@repicient_name} a private message")
      end

      context "should contain only the message micropost" do
        it { should_not include @reply_micropost }
        it { should include @message }
      end
    end
  end
end

      