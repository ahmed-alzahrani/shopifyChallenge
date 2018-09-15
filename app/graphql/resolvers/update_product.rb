class Resolvers::UpdateProduct < GraphQL::Function
  argument :name, !types.String
  argument :value, !types.Float
  argument :tags, !types.String
  argument :id, !types.ID

  type Types::ProductType

  def call(_obj, args, _ctx)
    product = Product.find_by(id: args[:id])
    product.update!(
      name: args[:name],
      value: args[:value],
      tags: args[:tags]
    )
    product
  end

end
