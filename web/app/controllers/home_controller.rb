class HomeController < ApplicationController
  def index
    @logs = Log.all.order(created_at: :desc).limit(10).includes(:employee)
  end
end
