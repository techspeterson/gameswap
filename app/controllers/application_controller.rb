class ApplicationController < ActionController::Base
  before_action :set_query

  # if cancan authorisation fails, redirect to root page with an error message
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  # search query object @q is set before every action (because the search forms on the sidebar are on every page)
  def set_query
    @q = Listing.ransack(params[:q])
    @q.sorts = "created_at desc"
  end

  # redirects the user to the dashboard on successful login
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path
  end
end
