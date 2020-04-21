class ApiController < ActionController::Base

  before_action :validate_header

  private

  def validate_header
    if request.headers["Content-Type"] != "application/vnd.api+json"
      render json: {}, status: 400 
      return
    end
  end
end