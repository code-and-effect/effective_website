class Thing < ApplicationRecord

  # Attributes
  # name        :string
  # description :text

  validates :name, presence: true
  validates :description, presence: true

  def to_s
    name || 'New Thing'
  end

end
