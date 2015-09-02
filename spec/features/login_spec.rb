require 'rails_helper'
feature 'Signing in' do
    given!(:author) { User.create!(email: 'other@example.com', password: 'qwertyuiop') }
    given(:unknown_user) { User.new(email: 'othera@example.com', password: 'qwertyuiop') }

  scenario 'Signing in with correct credentials' do
    login(author)
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Signing in as another user' do
    login(unknown_user)
    expect(page).to have_content 'Invalid email or password'
  end
end
