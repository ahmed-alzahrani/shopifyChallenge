class Resolvers::UpdateUser < GraphQL::Function

  description" A mutation that updates a user from the SQLite database. Users can update themselves, whilst owners can update themselves and any other non-owner user.
  If no optional arguments are specified, the user is unchanged and returned in it\'s current state. Owners can also update regular users so that they are now owners.

  ARGUMENTS: \n \n
  token (required): An authentication token passed in by the requesting user.\n
  id (required): The unique id of the user being updated.\n
  first_name (optional): The new first name of the updated store if being changed.\n
  last_name (optional): The new last name of the updated store if being changed.\n
  email (optional): The new email of the updated store if being changed.\n
  owner (optional): A flag that is passed true if we are upgrading a user to an owner.\n \n \n

  ERRORS IF: \n \n
  - The token and user id are not a match / an owner is trying to update another owner. (You do not have the rights to update that user.) \n
  - The authentication token passed in does not correspond to any user (You must be logged in to update a user.) \n
  "

  # arguments passed

  # required parameters
  argument :id, !types.ID
  argument :token, !types.String

  # optional arguments
  argument :first_name, types.String
  argument :last_name, types.String
  argument :email, types.String
  argument :owner, types.Boolean, default_value: false

  # return type
  type Types::UserType

  def call(_obj, args, _ctx)
    # retrieve the record for the requesting user and user to be updated
    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = User.find_by(id: args[:id])

    # verify the existence of both users
    if req && target
      # verify that the requsting user and target are the same, or that an owner is trying to update a regular user
      if (req.id == target.id || (req.owner && !target.owner))
        #the update can occur

        # instantiate our 'update hash' as empty
        obj = {}

        # loop through the optional args and add them to the update hash if they exist
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

        # update and return the user
        target.update!(obj)
        target
      # error if any of the prior checks failed
      else
        GraphQL::ExecutionError.new("You do not have the rights to update that user.")
      end
    else
      GraphQL::ExecutionError.new("The token is invalid. You must be logged in to update a user")
    end
  end
end
