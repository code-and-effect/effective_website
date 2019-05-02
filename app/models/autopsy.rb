class Autopsy < ApplicationRecord
  belongs_to :created_by, class_name: 'User'

  CAUSES = ['Organ failure', 'Smokers lung', 'Too many doritos']

  effective_resource do
    name          :string
    age           :integer
    date          :datetime

    cause         :string
    description   :text

    timestamps
  end

  scope :deep, -> { includes(:created_by) }

  validates :name, presence: true
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true

  validates :cause, presence: true, inclusion: { in: CAUSES }
  validates :description, presence: true

  def to_s
    name || 'New Autopsy'
  end

end