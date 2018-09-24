module Mutations
OtherDelete = GraphQL::ObjectType.define do
  name 'otherMutation'
  description 'other delete'

  field :delete_item, Types::ItemType do

    argument :id, !types.ID
    argument :token, !types.String

    resolve ->(_obj, args, _ctx) do
      # retrieve the records pertaining to the requesting user and the item to be deleted
      req = User.find_for_database_authentication(authentication_token: args[:token])
      item = Item.find_by(id: args[:id])
      # if the item exists
      #if Item.exists?(args[:id])
      if item
        puts "IT EXIIIIISTS"
        puts item.id
        # and the requesting user both exists and is an owner
        if req && req.owner
          # destory the item
          item.destroy
        # else we error if any of the prior checks failed
        else
          GraphQL::ExecutionError.new("You do not have permission to delete items.")
        end
      else
        GraphQL::ExecutionError.new("The item you are attempting to delete does not exist.")
      end
    end
    end
  end
end
