class Product < ApplicationRecord
  has_many :items, dependent: :destroy
  #before_validation :set_items
  after_create :set_items
  after_save :update_items
  before_destroy :destroy_items

  def set_items
    self.items.create([
      {name: (self.name + " (base)"), value: self.value},
      {name: (self.name + " (+1 year service)"), value: (self.value + 10.00)},
      {name: (self.name + " (+2 year service)"), value: (self.value + 20.00)}
      ])
  end

  def update_items
    start = ((self.id - 1) * 3)
    puts "about to check the self id, for some reason all are getting called"
    puts self.id
    #Item.where("product_id" == self.id).find_each do |item|
    Item.where(product_id: self.id).find_each do |item|
      # these are items who have the product id corresponding to the updated item
      case item.id
      when (start + 1)
        item.update(name: (self.name + " (base)"), value: self.value)
      when (start + 2)
        item.update(name: (self.name + " (+1 year service)"), value: (self.value + 10.00))
      when (start + 3)
        item.update(name: (self.name + " (+2 year service)"), value: (self.value + 20.00))
      else
        puts "Error!"
        puts item.id
      end
    end
  end

  def destroy_items
    self.items.destroy
  end
end
