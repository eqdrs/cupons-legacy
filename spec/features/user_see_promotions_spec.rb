require 'rails_helper'

feature 'User can see promotions' do
  scenario 'user logged success' do
    promotion1 = create(:promotion)
    promotion2 = create(:promotion)

    login_user
    visit root_path

    expect(page).to have_content promotion1.title
    expect(page).to have_content promotion1.description
    expect(page).to have_content promotion1.discount
    expect(page).to have_content promotion1.end_at
    expect(page).to have_content promotion1.start_at
    expect(page).to have_content promotion1.prefix
    expect(page).to have_content promotion1.quantity

    expect(page).to have_content promotion2.title
    expect(page).to have_content promotion2.description
    expect(page).to have_content promotion2.discount
    expect(page).to have_content promotion2.end_at
    expect(page).to have_content promotion2.start_at
    expect(page).to have_content promotion2.prefix
    expect(page).to have_content promotion2.quantity
  end
  scenario 'only if is logged in' do
    visit root_path
    expect(current_path).to eq new_user_session_path
  end
end
