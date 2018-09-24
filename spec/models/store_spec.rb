require 'rails_helper'

RSpec.describe Store, type: :model do
  context 'validation tests' do
    before(:each) do
      User.new(
        first_name: 'Peter',
        last_name: 'Programmer',
        email: 'Peter@example.com',
        password: 'password',
        owner: true
      ).save()
    end
      it 'ensures the name\'s presence' do
        store = Store.new(
          email: 'example@example.com',
          phone: '555-555-5555',
          url: 'example.com/example',
          user_id: 1
        )
        expect {store.save()}.to raise_error(I18n::InvalidLocaleData)
      end
      it 'ensures the email\'s presence' do
        store = Store.new(
          name: 'Example Store',
          phone: '555-555-5555',
          url: 'example.com/example',
          user_id: 1
        )
        expect {store.save()}.to raise_error(I18n::InvalidLocaleData)
      end
      it 'ensures the phone\'s presence' do
        store = Store.new(
          name: 'Example Store',
          email: 'example@example.com',
          url: 'example.com/example',
          user_id: 1
        )
        expect {store.save()}.to raise_error(I18n::InvalidLocaleData)
      end
      it 'ensures the url\'s presence' do
        store = Store.new(
          name: 'Example Store',
          email: 'example@example.com',
          phone: '555-555-5555',
          user_id: 1
        )
        expect {store.save()}.to raise_error(I18n::InvalidLocaleData)
      end
      it 'ensures the user_id\'s presence' do
        store = Store.new(
          name: 'Example Store',
          email: 'example@example.com',
          phone: '555-555-5555',
          url: 'example.com/example'
        )
        expect {store.save()}.to raise_error(I18n::InvalidLocaleData)
      end
      it 'ensures the user_id\'s validity' do
        store = Store.new(
          name: 'Example Store',
          email: 'example@example.com',
          phone: '555-555-5555',
          url: 'example.com/example',
          user_id: 100
        )
        expect {store.save()}.to raise_error(I18n::InvalidLocaleData)
      end
      it 'should save successfully' do
        store = Store.new(
          name: 'Example Store',
          email: 'example@example.com',
          phone: '555-555-5555',
          url: 'example.com/example',
          user_id: 1
        )
        expect {store.save()}.not_to raise_error
      end
  end
end
