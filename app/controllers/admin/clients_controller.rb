class Admin::ClientsController < Admin::ApplicationController
  include Effective::CrudController

  protected

  def permitted_params
    params.require(:client).permit!
  end
end
