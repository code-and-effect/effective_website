class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!

  layout 'admin'
end
