# frozen_string_literal: true

class InspectionsController < ApplicationController
  before_action :set_order, only: :index

  def index
    @inspections = @order.inspections
  end

  def show
    @inspection = Inspection.find_by(id: params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_order
    @order = Order.find_by(id: params[:order_id])
  end
end
