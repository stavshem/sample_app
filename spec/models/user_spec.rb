require 'spec_helper'

describe User do
	#before { @user = User.new(name: "hey", email: "user@gmail.com")}
	before do
		@user = User.new(name: "Example User", email: "user@example.com",
										 password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest)}
	it { should respond_to(:password)}
	it { should respond_to(:remember_token) }
	it { should respond_to(:admin) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:microposts) }
	it { should respond_to(:feed) }

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo,com user_at_foo@org]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end
		end
	end


	describe "micropost associations" do

		before { @user.save }
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

			its(:feed) { should include(newer_micropost) }
			its(:feed) { should include(older_micropost) }
			its(:feed) { should_not include(unfollowed_post) }
		end
	end
end

