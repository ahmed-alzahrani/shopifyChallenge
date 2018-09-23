class Order < ApplicationRecord

  # validate and ensure the following fields
  validates :created, presence: true
  validates :subTotal, presence: true
  validates :savings, presence: true
  validates :adjusted, presence: true
  validates :tax, presence: true
  validates :total, presence: true
  validates :store_id, presence: true
  validates :user_id, presence: true

  belongs_to :user # an order belongs to a user
  belongs_to :store # an order belongs to a store
  has_and_belongs_to_many :items # an order has 1-n items
end
