require 'rails_helper'
feature 'User registration' do
  given(:valid_signup_data) do
    {
      email: 'user@example.com',
      pass: 'qwertyuiop',
      pass_confirm: 'qwertyuiop'
    }
  end

  given(:invalid_signup_data) do
    {
      email: 'user@example.com',
      pass: 'qwerty',
      pass_confirm: 'qwerty'
    }
  end

  scenario 'Complete form with correct data' do
    sign_up valid_signup_data
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'Password don\'t match' do
    valid_signup_data[:pass_confirm] = 'asdaskjdnasdnuinu'

    sign_up valid_signup_data
    expect(page).to have_content 'Password confirmation doesn\'t match'
  end

  scenario 'Password don\'t match' do
    sign_up invalid_signup_data
    expect(page).to have_content 'Password is too short'
  end
end
