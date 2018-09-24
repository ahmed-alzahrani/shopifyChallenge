RSpec.describe Types::ProductType do

  types = GraphQL::Define::TypeDefiner.instance

  it 'has an :id field of ID type' do
    expect(subject).to have_field(:id).that_returns(!types.ID)
  end

  it 'has an :store_id field of ID type' do
    expect(subject).to have_field(:store_id).that_returns(!types.ID)
  end

  it 'has an :name field of String type' do
    expect(subject).to have_field(:name).that_returns(!types.String)
  end

  it 'has an :value field of Float type' do
    expect(subject).to have_field(:value).that_returns(!types.Float)
  end

  it 'has an :tags field of String type' do
    expect(subject).to have_field(:tags).that_returns(!types.String)
  end

  it 'has an :items field of [Types::ItemType] type' do
    expect(subject).to have_field(:items).that_returns(!types[Types::ItemType])
  end
end
