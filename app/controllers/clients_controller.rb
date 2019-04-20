# My Clients
class ClientsController < ApplicationController
  before_action :authenticate_user!

  include Effective::CrudController

  resource_scope -> { Client.deep.for_user(current_user) }

  before_action(only: :index) do
    redirect_to(client_path(resource_scope.first)) if resource_scope.to_a.length == 1
  end

end
