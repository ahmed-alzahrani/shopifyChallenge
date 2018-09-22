class Resolvers::DeleteUser < GraphQL::Function

  description " A mutation that deletes a user from the the SQLite database. Regular users can delete themselves, and owners can delete themselves and other users. \n

  ARGUMENTS: \n \n
  token (required): An authentication-token representing the user making the request. Only owners can delete orders. \n
  id (required): The id of the user to be deleted. \n
  password (required): The password of the user initiating the deletion. \n \n \n

  ERRORS IF: \n \n
  - The authentication token or password passed in is invalid (The token or password passed in is invalid. You must be signed-in to delete a user). \n
  - The id passed in is invalid (The user you want to delete does not exist.)\n
  - The user id and token do not match, or they both belong to different owners (You do not have the rights to delete that user). \n
  "


  #arguments passed
  argument :token, !types.String
  argument :id, !types.ID
  argument :password, !types.String

  # return type
  type Types::UserType

  def call(_obj, args, _ctx)
    # first we try find both the requesting user, and the user they wish to delete
    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = User.find_by(id: args[:id])
    if req && req.valid_password?(args[:password])
      # the token passed in is good, the user making the delete reques exists
      if target
        # the user we WANT to delete exists
        if (req.id == target.id || (req.owner && !target.owner))
          # the deletion can occur
          target.destroy
        else
          GraphQL::ExecutionError.new("You do not have the rights to delete that user.")
        end
      else
        GraphQL::ExecutionError.new("The user you want to delete does not exist.")
      end
    else
      GraphQL::ExecutionError.new("The token or password passed in is invalid. You must be signed-in to delete a user")
    end
  end
end
