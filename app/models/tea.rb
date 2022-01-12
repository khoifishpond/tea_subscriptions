class Tea < ApplicationRecord
  has_many :subscriptions
  has_many :customers, through: :subscriptions

  validates :name, uniqueness: true, presence: true
  validates :description, presence: true
  validates :temperature, presence: true
  validates :brew_time, presence: true
end
