module  UserHelper
  def login(user)
    visit root_path
    click_link 'Login'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with:  user.password
    end
    click_button 'Log in'
  end

  def sign_up(user)
    visit root_path
    click_link 'Sign up'
    within('#new_user') do
      fill_in 'Email', with: user[:email]
      fill_in 'Password', with: user[:pass]
      fill_in 'Password confirmation', with: user[:pass_confirm]
    end
    click_button 'Sign up'
  end
end
