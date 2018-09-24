RSpec.describe Types::OrderType do

  types = GraphQL::Define::TypeDefiner.instance

  it 'has an :id field of ID type' do
    expect(subject).to have_field(:id).that_returns(!types.ID)
  end

  it 'has an :subTotal field of Float type' do
    expect(subject).to have_field(:subTotal).that_returns(!types.Float)
  end

  it 'has an :adjusted field of Float type' do
    expect(subject).to have_field(:adjusted).that_returns(!types.Float)
  end

  it 'has an :savings field of Float type' do
    expect(subject).to have_field(:savings).that_returns(!types.Float)
  end

  it 'has an :tax field of Float type' do
    expect(subject).to have_field(:tax).that_returns(!types.Float)
  end

  it 'has an :total field of Float type' do
    expect(subject).to have_field(:total).that_returns(!types.Float)
  end

  it 'has an :value field of ID type' do
    expect(subject).to have_field(:store_id).that_returns(!types.ID)
  end

  it 'has an :user_id field of ID type' do
    expect(subject).to have_field(:user_id).that_returns(!types.ID)
  end

  it 'has an :items field of [Types::ItemType] type' do
    expect(subject).to have_field(:items).that_returns(!types[Types::ItemType])
  end
end
