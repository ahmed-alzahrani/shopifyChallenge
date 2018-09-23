class Item < ApplicationRecord
  # validate fields
  validates :name, presence: true
  validates :value, presence: true
  validates :product_id, presence: true

  # products have items
  belongs_to :product

  # orders have 1-many items, items can belong to 1-many orders
  has_and_belongs_to_many :order
end
