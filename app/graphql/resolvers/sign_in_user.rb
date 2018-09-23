class Resolvers::SignInUser < GraphQL::Function

  description" A mutation that signs in a user, and returns their auth_token if successful.

  ARGUMENTS: \n \n
  email (required): The e-mail address of the user attempting to sign in.\n
  password (required): The password of the user attempting to sign in. \n \n \n

  ERRORS IF: \n \n
  - Any required arguments are missing, or any argument is passed as an invalid type. \n
  - The email does not belong to an existing user. (No such user exists in the DB). \n
  - The password provided does not match the email provided. (Incorrect Email/Password). \n
  "

  # arguments passed in

  # required arguments
  argument :email, !types.String
  argument :password, !types.String

  # return type
  type Types::AuthType

  def call(_obj, args, _ctx)
    # retrieve the record of the user trying to sign in
    @user = User.find_for_database_authentication(email: args[:email])
    # verify that the user exists
    if @user
      # verify that the user's password is valid
      if @user.valid_password?(args[:password])

        # return the authentication token of the user if sign in is successful
        authentication_token = @user.authentication_token
        return OpenStruct.new(authentication_token: authentication_token)
      # else we error if one of the prior checks fail
      else
        GraphQL::ExecutionError.new('Incorrect Email/Password')
      end
    else
      GraphQL::ExecutionError.new('No such user exists in the DB')
    end
  end
end
