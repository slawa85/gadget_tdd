require 'rails_helper'

feature 'Gadget' do
  given!(:author) { User.create!(email: 'other@example.com', password: 'qwertyuiop') }
  given!(:second_user) { User.create!(email: 'second@example.com', password: 'qwertyuiop') }

  given!(:first_gadget) { Gadget.create!(name: 'iPod', description: 'This is iPod description', user_id: author.to_param) }
  given!(:second_gadget) { Gadget.create!(name: 'iPad', description: 'qwertyuiopasdad', user_id: author.to_param) }

  given!(:third_gadget) { Gadget.create!(name: 'iPhone', description: 'Iphone description', user_id: second_user.to_param) }

  feature 'Anonymous user'  do
    scenario 'list gadgets, forbbid to create a new one' do
      visit root_path
      click_link 'List all gadgets'

      expect(page).to have_content 'iPod'
      expect(page).to_not have_content 'Edit'

      click_link 'New Gadget'
      expect(current_path).to eql(new_user_session_path)
    end

    scenario 'display gadget profile ' do
      visit gadget_path(first_gadget.to_param)
      expect(page).to have_content(first_gadget.description)
    end
  end

  feature 'Authenticated user' do
    scenario 'display controll links' do
      login(author)
      click_link 'List all gadgets'
      expect(page).to have_content 'Edit'
      expect(page).to have_content 'Destroy'
    end

    scenario 'edit own gadget directly from gadgets list' do
      login(author)
      click_link 'List all gadgets'
      expect(page).to have_content first_gadget.name

      find("a.edit_gadget_#{first_gadget.to_param}").click
      within('form.edit_gadget') do
        fill_in 'Name', with: 'iWatch'
      end
      click_button 'Update Gadget'

      expect(page).to have_content 'iWatch'
    end

    scenario 'delete own gadget from gadgets list' do
      login(author)
      click_link 'List all gadgets'

      find("a.delete_gadget_#{first_gadget.to_param}").click
      expect(page).to_not have_content first_gadget.name
    end
  end
end
