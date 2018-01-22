require 'ffaker'
require 'date'

Promotion.create!({
  title: 'Quero ser Dev',
  description: 'Desconto para os selecionados do quero ser dev para utilizarem os produtos da locaweb.',
  discount: 70.0,
  start_at: DateTime.now,
  prefix: 'SOMOSDEV',
  quantity: 14,
  duration: 180
})

Promotion.create!({
  title: 'Revista Locaweb',
  description: 'Cupons de desconto para distribuir na revista Locaweb',
  discount: 50.0,
  start_at: DateTime.now,
  prefix: 'REVLOC',
  quantity: 100,
  duration: 180
})

FactoryGirl.create(:user, email: 'admin@apicoupons.com')
