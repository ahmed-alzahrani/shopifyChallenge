Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createProduct, function: Resolvers::CreateProduct.new
  field :deleteProduct, function: Resolvers::DeleteProduct.new
end
