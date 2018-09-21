class Resolvers::UpdateUser < GraphQL::Function
  #arguments passed

  # required parameters
  argument :id, !types.ID
  argument :token, !types.String

  argument :first_name, types.String
  argument :last_name, types.String
  argument :email, types.String
  argument :owner, types.Boolean, default_value: false

  type Types::UserType

  def call(_obj, args, _ctx)
    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = User.find_by(id: args[:id])
    if req && target
      if (req.id == target.id || (req.owner && !target.owner))
        #the update can occur

        # build our update object based on which optional params were passed in
        obj = {}

        if req.owner && args[:owner]
          obj[:owner] = true
        else
          obj[:owner] = false
        end

        if args[:first_name]
          obj[:first_name] = args[:first_name]
        end

        if args[:last_name]
          obj[:last_name] = args[:last_name]
        end

        if args[:email]
          obj[:email] = args[:email]
        end

        #update
        target.update!(obj)
        target
      else
        GraphQL::ExecutionError.new("You do not have the rights to update that user.")
      end
    else
      GraphQL::ExecutionError.new("The token is invalid. You must be logged in to update a user.1")
    end
  end
end
