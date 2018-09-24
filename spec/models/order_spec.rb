require 'rails_helper'

RSpec.describe Order, type: :model do
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

    it 'ensures the subtotal exists' do
      order = Order.new(
        adjusted: 0.00,
        savings: 0.00,
        tax: 0.00,
        total: 0.00,
        store_id: 1,
        user_id: 1
      )
      expect {order.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'ensures the savings exists' do
      order = Order.new(
        subTotal: 0.00,
        adjusted: 0.00,
        tax: 0.00,
        total: 0.00,
        store_id: 1,
        user_id: 1
      )
      expect {order.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'ensures the adjusted exists' do
      order = Order.new(
        subTotal: 0.00,
        savings: 0.00,
        tax: 0.00,
        total: 0.00,
        store_id: 1,
        user_id: 1
      )
      expect {order.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'ensures the tax exists' do
      order = Order.new(
        subTotal: 0.00,
        adjusted: 0.00,
        savings: 0.00,
        total: 0.00,
        store_id: 1,
        user_id: 1
      )
      expect {order.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'ensures the total exists' do
      order = Order.new(
        subTotal: 0.00,
        adjusted: 0.00,
        savings: 0.00,
        tax: 0.00,
        store_id: 1,
        user_id: 1
      )
      expect {order.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'ensures the store_id exists' do
      order = Order.new(
        subTotal: 0.00,
        adjusted: 0.00,
        savings: 0.00,
        tax: 0.00,
        total: 0.00,
        user_id: 1
      )
      expect {order.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'ensures the store_id is valid' do
      order = Order.new(
        subTotal: 0.00,
        adjusted: 0.00,
        savings: 0.00,
        tax: 0.00,
        total: 0.00,
        store_id: 100,
        user_id: 1
      )
      expect {order.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'ensures the user_id exists' do
      order = Order.new(
        subTotal: 0.00,
        adjusted: 0.00,
        savings: 0.00,
        tax: 0.00,
        total: 0.00,
        store_id: 1
      )
      expect {order.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'ensures the user_id is valid' do
      order = Order.new(
        subTotal: 0.00,
        adjusted: 0.00,
        savings: 0.00,
        tax: 0.00,
        total: 0.00,
        store_id: 1,
        user_id: 100
      )
      expect {order.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'should save successfully' do
      order = Order.new(
        subTotal: 0.00,
        adjusted: 0.00,
        savings: 0.00,
        tax: 0.00,
        total: 0.00,
        store_id: 1,
        user_id: 1
      )
      expect {order.save()}.not_to raise_error
    end
  end
end
