class Resolvers::CreateUser < GraphQL::Function

  description " A mutation that creates a new user in the SQLite database. \n

  ARGUMENTS: \n \n
  token (optional): An authentication-token representing the user making the request. Only owners can create other owners. \n
  firstName (required): A string representing the new user\'s first name. \n
  lastName (required): A string representing the new user\'s last name \n
  email (required): A string representing the new user\'s email. \n
  password (required): A string representing the new user\'s password. \n
  owner (optional): A boolean flag that representing whether or not we want to create an owner (true), or regular customer (false). \n \n \n

  ERRORS IF: \n \n
  - Any required arguments are missing, or any argument is passed as an invalid type. \n
  - Any of the arguments passed in are invalid (Invalid attributes error) \n
  - The email passed in already belongs to an existing user. (a user already exists with that email). \n
  "

  #arguments passed into the function

  # required arguments
  argument :token, types.String, default_value: ""
  argument :firstName, !types.String
  argument :lastName, !types.String
  argument :email, !types.String
  argument :password, !types.String

  # optional args
  argument :owner, types.Boolean, default_value: false

  # return type
  type Types::UserType

  def call(_obj, args, _ctx)
    # flag represents whether or not the requesting user is trying to create an owner(true) or a regular user (false)
    flag = false
    # retrieve the user record that corresponds to the auth token passed in
    user = User.find_for_database_authentication(authentication_token: args[:token])
    # verify user's existence
    if user
      # flip the flag if the requesting user is an owner and the owner argument is true
      if (user.owner && args[:owner])
        flag = true
      end
    end
    begin
      # check if a user already exists with the specified e-mail address, error if a user already exists.
      user = User.find_by(email: args[:email])
      if user
        GraphQL::ExecutionError.new("a user already exists with that email")
      else
        # the user does NOT exist, we can create them
        User.create!(
          first_name: args[:firstName],
          last_name: args[:lastName],
          email: args[:email],
          password: args[:password],
          owner: flag
        )
      end
    rescue ActiveRecord::RecordInvalid => invalid
      GraphQL::ExecutionError.new("Invalid Attributes for #{invalid.record.class.name}: #{invalid.record.errors.full_messages.join(', ')}")
    end
  end

end
