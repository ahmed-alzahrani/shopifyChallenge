Types::ResultType = GraphQL::ObjectType.define do
  name 'ResultType'

  field :result, !types.Boolean
end
