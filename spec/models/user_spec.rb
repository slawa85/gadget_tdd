require 'rails_helper'

RSpec.describe User, type: :model do
  let(:missing_email) do
    {
      email: '',
      password: 'qwertyuiop',
      password_confirmation: 'qwertyuiop'
    }
  end

  let(:mismatch_pwd) do
    {
      email: 'ts@ts.com',
      password: 'qwertyuiop',
      password_confirmation: 'qwertyui'
    }
  end


  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  context 'invalid' do
    it 'missing email' do
      user = FactoryGirl.build :user, missing_email
      expect(user).to_not be_valid
    end

    it 'password mismatch' do
      user = FactoryGirl.build :user, mismatch_pwd
      expect(user).to_not be_valid
    end
  end
end
