Rspec.describe Types::QueryType do
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

      Order.new(
        subTotal: 0.00,
        adjusted: 0.00,
        savings: 0.00,
        tax: 0.00,
        total: 0.00,
        store_id: 1,
        user_id: 1
      ).save()
  end
  types = GraphQL::Define::TypeDefiner.instance

  context 'validate return types' do
    it 'has :stores which returns [Types::StoreType]' do
      expect(subject).to have_field(:stores).that_returns(!types[Types::StoreType])
    end

    it 'has :users which returns [Types::UserType]' do
      expect(subject).to have_field(:users).that_returns(!types[Types::UserType])
    end

    it 'has :getMe which returns Types::UserType' do
      expect(subject).to have_field(:getMe).that_returns(Types::UserType)
    end

    it 'has :orders which returns [Types::OrderType]' do
      expect(subject).to have_field(:orders).that_returns(!types[Types::OrderType])
    end

    it 'has :products which returns [Types::ProductType]' do
      expect(subject).to have_field(:products).that_returns(!types[Types::ProductType])
    end
  end

  context 'validating stores search' do
    it 'returns all stores in the db' do
      query_result = subject.fields['stores'].resolve(nil, {}, nil)
      expect(query_result.count).to eq(1)
    end

    it 'returns no stores because of an id filter' do
      query_result = subject.fields['stores'].resolve(nil, {id: 2}, nil)
      expect(query_result.count).to eq(0)
    end
  end

  context 'validating users search' do
    it 'returns all users in db because no args are specified' do
      user = User.find_by(id: 1)
      query_result = subject.fields['users'].resolve(nil, {token: user.authentication_token}, nil)
      expect(query_result.count).to eq(1)
    end

    it 'errors because an owner token is not passed' do
      query_result = subject.fields['users'].resolve(nil, {}, nil)
      expect(query_result == GraphQL::ExecutionError.new("You do not have the rights to view all the orders"))
    end

    it 'returns no users because of an id filter' do
      user = User.find_by(id: 1)
      query_result = subject.fields['users'].resolve(nil, {token: user.authentication_token, id: 2}, nil)
      expect(query_result.count).to eq(0)
    end
  end

  context 'validating getMe' do
    it 'returns the user successfully because the token matches' do
      user = User.find_by(id: 1)
      query_result = subject.fields['getMe'].resolve(nil, {token: user.authentication_token}, nil)
      expect(query_result == user)
    end

    it 'errors because the token does not match a user' do
      query_result = subject.fields['getMe'].resolve(nil, {token: 'badToken'}, nil)
      expect(query_result == GraphQL::ExecutionError.new("You must login before requesting your own customer profile"))
    end
  end

  context 'validating the orders query' do
    it 'returns all the orders because no args are specified' do
      user = User.find_by(id: 1)
      query_result = subject.fields['orders'].resolve(nil, {token: user.authentication_token}, nil)
      expect(query_result.count).to eq(1)
    end

    it 'errors because an improper token is passed' do
      query_result = subject.fields['orders'].resolve(nil, {token: 'badToken'}, nil)
      expect(query_result == GraphQL::ExecutionError.new("You do not have the rights to view all the orders"))
    end

    it 'returns no orders because of an id filter' do
      user = User.find_by(id: 1)
      query_result = subject.fields['orders'].resolve(nil, {userId: 100, token: user.authentication_token}, nil)
      expect(query_result.count).to eq(0)
    end
  end

  context 'validating the product query' do
    it 'returns all products because no args are passed' do
      query_result = subject.fields['products'].resolve(nil, {}, nil)
      expect(query_result.count).to eq(1)
    end

    it 'returns no products because of an id filter' do
      query_result = subject.fields['products'].resolve(nil, {storeId: 100}, nil)
      expect(query_result.count).to eq(0)
    end
  end

end
