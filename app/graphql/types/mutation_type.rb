Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  description 'Here contain all of the mutations that can be made through this API.
  These include CRUD operations on products/items/users/orders as well as the ability to update
  the lone store in the SQLite db.'

  # PRODUCT MUTATIONS
  field :createProduct, function: Resolvers::CreateProduct.new
  field :updateProduct, function: Resolvers::UpdateProduct.new
  field :deleteProduct, function: Resolvers::DeleteProduct.new

  # ITEM MUTATIONS
  field :createItem, function: Resolvers::CreateItem.new
  field :updateItem, function: Resolvers::UpdateItem.new
  field :deleteItem, function: Resolvers::DeleteItem.new

  # USER MUTATIONS
  field :createUser, function: Resolvers::CreateUser.new
  field :SignInUser, function: Resolvers::SignInUser.new
  field :UpdateUser, function: Resolvers::UpdateUser.new
  field :DeleteUser, function: Resolvers::DeleteUser.new


  # ORDER MUTATIONS
  field :createOrder, function: Resolvers::CreateOrder.new
  field :deleteOrder, function: Resolvers::DeleteOrder.new

  # STORE MUTATIONS
  field :updateStore, function: Resolvers::UpdateStore.new
  field :deleteStore, function: Resolvers::DeleteStore.new
end
