class Resolvers::CreateProduct < GraphQL::Function
  #arguments passed as #args
  argument :name, !types.String
  argument :value, !types.Float
  argument :tags, !types.String

  type Types::ProductType

  def call(_obj, args, _ctx)
    #zero_year_name = (args[:name] + " (base)")

    #one_year_name = (args[:name] + " (+1 year service)")
    #one_year_value = (args[:value] + 10.0)

    #two_year_name = (args[:name] + " (+2 year service)")
    #two_year_value = (args[:value] + 20.0)

    #prod.items.create([
    #  {name: zero_year_name, value: args[:value]},
    #  {name: one_year_name, value: one_year_value},
    #  {name: two_year_name, value: two_year_value},
    #  ])

    #Product.create!(prod)
    Product.create!(
      name: args[:name],
      value: args[:value],
      tags: args[:tags],
    )
  end
end
