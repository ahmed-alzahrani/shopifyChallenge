RSpec.describe Types::StoreType do

  types = GraphQL::Define::TypeDefiner.instance

  it 'has an :id field of ID type' do
    expect(subject).to have_field(:id).that_returns(!types.ID)
  end

  it 'has an :name field of String type' do
    expect(subject).to have_field(:name).that_returns(!types.String)
  end

  it 'has an :email field of String type' do
    expect(subject).to have_field(:email).that_returns(!types.String)
  end

  it 'has an :phone field of String type' do
    expect(subject).to have_field(:phone).that_returns(!types.String)
  end

  it 'has an :url field of String type' do
    expect(subject).to have_field(:url).that_returns(!types.String)
  end

  it 'has an :user_id field of ID type' do
    expect(subject).to have_field(:user_id).that_returns(!types.ID)
  end

  it 'has an :order_count field of ID type' do
    expect(subject).to have_field(:order_count).that_returns(!types.Int)
  end

  it 'has an :total_sold field of Float type' do
    expect(subject).to have_field(:total_sold).that_returns(!types.Float)
  end
end
