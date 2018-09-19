class Resolvers::CreateUser < GraphQL::Function
  #arguments passed
  argument :lastName, !types.String
  argument :firstName, !types.String
  argument :email, !types.String
  argument :password, !types.String
  argument :owner, types.Boolean, default_value: false
  argument :token, types.String, default_value: ""

  type Types::UserType

  def call(_obj, args, _ctx)
    flag = false
    user = User.find_for_database_authentication(authentication_token: args[:token])
    if user
      if (user.owner && args[:owner])
        flag = true
      end
    end
    begin
      user = User.find_by(email: args[:email])
      if user
        # the user exists by email, throw an error
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
