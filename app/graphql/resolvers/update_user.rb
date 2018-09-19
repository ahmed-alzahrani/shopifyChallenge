class Resolvers::UpdateUser < GraphQL::Function
  #arguments passed
  argument :id, !types.ID
  argument :token, !types.String

  argument :firstName, !types.String
  argument :lastName, !types.String
  argument :email, !types.String
  argument :owner, types.Boolean, default_value: false

  type Types::UserType

  def call(_obj, args, _ctx)
    flag = false
    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = User.find_by(id: args[:id])
    # check to see if we're trying to make the new user an owner
    if req
      if (req.owner && args[:owner])
        flag = true
      end
      if target
        if (req.id == target.id || (req.owner && !target.owner))
          #the update can occur
          target.update!(
            first_name: args[:firstName],
            last_name: args[:lastName],
            email: args[:email],
            owner: flag
          )
          target
        else
          GraphQL::ExecutionError.new("You do not have the rights to update that user.")
        end
      else
        GraphQL::ExecutionError.new("The user you want to update does not exist.")
      end
    else
      GraphQL::ExecutionError.new("The token is invalid. You must be logged in to update a user.1")
    end
  end
end
