class BasketPriceCalculator
  def initialize(basket_products)
    @basket_products = basket_products
  end

  def sum
    result = 0
    return result if @basket_products.blank?

    @basket_products.group_by(&:id).each do |_id, products|
      product = products.first

      if product.apply_discount
        no_discount_products_count = products.length % product.count_for_discount
        result += no_discount_products_count * product.price
        result += (products.length - no_discount_products_count) * product.price * (1 - product.discount)
      else
        result += products.sum(&:price)
      end
    end

    result
  end
end
