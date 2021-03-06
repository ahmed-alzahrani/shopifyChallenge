require 'rails_helper'

RSpec.describe Product, type: :model do
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
    end

   it 'ensures name presence' do
      product = Product.new(
        value: 24.99,
        tags: "",
        store_id:1
      )
      expect {product.save()}.to raise_error(I18n::InvalidLocaleData)
    end

    it 'ensures value presence' do
      product = Product.new(
        name: 'test',
        tags: '',
        store_id:1
      )
      expect {product.save()}.to raise_error(I18n::InvalidLocaleData)
    end

    it 'ensures tags presence' do
      product = Product.new(
        name: 'test',
        value: 1.99,
        store_id:1
      )
      expect {product.save()}.to raise_error(I18n::InvalidLocaleData)
    end

    it 'ensures store_id presence' do
      product = Product.new(
        name: 'test',
        value: 24.99,
        tags: 'tag',
      )
      expect {product.save()}.to raise_error(I18n::InvalidLocaleData)
    end

    it 'ensures store_id validity' do
      product = Product.new(
        name: 'test',
        value: 24.99,
        tags: 'tag',
        store_id: 100
      )
      expect {product.save()}.to raise_error(I18n::InvalidLocaleData)
    end

    it 'should save successfully' do

      #store = Store.order("id").last
      product = Product.new(
        name: "test",
        value: 24.99,
        tags: "tags",
        store_id: 1
      )
      expect {product.save()}.not_to raise_error
    end
  end
end
