class Store < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :url, presence: true
  has_many :products, dependent: :destroy
  belongs_to :user

  before_destroy :destroy_products
end

def destroy_products
  self.products.destroy
end
