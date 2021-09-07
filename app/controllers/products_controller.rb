class ProductsController < ApplicationController
  before_action :load_basket_products, only: %i[index]
  helper_method :basket_products_ids

  def index
    @all_products = Product.all
  end

  def add_to_basket
    session[:basket_products_ids] ||= []
    session[:basket_products_ids] << params[:id]
    load_basket_products
    render turbo_stream: turbo_stream.replace(:basket, partial: 'products/basket')
  end

  def clear_basket
    session.delete(:basket_products_ids)
    load_basket_products
    render turbo_stream: turbo_stream.replace(:basket, partial: 'products/basket')
  end

  private

  def load_basket_products
    @basket_products = Product.where(id: session[:basket_products_ids])
  end

  def basket_products_ids
    @basket_products_ids ||= (session[:basket_products_ids] || []).map(&:to_i)
  end
end
