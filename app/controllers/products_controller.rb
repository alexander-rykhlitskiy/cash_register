class ProductsController < ApplicationController
  helper_method :basket_products_counts

  def index
    @all_products = Product.all
  end

  def add_to_basket
    session[:basket_products_ids] ||= []
    session[:basket_products_ids] << params[:id]
    render turbo_stream: turbo_stream.replace(:basket, partial: 'products/basket')
  end

  def clear_basket
    session.delete(:basket_products_ids)
    render turbo_stream: turbo_stream.replace(:basket, partial: 'products/basket')
  end

  private

  def basket_products_counts
    @basket_products_counts ||= begin
      products_by_id = Product.where(id: session[:basket_products_ids]).index_by(&:id)
      ids = (session[:basket_products_ids] || []).map(&:to_i)
      ids.map { |id| products_by_id[id] }.tally
    end
  end
end
