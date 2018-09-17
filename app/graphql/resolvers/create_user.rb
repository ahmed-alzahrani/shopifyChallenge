class Resolvers::CreateUser < GraphQL::Function
  #arguments passed
  argument :lastName, !types.String
  argument :firstName, !types.String
  argument :email, !types.String
  argument :password, !types.String
  argument :owner, types.Boolean, default_value: false

  type Types::UserType

  def call(_obj, args, _ctx)
    begin
      User.create!(
        first_name: args[:firstName],
        last_name: args[:lastName],
        email: args[:email],
        password: args[:password],
        owner: args[:owner]
      )
    rescue ActiveRecord::RecordInvalid => invalid
      GraphQL::ExecutionError.new("Invalid Attributes for #{invalid.record.class.name}: #{invalid.record.errors.full_messages.join(', ')}")
    end
  end

end
