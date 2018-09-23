class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatables, :token_authenticatable

  before_destroy :destroy_dependents
end

def destroy_dependents
  self.orders.destroy
end
