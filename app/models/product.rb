class Product < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true
  validates :tags, presence: true
  has_many :items, dependent: :destroy
  belongs_to :store
  after_save :update_items
  before_destroy :destroy_items

  def update_items
    one_year_value = ((self.value + 10.00) * 100).round / 100.0
    two_year_value = ((self.value + 20.00) * 100).round / 100.0
    items = Item.where(product_id: self.id)
    if items.length > 0
      # we use this counter to trim all legacy items except the first three
      i = 0
      items.each { |item|
        if i > 2
          # delete the item if it's beyond the third item for this product that has been changed
          item.destroy
        else
          #update the item according to which iteration we're at
          case i
          when 0
            item.update(name: (self.name + " (base)"), value: self.value)
          when 1
            item.update(name: (self.name + " (+1 year service)"), value: one_year_value)
          when 2
            item.update(name: (self.name + " (+2 year service)"), value: two_year_value)
          end
        end
        i += 1
      }
    else
      # this is a product creation, we have to create three new items for the product

      #create our base item
      Item.create!(
        name: (self.name + " (base)"),
        product_id: self.id,
        value: self.value
      )

      #create our 1 year service version
      Item.create!(
        name: (self.name + " (+1 year service)"),
        product_id: self.id,
        value: one_year_value
      )

      #create our 2 year service version
      Item.create!(
        name: (self.name + " (+2 year service)"),
        product_id: self.id,
        value: two_year_value
      )
    end
  end

  def destroy_items
    self.items.destroy
  end
end
