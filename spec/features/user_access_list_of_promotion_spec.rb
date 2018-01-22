require 'rails_helper'

feature 'User access list of promotions' do
  scenario 'access from home' do
    promotion = create(:promotion)
    other_promotion = create(:promotion)

    login_user
    visit promotions_path
    click_on 'Promoções'

    expect(page).to have_content(promotion.title)
    expect(page).to have_content(other_promotion.title)
    expect(page).to have_content('Desconto')
    expect(page).to have_content(promotion.discount)
    expect(page).to have_content(other_promotion.discount)
    expect(page).to have_content('Início')
    expect(page).to have_content(promotion.start_at)
    expect(page).to have_content(other_promotion.start_at)
    expect(page).to have_content('Expira em')
    expect(page).to have_content(promotion.end_at)
    expect(page).to have_content(other_promotion.end_at)
    expect(page).to have_content('Prefixo')
    expect(page).to have_content(promotion.prefix)
    expect(page).to have_content(other_promotion.prefix)
    expect(page).to have_content('Qtde cupons')
    expect(page).to have_content(promotion.quantity)
    expect(page).to have_content(other_promotion.quantity)
    expect(page).to have_content('Duração')
    expect(page).to have_content(promotion.duration)
    expect(page).to have_content(other_promotion.duration)
  end
end
