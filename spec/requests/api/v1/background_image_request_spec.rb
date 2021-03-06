require 'rails_helper'

describe 'Background Image API', :vcr do
  it 'returns a JSON object with the image url' do
    photo = 'https://images.unsplash.com/photo-1546156929-a4c0ac411f47?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjY2NTE1fQ'

    get '/api/v1/backgrounds?location=denver,co'

    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result[:data][:id]).to be_a(String)
    expect(result[:data][:attributes][:url]).to be_a(String)
    expect(result[:data][:attributes][:url]).to eq(photo)
  end
end
