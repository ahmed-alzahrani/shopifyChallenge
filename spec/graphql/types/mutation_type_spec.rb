Rspec.describe Types::MutationType do
  context 'validate return types' do
    # Product mutations
    it 'has a create product mutation that returns type ProductType' do
      expect(subject).to have_field(:CreateProduct).that_returns(Types::ProductType)
    end

    it 'has an update product mutation that returns type ProductType' do
      expect(subject).to have_field(:UpdateProduct).that_returns(Types::ProductType)
    end

    it 'has a delete product mutation that returns type ProductType' do
      expect(subject).to have_field(:DeleteProduct).that_returns(Types::ProductType)
    end

    # Item mutations
    it 'has a create item mutation that returns type ItemType' do
      expect(subject).to have_field(:CreateItem).that_returns(Types::ItemType)
    end

    it 'has an update item mutation that returns type ItemType' do
      expect(subject).to have_field(:UpdateItem).that_returns(Types::ItemType)
    end

    it 'has a delete item mutation that returns type ItemType' do
      expect(subject).to have_field(:DeleteItem).that_returns(Types::ItemType)
    end

    # User mutations
    it 'has a create user mutation that returns type UserType' do
      expect(subject).to have_field(:CreateUser).that_returns(Types::UserType)
    end

    it 'has a sign in user mutation that returns type AuthType' do
      expect(subject).to have_field(:SignInUser).that_returns(Types::AuthType)
    end

    it 'has an update user mutation that returns type UserType' do
      expect(subject).to have_field(:UpdateUser).that_returns(Types::UserType)
    end

    it 'has a delete user mutation that returns type UserType' do
      expect(subject).to have_field(:DeleteUser).that_returns(Types::UserType)
    end

    # Order mutations
    it 'has a create order mutation that returns type OrderType' do
      expect(subject).to have_field(:CreateOrder).that_returns(Types::OrderType)
    end

    it 'has a delete order mutation that returns type OrderType' do
      expect(subject).to have_field(:DeleteOrder).that_returns(Types::OrderType)
    end

    # Store mutations
    it 'has an update store mutation that returns type StoreType' do
      expect(subject).to have_field(:UpdateStore).that_returns(Types::StoreType)
    end

    it 'has a delete store mutation that returns type StoreType' do
      expect(subject).to have_field(:DeleteStore).that_returns(Types::StoreType)
    end
  end
end
