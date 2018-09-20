Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  #product mutations, these also trigger relevant item operations
  field :createProduct, function: Resolvers::CreateProduct.new
  field :updateProduct, function: Resolvers::UpdateProduct.new
  field :deleteProduct, function: Resolvers::DeleteProduct.new

  #user mutations
  field :createUser, function: Resolvers::CreateUser.new
  field :SignInUser, function: Resolvers::SignInUser.new
  field :UpdateUser, function: Resolvers::UpdateUser.new
  field :DeleteUser, function: Resolvers::DeleteUser.new


  #order mutations
  #field :createOrder, function: Resolvers::CreateOrder.new

  #store mutations
  #field :createStore, function: Resolvers::CreateStore.new
  field :updateStore, function: Resolvers::UpdateStore.new
  field :updateOwner, function: Resolvers::UpdateOwner.new
  #field :deleteStore, function: Resolvers::DeleteStore.new
end
