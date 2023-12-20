class Api::V1::BaseController < ApplicationController
  rescue_from ActionController::RoutingError, with: :render_not_found

  private

  def render_not_found
    render json: { error: "Record not found" }, status: 404
  end

  def performance_monitor
    PerformanceMonitor.new
  end
end
