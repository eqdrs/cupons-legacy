require 'rails_helper'

feature 'User burns coupon' do
  scenario 'successfully' do
    user = login_user
    approver = create(:user)
    promotion = create(:promotion, user: user, quantity: 3, prefix: 'DEV')
    create(:promotion_approval, promotion: promotion,
                                user: approver)
    promotion.generate_coupons(user)

    visit coupons_path(promotion)
    click_on 'Queimar cupom'
    fill_in 'Código do cupom', with: 'DEV0001'
    fill_in 'Motivo', with: 'Cupom extraviado.'
    click_on 'Queimar'

    expect(current_path).to eq burn_path
    expect(page).to have_content 'Cupom queimado com sucesso'
  end

  scenario 'and can view burned cupon' do
    user = login_user
    approver = create(:user)
    promotion = create(:promotion, user: user, quantity: 3, prefix: 'DEV')
    create(:promotion_approval, promotion: promotion,
                                user: approver)
    promotion.generate_coupons(user)
    burned_coupon = Coupon.first
    burned_coupon.burn_coupon(user, 'Extraviado')

    visit coupons_path(promotion)

    expect(page).to have_content "#{burned_coupon.code} (burned)"
  end

  scenario 'and must give a reason' do
    user = login_user
    approver = create(:user)
    promotion = create(:promotion, user: user, quantity: 3, prefix: 'DEV')
    create(:promotion_approval, promotion: promotion,
                                user: approver)
    promotion.generate_coupons(user)

    visit coupons_path(promotion)
    click_on 'Queimar cupom'
    fill_in 'Código do cupom', with: 'DEV0001'
    fill_in 'Motivo', with: ''
    click_on 'Queimar'

    expect(current_path).to eq burn_path
    expect(page).to have_content 'Você deve informar um motivo'
    expect(page).not_to have_content 'Cupom queimado com sucesso'
  end

  scenario 'and must type a valid coupon code' do
    user = login_user
    approver = create(:user)
    promotion = create(:promotion, user: user, quantity: 3, prefix: 'DEV')
    create(:promotion_approval, promotion: promotion,
                                user: approver)
    promotion.generate_coupons(user)

    visit coupons_path(promotion)
    click_on 'Queimar cupom'
    fill_in 'Código do cupom', with: 'INVALIDCOUPON'
    fill_in 'Motivo', with: 'Extraviado'
    click_on 'Queimar'

    expect(current_path).to eq burn_path
    expect(page).to have_content 'Você deve informar um código válido'
    expect(page).not_to have_content 'Cupom queimado com sucesso'
  end
end
