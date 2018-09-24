class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatables, :token_authenticatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true



  has_many :orders, dependent: :destroy
  has_many :stores, dependent: :destroy

end
