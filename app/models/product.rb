class Product < ApplicationRecord
  has_many :items, dependent: :destroy
  #before_validation :set_items
  after_create :set_items
  before_destroy :destroy_items

  def set_items
    self.items.create([
      {name: (self.name + " (base)"), value: self.value},
      {name: (self.name + " (+1 year service)"), value: (self.value + 10.00)},
      {name: (self.name + " (+2 year service)"), value: (self.value + 20.00)}
      ])
  end

  def destroy_items
    self.items.destroy
  end
end
