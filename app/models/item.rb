class Item < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true
  belongs_to :product
  has_and_belongs_to_many :order
end
