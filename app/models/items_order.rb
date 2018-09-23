class ItemsOrder < ApplicationRecord
  # validates item and order id exist
  validates :item_id, presence: true
  validates :order_id, presence: true

  # belongs to an item, and an order
  belongs_to :item
  belongs_to :order
end
