Types::StoreType = GraphQL::ObjectType.define do
  name 'Store'

  description "A type that represents a single store in the SQLite database.

  id: The unique id of the store in the database. \n
  name: The business name of the store \n
  email: The user\'s last name \n
  phone: A string representing the store\'s phone number. \n
  url: A string representing the store\'s url. \n
  order_count: Represents the number of orders made by users to the store to date. \n
  total_sold: Represents the total dollar amount sold by the store to date. \n
  "

  #it has the following fields
  field :id, !types.ID
  field :name, !types.String
  field :email, !types.String
  field :phone, !types.String
  field :url, !types.String
  field :user_id, !types.ID
  field :order_count, !types.Int
  field :total_sold, !types.Float
end
