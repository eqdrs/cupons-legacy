require 'rails_helper'

feature 'User approves promotion' do
  scenario 'successfully' do
    creator = create(:user)
    approver = login_user
    promotion = create(:promotion, user: creator)

    visit promotion_path(promotion)
    click_on 'Aprovar'

    expect(current_path).to eq promotion_path(promotion)
    expect(page).to have_content 'Promoção aprovada com sucesso'
    expect(page).to have_content "Aprovada por: #{approver.email}"
    expect(page).to_not have_content 'Pendente de aprovação'
    expect(page).to_not have_link 'Aprovar'
    expect(page).to_not have_link 'Recusar'
  end

  scenario 'and the promotion creator can\'t approve it' do
    creator = login_user
    promotion = create(:promotion, user: creator)

    visit promotion_path(promotion)

    expect(page).to have_content 'Pendente de aprovação'
    expect(page).to_not have_link 'Aprovar'
    expect(page).to_not have_link 'Recusar'
  end
end
