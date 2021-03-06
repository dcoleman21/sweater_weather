require 'rails_helper'

describe User, type: :model do
  it 'exists' do
    user = User.new(email: 'email', password: 'password123', password_confirmation: 'password123')

    expect(user).to be_a(User)
  end

  context 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:api_key) }
  end

  context 'Relationships' do
    it { should have_many(:favorite_cities) }
  end

  it 'has attributes' do
    email = 'email'
    password = 'password123'
    User.create!(email: email, password: password, password_confirmation: password, api_key: ApiKey.new.key)

    expect(User.last.email).to eq(email)
    expect(User.last.password_digest).to be_a(String)
  end
end
