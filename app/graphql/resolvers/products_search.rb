require 'search_object/plugin/graphql'

class Resolvers::ProductsSearch
  # inlude the search object for graph QL
  include SearchObject.module(:graphql)

  # scope is the starting for our search
  scope { Product.all }

  #return type from the search
  type !types[Types::ProductType]

  #inline input type definition for the advance filter
  ProductFilter = GraphQL::InputObjectType.define do
    name 'ProductFilter'

    argument :OR, -> { types[ProductFilter] }
    argument :tags_contains, types.String
    argument :name_contains, types.String
  end

  # when 'filter' is passed 'apply_filter' would be called to narrow the scope
  option :filter, type: ProductFilter, with: :apply_filter

  #apply_filter will recursively loop through through OR branches
  def apply_filter(scope, value)
    #normalize filters from nested OR structure, to flat scope list
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    #add like SQL conditions
    scope = Product.all
    scope = scope.where('tags LIKE ?', "%#{value['tags_contains']}%") if value['tags_contains']
    scope = scope.where('name LIKE ?', "%#{value['name_contains']}%") if value['name_contains']

    branches << scope

    #continue to normalize down
    value['OR'].reduce(branches) { |s, v| normalize_filters(v, s) } if value['OR'].present?

    branches
  end
end
