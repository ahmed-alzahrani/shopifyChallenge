class Resolvers::CreateProduct < GraphQL::Function
  #arguments passed as #args
  argument :name, !types.String
  argument :value, !types.Float
  argument :tags, !types.String

  type Types::ProductType

  def call(_obj, args, _ctx)
    Product.create!(
      name: args[:name],
      value: args[:value],
      tags: args[:tags],
    )
  end
end
