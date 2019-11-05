class ApplicationController < ActionController::Base
  before_action :set_query

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def set_query
    @q = Listing.ransack(params[:q])
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end
end
