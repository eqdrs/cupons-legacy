require 'rails_helper'

RSpec.describe Promotion, type: :model do
  before do
    @promotion = create(:promotion)
  end

  describe 'validation' do
    it 'valid promotion' do
      promotion = build(:promotion)
      expect(promotion).to be_valid
    end

    it 'invalid promotion' do
      promotion = Promotion.new
      expect(promotion).to_not be_valid
    end

    it 'prefix must have at least 3 characters - Failed' do
      promotion = Promotion.new(attributes_for(:promotion))
      promotion.prefix = 'A'
      expect(promotion).to_not be_valid
    end

    it 'prefix must have at least 3 characters Success' do
      promotion = build(:promotion, prefix: 'DEV')
      expect(promotion).to be_valid
    end

    it 'invalid start_at date' do
      promotion = build(:promotion, start_at: 'Blah')
      expect(promotion).to_not be_valid
    end
  end

  describe 'creating_promotion' do
    it 'set end_at with 5 days' do
      @promotion.save
      expect(@promotion.end_at).to eq @promotion.start_at.end_of_day +
                                      @promotion.duration.days
    end
  end
end
