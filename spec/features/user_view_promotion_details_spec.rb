require 'rails_helper'

feature 'User view promotion details' do
  scenario 'successfully' do
    promotion = create(:promotion)

    login_user
    visit root_path
    click_on promotion.title

    expect(current_path).to eq promotion_path(promotion)
    expect(page).to have_content(promotion.title)
    expect(page).to have_content("Criada por: #{promotion.user.email}")
    expect(page).to have_content('Pendente de aprovação')
    expect(page).to have_content(promotion.description)
    expect(page).to have_content('Desconto:')
    expect(page).to have_content(promotion.discount)
    expect(page).to have_content('Início:')
    expect(page).to have_content(promotion.start_at)
    expect(page).to have_content('Expira em:')
    expect(page).to have_content(promotion.end_at)
    expect(page).to have_content('Prefixo:')
    expect(page).to have_content(promotion.prefix)
    expect(page).to have_content('Qtde cupons:')
    expect(page).to have_content(promotion.quantity)
    expect(page).to have_content('Duração:')
    expect(page).to have_content(promotion.duration)
  end
end
