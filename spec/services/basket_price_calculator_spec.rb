require 'rails_helper'

RSpec.describe BasketPriceCalculator do
  describe '#sum' do
    it 'sums up products prices' do
      apple = build(:product, code: 'AP1', price: 3, count_for_discount: nil, discount: nil)
      lemon = build(:product, code: 'LM1', price: 4, count_for_discount: nil, discount: nil)
      products = [apple, lemon]

      expect(described_class.new(products).sum).to eq(3 + 4)
    end

    it 'handles summing up the prices of products with discounts' do
      apple = build(:product, code: 'AP1', price: 3, count_for_discount: 3, discount: 0.3333)
      lemon = build(:product, code: 'LM1', price: 4, count_for_discount: 2, discount: 0.5)
      products = [apple] * 3 + [lemon] * 3

      sum = (3 + 3 + 3) * 0.6666 + (4 + 4) * 0.5 + 4
      expect(described_class.new(products).sum).to eq(sum)
    end
  end
end
