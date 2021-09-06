class ProductsController < ApplicationController
  before_action :load_cart_products, only: %i[index]
  helper_method :cart_products_ids

  def index
    @all_products = Product.all
  end

  def add_to_cart
    session[:cart_products_ids] ||= []
    session[:cart_products_ids] << params[:id]
    load_cart_products
    render turbo_stream: turbo_stream.replace(:cart, partial: 'products/cart')
  end

  def clear_cart
    session.delete(:cart_products_ids)
    load_cart_products
    render turbo_stream: turbo_stream.replace(:cart, partial: 'products/cart')
  end

  private

  def load_cart_products
    @cart_products = Product.where(id: session[:cart_products_ids])
  end

  def cart_products_ids
    @cart_products_ids ||= (session[:cart_products_ids] || []).map(&:to_i)
  end
end
