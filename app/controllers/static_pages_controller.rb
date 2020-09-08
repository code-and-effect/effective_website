class StaticPagesController < ApplicationController
  skip_authorization_check # CanCanCan

  def home
    @page_title = "Example Website"

    if current_user.present?
      return dashboard
    end

    render("static_pages/home")
  end

  def dashboard
    @page_title = "Dashboard"

    authenticate_user!
    authorize! :show, :dashboard

    render("static_pages/dashboard")
  end

end
