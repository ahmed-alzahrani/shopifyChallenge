Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  description 'Here contain all of the mutations that can be made through this API.
  These include CRUD operations on products/items/users/orders as well as the ability to update
  the lone store in the SQLite db.'

  # PRODUCT MUTATIONS
  field :CreateProduct, function: Resolvers::CreateProduct.new
  field :UpdateProduct, function: Resolvers::UpdateProduct.new
  field :DeleteProduct, function: Resolvers::DeleteProduct.new

  # ITEM MUTATIONS
  field :CreateItem, function: Resolvers::CreateItem.new
  field :UpdateItem, function: Resolvers::UpdateItem.new
  field :DeleteItem, function: Resolvers::DeleteItem.new

  # USER MUTATIONS
  field :CreateUser, function: Resolvers::CreateUser.new
  field :SignInUser, function: Resolvers::SignInUser.new
  field :UpdateUser, function: Resolvers::UpdateUser.new
  field :DeleteUser, function: Resolvers::DeleteUser.new


  # ORDER MUTATIONS
  field :CreateOrder, function: Resolvers::CreateOrder.new
  field :DeleteOrder, function: Resolvers::DeleteOrder.new

  # STORE MUTATIONS
  field :UpdateStore, function: Resolvers::UpdateStore.new
  field :DeleteStore, function: Resolvers::DeleteStore.new
end
