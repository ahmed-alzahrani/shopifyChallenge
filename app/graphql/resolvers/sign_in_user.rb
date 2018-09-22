class Resolvers::SignInUser < GraphQL::Function

  description" A mutation that signs in a user, and returns their auth_token if successful.

  ARGUMENTS: \n \n
  email (required): The e-mail address of the user attempting to sign in.\n
  password (required): The password of the user attempting to sign in. \n \n \n

  ERRORS IF: \n \n
  - The email does not belong to an existing user. (No such user exists in the DB). \n
  - The password provided does not match the email provided. (Incorrect Email/Password). \n
  "


  argument :email, !types.String
  argument :password, !types.String

  type Types::AuthType

  def call(_obj, args, _ctx)
    @user = User.find_for_database_authentication(email: args[:email])
    if @user
      if @user.valid_password?(args[:password])
        authentication_token = @user.authentication_token
        return OpenStruct.new(authentication_token: authentication_token)
      else
        GraphQL::ExecutionError.new('Incorrect Email/Password')
      end
    else
      GraphQL::ExecutionError.new('No such user exists in the DB')
    end
  end
end
