Rspec.describe Types::MutationType do
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

  context 'testing create products' do
    it 'errors if the token passed in does not belong to an owner' do
      mutation_result = subject.fields['CreateProduct'].resolve(nil, {token: 'badToken'}, nil)
      if (!(mutation_result == GraphQL::ExecutionError.new("You do not have owner rights to create new products")))
        raise
      end
    end

    it 'errors if the store id passed in does not exist' do
        user = User.order("id").last
        mutation_result = subject.fields['CreateProduct'].resolve(nil, {
          token: user.authentication_token,
          storeId: 2,
          name: 'name',
          value: 1.99
        }, nil)
      if (mutation_result != GraphQL::ExecutionError.new("You are attempting to create a product for a store that does not exist."))
        raise
      end
    end

    it 'successfully creates a product' do
      user = User.order("id").last
      mutation_result = subject.fields['CreateProduct'].resolve(nil, {
        token: user.authentication_token,
        storeId: 1,
        name: 'name',
        value: 1.99,
        tags: 'tags'
      }, nil)
      product = Product.order('id').last
      if !(product.id == mutation_result.id)
        raise
      end
    end
  end

  context 'testing update products' do
    it 'errors if the product id is invalid' do
      user = User.find_by(id: 1)
      mutation_result = subject.fields['UpdateProduct'].resolve(nil, {
        token: user.authentication_token,
        id: 100000,
        name: 'name',
        value: 8.00,
        tags: 'tagsz'
        }, nil)
        if (mutation_result != GraphQL::ExecutionError.new("The product you are attempting to update does not exist."))
          raise
        end
    end

    it 'errors if the auth token is invalid' do
      mutation_result = subject.fields['UpdateProduct'].resolve(nil, {
        token: 'badtoken',
        id: 1,
        name: 'name',
        value: 8.00,
        tags: 'tagsz'
        }, nil)
        if (mutation_result != GraphQL::ExecutionError.new("You do not have owner permission to update products."))
          raise
        end

    end

    it 'successfully updates a product' do
      user = User.find_by(id: 1)
      mutation_result = subject.fields['UpdateProduct'].resolve(nil, {
        token: user.authentication_token,
        id: 1,
        name: 'name',
        value: 8.00,
        tags: 'tagsz'
        }, nil)
        prod = Product.find_by(id: 1)
        if (prod.value != mutation_result.value || prod.id != mutation_result.id)
          raise
        end
    end
  end

  context 'testing delete product' do

    it 'errors if the product id is invalid' do
      user = User.find_by(id: 1)
      mutation_result = subject.fields['DeleteProduct'].resolve(nil, {
        token: user.authentication_token,
        id: 45
        }, nil)
        if (mutation_result != GraphQL::ExecutionError.new("The product you are attempting to destroy does not exist."))
          raise
        end
    end

    it 'errors if the auth token passed in is invalid' do
      mutation_result = subject.fields['DeleteProduct'].resolve(nil, {
        token: 'badtoken',
        id: 1
        }, nil)
        if (mutation_result != GraphQL::ExecutionError.new("You do not have owner permission to update products."))
          raise
        end
    end

    it 'successfully deletes a product' do
      user = User.find_by(id: 1)
      mutation_result = subject.fields['DeleteProduct'].resolve(nil, {
        token: user.authentication_token,
        id: 1
        }, nil)
        if (mutation_result.id != 1)
          raise
        end
    end
  end

    context 'testing create item' do

      it 'fails if the token is invalid' do
        mutation_result = subject.fields['CreateItem'].resolve(nil, {
          token: 'badtoken',
          storeId: 2,
          productId: 1,
          name: 'name',
          value: 41.00
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("You do not have owner rights to create new items"))
            raise
          end
      end

      it 'fails if the store id is invalid' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['CreateItem'].resolve(nil, {
          token: user.authentication_token,
          storeId: 2,
          productId: 1,
          name: 'name',
          value: 1.00
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("You are attempting to add an item to a store that does not exist."))
            raise
          end
      end


      it 'fails if the product id is invalid' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['CreateItem'].resolve(nil, {
          token: user.authentication_token,
          storeId: 1,
          productId: 2,
          name: 'name',
          value: 41.00
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("You are attempting to add an item to a product that does not exist."))
            raise
          end
      end

      it 'fails if the value is invalid' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['CreateItem'].resolve(nil, {
          token: user.authentication_token,
          storeId: 1,
          productId: 1,
          name: 'name',
          value: 1.00
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("You can not create an item at less than the value of its product."))
            raise
          end
      end

      it 'successfully creates an item' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['CreateItem'].resolve(nil, {
          token: user.authentication_token,
          storeId: 1,
          productId: 1,
          name: 'name',
          value: 41.00
          }, nil)
          item = Item.order("id").last

          if (item.id != mutation_result.id)
            raise
          end
      end

    end

    context 'testing update item' do

      it 'fails if the item does not exist' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['UpdateItem'].resolve(nil, {
          token: user.authentication_token,
          id: 10000,
          productId: 1,
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("You are attempting to update an item that does not exist."))
            raise
          end
      end

      it 'fails if the auth token is invalid' do
        mutation_result = subject.fields['UpdateItem'].resolve(nil, {
          token: 'badtoken',
          id: 1,
          productId: 1,
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("You do not have permission to update items."))
            raise
          end
      end

      it 'successfully updates an item' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['UpdateItem'].resolve(nil, {
          token: user.authentication_token,
          id: 1,
          productId: 1,
          }, nil)
          if (mutation_result.id != 1)
            raise
          end
      end
    end

    context 'testing delete item' do

      it 'fails if the item id is invalid' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['DeleteItem'].resolve(nil, {
          token: user.authentication_token,
          id: 10000,
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("The item you are attempting to delete does not exist."))
            raise
          end
      end

      it 'fails if the auth token is invalid' do
        mutation_result = subject.fields['DeleteItem'].resolve(nil, {
          token: 'user.authentication_token',
          id: 1,
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("You do not have permission to delete items."))
            raise
          end
      end

      it 'successfully deletes an item' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['DeleteItem'].resolve(nil, {
          token: user.authentication_token,
          id: 1,
          }, nil)

          if (mutation_result.id != 1)
            raise
          end
      end
    end

    context 'testing create user' do

      it 'fails if the email is already in use' do
        #expect {item.save()}.to raise_error(I18n::InvalidLocaleData)
        expect{subject.fields['CreateUser'].resolve(nil, {
          firstName: 'first',
          lastName: 'last',
          email: 'Peter@example.com',
          password: 'password'
          }, nil)}.to raise_error(I18n::InvalidLocaleData)
      end

      it 'successfully creates a user' do
        mutation_result = subject.fields['CreateUser'].resolve(nil, {
          firstName: 'first',
          lastName: 'last',
          email: 'example@example.com',
          password: 'password'
          }, nil)
        if (mutation_result.id != 2)
          raise
        end
      end

    end

    context 'testing sign in user' do

      it 'fails if the user email is invalid' do
        mutation_result = subject.fields['SignInUser'].resolve(nil, {
          email: 'example@example.com',
          password: 'password'
          }, nil)
        if (mutation_result != GraphQL::ExecutionError.new('No such user exists in the DB'))
          raise
        end
      end

      it 'fails if the password is incorrect' do
        mutation_result = subject.fields['SignInUser'].resolve(nil, {
          email: 'Peter@example.com',
          password: 'not_password'
          }, nil)
        if (mutation_result != GraphQL::ExecutionError.new('Incorrect Email/Password'))
          raise
        end
      end

      it 'succesfully signs in the user' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['SignInUser'].resolve(nil, {
          email: 'Peter@example.com',
          password: 'password'
          }, nil)
          puts mutation_result.authenticationToken
          puts user.authentication_token
        if (mutation_result != user.authentication_token)
        end
      end
    end

    context 'testing update user' do
      before(:each) do
        User.new(
          first_name: 'Example',
          last_name: 'Customer',
          email: 'Customer@example.com',
          password: 'password',
          owner: false
        ).save()
      end

      it 'errors if the auth token does not belong to a user' do
        mutation_result = subject.fields['UpdateUser'].resolve(nil, {
          id: 1,
          token: 'badtoken'
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("The token is invalid. You must be logged in to update a user"))
            raise
          end
      end

      it 'errors if a customer tries to update an owner' do
        user = User.find_by(id: 2)
        mutation_result = subject.fields['UpdateUser'].resolve(nil, {
          id: 1,
          token: user.authentication_token
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("You do not have the rights to update that user."))
            raise
          end
      end

      it 'successfully updates a user' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['UpdateUser'].resolve(nil, {
          id: 2,
          token: user.authentication_token
          }, nil)

          if (mutation_result.id != 2)
            raise
          end
      end
    end

    context 'testing delete user' do
      it 'fails if the auth token is invalid' do
        mutation_result = subject.fields['DeleteUser'].resolve(nil, {
          token: 'badToken',
          id: 1,
          password: 'password'
          }, nil)
        if (mutation_result != GraphQL::ExecutionError.new("The token or password passed in is invalid. You must be signed-in to delete a user"))
          raise
        end
      end

      it 'fails if the user does not exist' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['DeleteUser'].resolve(nil, {
          token: user.authentication_token,
          id: 2,
          password: 'password'
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("The user you want to delete does not exist."))
            raise
          end
      end

      it 'successfully deletes a user' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['DeleteUser'].resolve(nil, {
          token: user.authentication_token,
          id: 1,
          password: 'password'
          }, nil)
        if (mutation_result.id != 1)
          raise
        end
      end
    end

    context 'create order' do

      it 'fails if there are no items' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['CreateOrder'].resolve(nil, {
          token: user.authentication_token,
          userId: 1,
          storeId: 1,
          items: []
          }, nil)
        if (mutation_result != GraphQL::ExecutionError.new("You are attempting to process an empty order or an order for a store that does not exist."))
          raise
        end
      end

      it 'fails if the store id is invalid' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['CreateOrder'].resolve(nil, {
          token: user.authentication_token,
          userId: 1,
          storeId: 2,
          items: [1]
          }, nil)
        if (mutation_result != GraphQL::ExecutionError.new("You are attempting to process an empty order or an order for a store that does not exist."))
          raise
        end
      end

      it 'fails if the token is invalid' do
        mutation_result = subject.fields['CreateOrder'].resolve(nil, {
          token: 'user.authentication_token',
          userId: 1,
          storeId: 1,
          items: [1]
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("You must be logged in, or have the necessary rights to process an order for that user, please check your request and try again"))
            raise
          end
      end

      it 'successfully creates an order' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['CreateOrder'].resolve(nil, {
          token: user.authentication_token,
          userId: 1,
          storeId: 1,
          items: [1]
          }, nil)
        if mutation_result.id != 2
          raise
        end
      end



    end

    context 'delete order' do
      it 'fails if the authentication token is invalid' do
        mutation_result = subject.fields['DeleteOrder'].resolve(nil, {
          token: 'user.authentication_token',
          id: 1,
          }, nil)
        if (mutation_result != GraphQL::ExecutionError.new("You do not have permission to delete orders."))
          raise
        end
      end

      it 'fails if the order id is invalid' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['DeleteOrder'].resolve(nil, {
          token: user.authentication_token,
          id: 100,
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("The order you are attempting to delete does not exist."))
            raise
          end

      end

      it 'successfully deletes an order' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['DeleteOrder'].resolve(nil, {
          token: user.authentication_token,
          id: 1,
          }, nil)
        if (mutation_result.id != 1)
          raise
        end
      end

    end

    context 'update store' do
      it 'fails if the auth token is invalid' do
        mutation_result = subject.fields['UpdateStore'].resolve(nil, {
          token: 'user.authentication_token',
          id: 1,
          }, nil)
        if (mutation_result != GraphQL::ExecutionError.new("Improper query. Please ensure the user/store is valid, and that you are the owner of the store"))
          raise
        end
      end

      it 'fails if the store id is invalid' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['UpdateStore'].resolve(nil, {
          token: user.authentication_token,
          id: 2,
          }, nil)
        if (mutation_result != GraphQL::ExecutionError.new("Improper query. Please ensure the user/store is valid, and that you are the owner of the store"))
          raise
        end
      end

      it 'successfully updates the store' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['UpdateStore'].resolve(nil, {
          token: user.authentication_token,
          id: 1,
          }, nil)
        if (mutation_result.id != 1)
          raise
        end
      end

    end

    context 'delete store' do
      it 'fails if the auth token is invalid' do
        mutation_result = subject.fields['DeleteStore'].resolve(nil, {
          token: 'user.authentication_token',
          id: 1,
          }, nil)
          if (mutation_result != GraphQL::ExecutionError.new("You do not have permission to delete this store."))
            raise
          end
      end

      it 'fails if the store id is invalid' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['DeleteStore'].resolve(nil, {
          token: user.authentication_token,
          id: 12,
          }, nil)
        if (mutation_result != GraphQL::ExecutionError.new("The store you are attempting to delete does not exist."))
          raise
        end
      end

      it 'succesfully deletes a store' do
        user = User.find_by(id: 1)
        mutation_result = subject.fields['DeleteStore'].resolve(nil, {
          token: user.authentication_token,
          id: 1,
          }, nil)
        if (mutation_result.id != 1)
          raise
        end
      end

    end
end
