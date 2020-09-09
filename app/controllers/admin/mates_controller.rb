class Admin::MatesController < Admin::ApplicationController
  include Effective::CrudController

  protected

  def permitted_params
    params.require(:mate).permit!
  end
end
