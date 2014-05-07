require 'spec_helper'

describe User do
  before { @user = User.new(name: "", email: "user@gmail.com")}

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:password_digest)}
  it { should respond_to(:email) }
  it { should respond_to(:remember_token) }

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo,com user_at_foo@org]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end
