RSpec.describe Types::UserType do

  types = GraphQL::Define::TypeDefiner.instance

  it 'has an :id field of ID type' do
    expect(subject).to have_field(:id).that_returns(!types.ID)
  end

  it 'has an :first_name field of String type' do
    expect(subject).to have_field(:first_name).that_returns(!types.String)
  end

  it 'has an :last_name field of String type' do
    expect(subject).to have_field(:last_name).that_returns(!types.String)
  end

  it 'has an :email field of String type' do
    expect(subject).to have_field(:email).that_returns(!types.String)
  end

  it 'has an :owner field of String type' do
    expect(subject).to have_field(:owner).that_returns(!types.Boolean)
  end

  it 'has an :order_count field of Int type' do
    expect(subject).to have_field(:order_count).that_returns(!types.Int)
  end

  it 'has an :total_spent field of Float type' do
    expect(subject).to have_field(:total_spent).that_returns(!types.Float)
  end
end
