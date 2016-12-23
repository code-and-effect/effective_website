class ThingsController < ApplicationController
  before_action :authenticate_user! # Devise enforce user is present

  def index
    @page_title = 'Things'
    authorize! :index, Thing

    @datatable = Effective::Datatables::Things.new(params[:scopes])
  end

  def new
    @thing = Thing.new

    @page_title = 'New Thing'
    authorize! :new, @thing
  end

  def create
    @thing = Thing.new(permitted_params)

    @page_title = 'New Thing'
    authorize! :create, @thing

    if @thing.save
      flash[:success] = 'Successfully created thing'
      redirect_to(redirect_path)
    else
      flash.now[:danger] = "Unable to create thing: #{@thing.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def show
    @thing = Thing.find(params[:id])

    @page_title = @thing.to_s
    authorize! :show, @thing
  end

  def edit
    @thing = Thing.find(params[:id])

    @page_title = "Edit #{@thing}"
    authorize! :edit, @thing
  end

  def update
    @thing = Thing.find(params[:id])

    @page_title = "Edit #{@thing}"
    authorize! :update, @thing

    if @thing.update_attributes(permitted_params)
      flash[:success] = 'Successfully updated thing'
      redirect_to(redirect_path)
    else
      flash.now[:danger] = "Unable to update thing: #{@thing.errors.full_messages.to_sentence}"
      render :edit
    end
  end

  def destroy
    @thing = Thing.find(params[:id])
    authorize! :destroy, @thing

    if @thing.destroy
      flash[:success] = 'Successfully deleted thing'
    else
      flash.now[:danger] = "Unable to delete thing: #{@thing.errors.full_messages.to_sentence}"
    end

    redirect_to things_path
  end

  private

  def permitted_params
    params.require(:thing).permit(:id,
      :name, :description
    )
  end

  def redirect_path
    case params[:commit].to_s
    when 'Save'
      edit_thing_path(@thing)
    when 'Save and Continue'
      things_path
    when 'Save and Add New'
      new_thing_path
    else
      raise 'Unexpected redirect path'
    end
  end

end
