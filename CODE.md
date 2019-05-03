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