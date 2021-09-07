class ProductsController < ApplicationController
  after_action :broadcast_change, only: %i[add_to_basket clear_basket]
  helper_method :basket_products_counts

  def index
    @all_products = Product.all
  end

  def add_to_basket
    session[:basket_products_ids] ||= []
    session[:basket_products_ids] << params[:id]
  end

  def clear_basket
    session.delete(:basket_products_ids)
  end

  private

  def broadcast_change
    Turbo::StreamsChannel.broadcast_replace_to session[:session_id], :basket,
      target: :basket, partial: 'products/basket',
      locals: { basket_products_counts: basket_products_counts }
  end

  def basket_products_counts
    @basket_products_counts ||= begin
      products_by_id = Product.where(id: session[:basket_products_ids]).index_by(&:id)
      ids = (session[:basket_products_ids] || []).map(&:to_i)
      ids.map { |id| products_by_id[id] }.tally
    end
  end
end
