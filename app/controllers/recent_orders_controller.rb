class RecentOrdersController < ApplicationController
  def index
    @orders = Order.lists_recently_created
  end
end
