class BasketPriceCalculator
  def initialize(products_ids)
    @products_ids = products_ids
  end

  def sum
    result = 0

    products_by_ids(@products_ids).each do |_id, products|
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

  private

  def products_by_ids(products_ids)
    products = Product.where(id: products_ids).index_by(&:id)
    products_ids.map { |id| products[id] }.group_by(&:id)
  end
end
