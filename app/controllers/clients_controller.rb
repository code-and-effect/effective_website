# My Clients
class ClientsController < ApplicationController
  before_action :authenticate_user!

  include Effective::CrudController

  resource_scope -> { Client.deep.for_user(current_user) }

  before_action(only: :index) do
    clients_length = resource_scope.to_a.length

    if clients_length == 0
      flash[:danger] = 'Your website account does not belong to any client groups. Please contact the webmaster for assistance.'
      redirect_to root_path
    end

    if clients_length == 1
      redirect_to client_path(resource_scope.first)
    end
  end

end
