class Product < ApplicationRecord
  has_many :items
  #before_validation :set_items
  after_create :set_items

  def set_items
    self.items.create([
      {name: (self.name + " (base)"), value: self.value},
      {name: (self.name + " (+1 year service)"), value: (self.value + 10.00)},
      {name: (self.name + " (+2 year service)"), value: (self.value + 20.00)}
      ])
  end
end
