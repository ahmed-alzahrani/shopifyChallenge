Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  #product mutations, these also trigger relevant item operations
  field :createProduct, function: Resolvers::CreateProduct.new
  field :updateProduct, function: Resolvers::UpdateProduct.new
  field :deleteProduct, function: Resolvers::DeleteProduct.new

  #user mutations
  field :createUser, function: Resolvers::CreateUser.new
  field :SignInUser, function: Resolvers::SignInUser.new
end
