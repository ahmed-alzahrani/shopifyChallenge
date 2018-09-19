class Product < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true
  validates :tags, presence: true
  has_many :items, dependent: :destroy
  belongs_to :store
  after_save :update_items
  before_destroy :destroy_items

  def update_items
    start = ((self.id - 1) * 3)
    one_year_value = ((self.value + 10.00) * 100).round / 100.0
    two_year_value = ((self.value + 20.00) * 100).round / 100.0
    Item.where(product_id: self.id).find_each do |item|
      # these are items who have the product id corresponding to the updated item
      case item.id
      when (start + 1)
        item.update(name: (self.name + " (base)"), value: self.value)
      when (start + 2)
        item.update(name: (self.name + " (+1 year service)"), value: one_year_value)
      when (start + 3)
        item.update(name: (self.name + " (+2 year service)"), value: two_year_value)
      else
      end
    end
  end

  def destroy_items
    self.items.destroy
  end
end
