require 'rails_helper'

RSpec.describe BasketPriceCalculator do
  describe '#sum' do
    it 'sums up products prices' do
      apple = create(:product, code: 'AP1', price: 3, apply_discount: false)
      lemon = create(:product, code: 'LM1', price: 4, apply_discount: false)
      products_counts = { apple => 1, lemon => 1 }

      expect(described_class.new(products_counts).sum).to eq(3 + 4)
    end

    it 'handles summing up the prices of products with discounts' do
      apple = create(:product, code: 'AP1', price: 3, count_for_discount: 3, discount: 0.3333, apply_discount: true)
      lemon = create(:product, code: 'LM1', price: 4, count_for_discount: 2, discount: 0.5, apply_discount: true)
      products_counts = { apple => 3, lemon => 5 }

      sum = (3 + 3 + 3) * 0.6667 + (4 + 4 + 4 + 4) * 0.5 + 4
      expect(described_class.new(products_counts).sum).to eq(sum)
    end
  end

  context 'when using task description data' do
    let(:tea) do
      create(:product, code: 'GR1', name: 'Green Tea', price: 3.11, count_for_discount: 2,
        discount: 0.50, apply_discount: true)
    end

    let(:strawberries) do
      create(:product, code: 'SR1', name: 'Strawberries', price: 5.00, count_for_discount: 3,
        discount: 0.10, apply_discount: true)
    end

    let(:coffee) do
      create(:product, code: 'CF1', name: 'Coffee', price: 11.23, count_for_discount: 3,
        discount: 0.3333, apply_discount: true)
    end

    let(:product_by_codes) do
      [tea, strawberries, coffee].index_by(&:code)
    end

    def expect_products_row_to_cost_price(products_row, price)
      products_counts = products_row.split(',').tally.transform_keys { product_by_codes[_1] }

      expect(described_class.new(products_counts).sum.round(2)).to eq(price)
    end

    it 'calculates the price according to test data' do
      expect_products_row_to_cost_price('GR1,SR1,GR1,GR1,CF1', 22.45)
      expect_products_row_to_cost_price('GR1,GR1', 3.11)
      expect_products_row_to_cost_price('GR1,CF1,SR1,CF1,CF1', 30.57)
    end
  end
end
