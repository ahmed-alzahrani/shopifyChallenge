require 'search_object/plugin/graphql'

class Resolvers::UsersSearch
  # inlude the search object for graph QL
  include SearchObject.module(:graphql)

  # scope is the starting for our search
  scope { User.all }

  #return type from the search
  type !types[Types::UserType]

  #inline input type definition for the advance filter
  UserFilter = GraphQL::InputObjectType.define do
    name 'UserFilter'

    argument :OR, -> { types[UserFilter] }
    argument :first_name_contains, types.String
    argument :last_name_contains, types.String
    argument :email_contains, types.String
    argument :owner_contains, types.Boolean
    argument :id_contains, types.Int
  end

  # when 'filter' is passed 'apply_filter' would be called to narrow the scope
  option :filter, type: UserFilter, with: :apply_filter

  #apply_filter will recursively loop through through OR branches
  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    #add like SQL conditions
    scope = User.all
    scope = scope.where('first_name LIKE ?', "%#{value['first_name_contains']}%") if value['first_name_contains']
    scope = scope.where('last_name LIKE ?', "%#{value['last_name_contains']}%") if value['last_name_contains']
    scope = scope.where('email LIKE ?', "%#{value['email_contains']}%") if value['email_contains']
    scope = scope.where('owner LIKE ?', "%#{value['owner_contains']}%") if value['owner_contains']
    scope = scope.where('id LIKE ?', "%#{value['id_contains']}%") if value['id_contains']

    branches << scope

    #continue to normalize down
    value['OR'].reduce(branches) { |s, v| normalize_filters(v, s) } if value['OR'].present?

    branches
  end
end
