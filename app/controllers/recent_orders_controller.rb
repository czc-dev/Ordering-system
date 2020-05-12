class RecentOrdersController < ApplicationController
  def index
    @orders = Order.recently_created
  end
end
