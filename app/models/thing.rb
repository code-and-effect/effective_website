class Thing < ApplicationRecord
  belongs_to :user

  # Attributes
  # name        :string
  # body        :text

  validates :name, presence: true
  validates :body, presence: true
end
