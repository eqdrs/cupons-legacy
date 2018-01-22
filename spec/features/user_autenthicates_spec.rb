require 'rails_helper'

feature 'User authenticates' do
  scenario 'successfully' do
    user = create(:user)
    visit new_user_session_path

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: '12345678'

    click_on 'Log in'

    expect(page).to have_content "Olá, #{user.email}"
  end

  scenario 'with wrong credentials' do
    user = create(:user)
    visit new_user_session_path

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'wrong_pass'

    click_on 'Log in'

    expect(page).to_not have_content "Olá, #{user.email}"
    expect(page).to have_content 'E-mail ou senha inválidos.'
  end
end
