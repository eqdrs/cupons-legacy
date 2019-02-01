require 'rails_helper'

RSpec.describe 'Coupons API' do
  describe 'GET' do
    it 'should get an active coupon' do
      user = create(:user)
      promotion = create(:promotion, quantity: 1, prefix: 'API')
      create(:promotion_approval, promotion: promotion)
      promotion.generate_coupons(user)

      get '/api/v1/coupons/API0001'

      coupon = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(coupon['code']).to eq 'API0001'
      expect(coupon['status']).to eq 'active'
    end

    it 'should get a burned coupon' do
      user = create(:user)
      promotion = create(:promotion, quantity: 1, prefix: 'API')
      create(:promotion_approval, promotion: promotion)
      promotion.generate_coupons(user)
      Coupon.first.burn_coupon(user, 'Extraviado')

      get '/api/v1/coupons/API0001'

      coupon = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(coupon['code']).to eq 'API0001'
      expect(coupon['status']).to eq 'burned'
    end

    it 'can\'t get nonexistent coupon' do
      get '/api/v1/coupons/NONEXISTENT'

      expect(response).to have_http_status(404)
      expect(response.body).to include 'Cupom inexistente!'
    end
  end

  describe 'POST' do
    it 'should burn a valid coupon' do
      user = create(:user)
      promotion = create(:promotion, quantity: 1, prefix: 'API')
      create(:promotion_approval, promotion: promotion)
      promotion.generate_coupons(user)

      post '/api/v1/coupons/burn/API0001', app: 'PromoApp',
                                           purchase_number: '543'

      coupon = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(coupon['code']).to eq 'API0001'
      expect(coupon['status']).to eq 'used'
      expect(coupon['app']).to eq 'PromoApp'
      expect(coupon['purchase_number']).to eq '543'
    end

    it 'can\'t burn nonexistent coupon' do
      post '/api/v1/coupons/burn/UNEXISTENT', app: 'PromoApp',
                                              purchase_number: '543'

      expect(response).to have_http_status(404)
      expect(response.body).to include 'Cupom inexistente!'
    end

    it 'should not be able to use a burned coupon' do
      user = create(:user)
      promotion = create(:promotion, quantity: 1, prefix: 'API')
      create(:promotion_approval, promotion: promotion)
      promotion.generate_coupons(user)
      Coupon.first.burn_coupon(user, 'Extraviado')

      post '/api/v1/coupons/burn/API0001', app: 'PromoApp',
                                           purchase_number: '543'

      expect(response).to have_http_status(412)
      expect(response.body).to include 'Cupom inválido!'
    end

    it 'can\'t repeat purchase number' do
      user = create(:user)
      promotion = create(:promotion, quantity: 2, prefix: 'API')
      create(:promotion_approval, promotion: promotion)
      promotion.generate_coupons(user)
      Coupon.first.update(app: 'PromoApp', purchase_number: '555',
                          status: :used)

      post '/api/v1/coupons/burn/API0002', app: 'PromoApp',
                                           purchase_number: '555'

      expect(response).to have_http_status(412)
      expect(response.body).to include 'Número do pedido inválido!'
    end
  end
end
