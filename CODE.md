class Autopsy < ApplicationRecord
  belongs_to :created_by, class_name: 'User'

  CAUSES = ['Heart attack', 'Organ failure', 'Ruby-eosis iridis', 'Teenagers']

  effective_resource do
    name          :string
    
    age           :integer
    date          :datetime

    cause         :string
    description   :text

    timestamps
  end

  scope :deep, -> { includes(:created_by) }
  scope :sorted, -> { order(:name) }

  validates :name, presence: true
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true

  validates :cause, presence: true, inclusion: { in: CAUSES }
  validates :description, presence: true

  def to_s
    name || 'New Autopsy'
  end

end


def index
  @page_title = 'Clients'
  authorize! :index, Client

  @datatable = ClientsDatatable.new()
end

def edit
  @client = Client.find(params[:id])

  @page_title = "Edit #{@client}"
  authorize! :edit, @client 
end

def update
  @client = Client.find(params[:id])

  @page_title = "Edit #{@client}"
  authorize! :update, @client 

  if @client.update(client_params)
    flash[:success] = 'Successfully updated client'
    redirect_to admin_client_path(@client)
  else
    flash.now[:error] = "Unable to save client: #{@client.errors.full_messages.to_sentence}."
    render :edit
  end
end

private

def client_params
  params.require(:client).permit(:name, :age)
end
