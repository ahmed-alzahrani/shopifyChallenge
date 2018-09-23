Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  description "A user represents anyone, either customer or owner, that may interact with this API.

  id: The unique id of the user in the SQLite database. \n
  first_name: The user\'s first name \n
  last_name: The user\'s last name \n
  email: The user\'s unique e-mail address \n
  owner: A boolean representing the user\'s role, false for customer, true for owner. \n
  order_count: Represents the number of orders made by the user to date. \n
  total_spent: Represents the total dollar amount spent by the user to date. \n
  "

  # a user type has the following fields
  field :id, !types.ID
  field :last_name, !types.String
  field :first_name, !types.String
  field :email, !types.String
  field :owner, !types.Boolean
  field :order_count, !types.Int
  field :total_spent, !types.Float
end
