class Item < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true
  belongs_to :product
end
