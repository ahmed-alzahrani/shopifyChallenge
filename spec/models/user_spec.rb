require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures the first_name presence' do
      user = User.new(
        last_name: 'Programmer',
        email: 'Peter@example.com',
        password: 'password',
        owner: true
      )
      expect {user.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'ensures the last_name presence' do
      user = User.new(
        first_name: 'Peter',
        email: 'Peter@example.com',
        password: 'password',
        owner: true
      )
      expect {user.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'ensures the email presence' do
      user = User.new(
        first_name: 'Peter',
        last_name: 'Programmer',
        password: 'password',
        owner: true
      )
      expect {user.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'ensures the password is present' do
      user = User.new(
        first_name: 'Peter',
        last_name: 'Programmer',
        email: 'Peter@example.com',
        owner: true
      )
      expect {user.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'ensures the email is unique' do
      User.new(
        first_name: 'Peter',
        last_name: 'Programmer',
        email: 'Peter@example.com',
        password: 'password',
        owner: true
      ).save()
      user = User.new(
        first_name: 'Peter',
        last_name: 'Programmer',
        email: 'Peter@example.com',
        password: 'password',
        owner: true
      )
      expect {user.save()}.to raise_error(I18n::InvalidLocaleData)
    end
    it 'should save successfully' do
      user = User.new(
        first_name: 'Peter',
        last_name: 'Programmer',
        email: 'Peter@example.com',
        password: 'password',
        owner: true
      )
      expect {user.save()}.not_to raise_error
    end
  end
end
