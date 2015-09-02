require 'rails_helper'
feature 'Password reset' do
  background do
    User.create!(email: 'user@example.com', password: 'qwertyuiop')
  end

  scenario 'Complete form with correct data' do
    visit new_user_password_path
    within('#new_user') do
      fill_in 'Email', with: 'user@example.com'
    end

    click_button 'Send me reset password instructions'
    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
  end

  scenario 'Complete form with missing email' do
    visit new_user_password_path
    within('#new_user') do
      fill_in 'Email', with: 'tada@example.com'
    end

    click_button 'Send me reset password instructions'
    expect(page).to have_content 'Email not found'
  end
end
