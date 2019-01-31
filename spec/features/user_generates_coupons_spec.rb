require 'rails_helper'

feature 'User generates coupons' do
  scenario 'successfully' do
    user = login_user
    approver = create(:user)
    promotion = create(:promotion, user: user, quantity: 15, prefix: 'DEV')
    create(:promotion_approval, promotion: promotion,
                                user: approver)

    visit promotion_path(promotion)
    click_on 'Gerar cupons'

    coupons_quantity = Coupon.count
    expect(coupons_quantity).to eq 15
    expect(page).to have_content 'Cupons emitidos com sucesso!'
    expect(page).not_to have_link 'Gerar cupons'
  end

  scenario 'and can view generated coupons' do
    user = login_user
    approver = create(:user)
    promotion = create(:promotion, user: user, quantity: 3, prefix: 'DEV')
    create(:promotion_approval, promotion: promotion,
                                user: approver)
    promotion.generate_coupons(user)

    visit promotion_path(promotion)
    click_on 'Ver cupons gerados'

    expect(current_path).to eq coupons_path(promotion)
    expect(page).to have_css('h2', text: 'Cupons da '\
                                         "promoção #{promotion.title}")
    expect(page).to have_content('DEV0001')
    expect(page).to have_content('DEV0002')
    expect(page).to have_content('DEV0002')
  end
end
