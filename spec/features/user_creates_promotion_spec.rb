require 'rails_helper'

feature 'Create Promotion' do
  scenario 'success' do
    login_user
    promotion = build(:promotion)

    visit new_promotion_path

    fill_in 'promotion[title]', with: promotion.title
    fill_in 'promotion[description]', with: promotion.description
    fill_in 'promotion[discount]', with: promotion.discount
    fill_in 'promotion[start_at]', with: promotion.start_at
    fill_in 'promotion[prefix]', with: promotion.prefix
    fill_in 'promotion[quantity]', with: promotion.quantity
    fill_in 'promotion[duration]', with: promotion.duration

    click_on 'commit'

    expect(page).to have_content(promotion.title)
    expect(page).to have_content(promotion.description)
    expect(page).to have_content(promotion.discount)
    expect(page).to have_content(promotion.start_at)
    expect(page).to have_content(promotion.prefix)
    expect(page).to have_content(promotion.quantity)
    expect(page).to have_content(promotion.duration)
    expect(page).to have_content(promotion.end_at)
  end

  scenario 'with blank fields' do
    login_user
    visit new_promotion_path
    click_on 'commit'

    expect(page).to have_content("Este campo é obrigatório")
  end

  scenario 'only integer values allowed' do
    login_user
    promotion = build(:promotion)
    visit new_promotion_path

    fill_in 'promotion[title]', with: promotion.title
    fill_in 'promotion[description]', with: promotion.description
    fill_in 'promotion[discount]', with: 'discount'
    fill_in 'promotion[start_at]', with: promotion.start_at
    fill_in 'promotion[prefix]', with: promotion.prefix
    fill_in 'promotion[quantity]', with: 'quantity'
    fill_in 'promotion[duration]', with: 'duration'

    click_on 'commit'

    expect(page).to have_content('Somente números são permitidos')
  end

  scenario 'only positive discounts values allowed' do
    login_user
    promotion = build(:promotion)
    visit new_promotion_path

    fill_in 'promotion[title]', with: promotion.title
    fill_in 'promotion[description]', with: promotion.description
    fill_in 'promotion[discount]', with: -30
    fill_in 'promotion[start_at]', with: promotion.start_at
    fill_in 'promotion[prefix]', with: promotion.prefix
    fill_in 'promotion[quantity]', with: promotion.quantity
    fill_in 'promotion[duration]', with: promotion.duration

    click_on 'commit'

    expect(page).to have_content('Deve ser maior que zero')
  end

  scenario 'only positive quantities values allowed' do
    login_user
    promotion = build(:promotion)
    visit new_promotion_path

    fill_in 'promotion[title]', with: promotion.title
    fill_in 'promotion[description]', with: promotion.description
    fill_in 'promotion[discount]', with: promotion.discount
    fill_in 'promotion[start_at]', with: promotion.start_at
    fill_in 'promotion[prefix]', with: promotion.prefix
    fill_in 'promotion[quantity]', with: -30
    fill_in 'promotion[duration]', with: promotion.duration

    click_on 'commit'

    expect(page).to have_content('Deve ser maior que zero')
  end

  scenario 'only positive duration values allowed' do
    login_user
    promotion = build(:promotion)
    visit new_promotion_path

    fill_in 'promotion[title]', with: promotion.title
    fill_in 'promotion[description]', with: promotion.description
    fill_in 'promotion[discount]', with: promotion.discount
    fill_in 'promotion[start_at]', with: promotion.start_at
    fill_in 'promotion[prefix]', with: promotion.prefix
    fill_in 'promotion[quantity]', with: promotion.quantity
    fill_in 'promotion[duration]', with: -30

    click_on 'commit'

    expect(page).to have_content('Deve ser maior que zero')
  end

  scenario 'date must have format dd/mm/yyyy' do
    login_user
    promotion = build(:promotion)
    visit new_promotion_path

    fill_in 'promotion[title]', with: promotion.title
    fill_in 'promotion[description]', with: promotion.description
    fill_in 'promotion[discount]', with: promotion.discount
    fill_in 'promotion[start_at]', with: '22-15-2016'
    fill_in 'promotion[prefix]', with: promotion.prefix
    fill_in 'promotion[quantity]', with: promotion.quantity
    fill_in 'promotion[duration]', with: promotion.duration
    click_on 'commit'

    expect(page).to have_content('Tem que ser uma data válida')
  end
end
