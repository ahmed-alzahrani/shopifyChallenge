require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'validation tests' do
    before(:each) do
      User.new(
        first_name: 'Peter',
        last_name: 'Programmer',
        email: 'Peter@example.com',
        password: 'password',
        owner: true
      ).save()

      Store.create({
        name: 'Peter\'s Programming Paradise',
        email: 'petersprogrammingparadise@example.com',
        phone: '613-555-5555',
        url: 'www.petersprogrammingparadise.example.com',
        user_id: 1
      })

      Product.create({
        name: 'ios/Swift',
        value: 34.99,
        tags: 'mobile',
        store_id: 1
        })
    end

    it 'ensures the name\'s presence' do
      item = Item.new(
        value: 1.99,
        product_id: 1
      )
      expect {item.save()}.to raise_error(I18n::InvalidLocaleData)
    end

    it 'ensures value\'s presence' do
      item = Item.new(
        name: 'test',
        product_id: 1
      )
      expect {item.save()}.to raise_error(I18n::InvalidLocaleData)
    end

    it 'ensures the product id is present' do
      item = Item.new(
        name: 'test',
        value: 1.99
      )
      expect {item.save()}.to raise_error(I18n::InvalidLocaleData)
    end

    it 'ensures the product id is valid' do
      item = Item.new(
        name: 'test',
        value: 1.99,
        product_id: 100
      )
      expect {item.save()}.to raise_error(I18n::InvalidLocaleData)
    end

    it 'should save successfully' do
      item = Item.new(
        name: 'test',
        value: 1.99,
        product_id: 1
      )
      expect {item.save()}.not_to raise_error
    end
  end
end
