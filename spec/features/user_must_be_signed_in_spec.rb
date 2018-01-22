require 'rails_helper'

feature 'user must be signed in to' do
  scenario 'create promotion' do
    visit new_promotion_path

    expect(current_path).to eq(new_user_session_path)
  end
end
