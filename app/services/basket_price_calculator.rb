class BasketPriceCalculator
  def initialize(basket_products_counts)
    @basket_products_counts = basket_products_counts
  end

  def sum
    result = 0
    return result if @basket_products_counts.blank?

    @basket_products_counts.each do |product, count|
      if product.apply_discount
        no_discount_products_count = count % product.count_for_discount

        result += no_discount_products_count * product.price
        result += (count - no_discount_products_count) * product.price * (1 - product.discount)
      else
        result += product.price * count
      end
    end

    result
  end
end
