class Store < ApplicationRecord
  # validates and ensures the following fields
  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :url, presence: true
  validates :user_id, presence: true


  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  belongs_to :user

end
