class Resolvers::UpdateProduct < GraphQL::Function
  argument :name, !types.String
  argument :value, !types.Float
  argument :tags, !types.String
  argument :id, !types.ID

  type Types::ProductType


  def call(_obj, args, _ctx)
    puts "ok about to ask if user is signed in"
    Devise::user_signed_in?
    puts "lets see what current user does"
    current_user
    if _ctx[:current_user].blank?
      GraphQL::ExecutionError.new('User is not signed in')
    else
      product = Product.find_by(id: args[:id])
      product.update!(
        name: args[:name],
        value: args[:value],
        tags: args[:tags]
      )
      product
    end
  end

end
