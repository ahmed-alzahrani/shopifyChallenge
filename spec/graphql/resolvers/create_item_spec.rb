RSpec.describe Resolvers::CreateItem do
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

  it 'Errors because the token passed in is bad' do
    subject(:result) do
      described_class.new.call(obj, args, ctx)
    end

    let(:args) {{}}

    expect(result == GraphQL::ExecutionError.new("You do not have owner rights to create new items"))
  end
=begin
  it 'Errors because the store does not exist' do
  end

  it 'Errors because the product does not exist' do
  end

  it 'Errors because the item is less in value than the product' do
  end

  it 'Successfully creates a new item' do
  end
=end
end
