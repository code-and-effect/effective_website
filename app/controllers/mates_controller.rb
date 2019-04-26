class MatesController < ApplicationController
  before_action :authenticate_user!

  include Effective::CrudController
end
