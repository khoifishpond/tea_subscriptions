require 'rails_helper'

describe 'Teas API' do
  it 'sends a list of teas' do
    create_list(:tea, 3)

    get '/api/v1/teas'

    expect(response).to be_successful

    teas = JSON.parse(response.body, symbolize_names: true)

    expect(teas).to be_a(Hash)
    expect(teas[:data]).to be_an(Array)
    teas[:data].each do |tea|
      expect(tea[:id]).to be_a(String)
      expect(tea[:type]).to be_a(String)
      expect(tea[:attributes]).to be_a(Hash)
      expect(tea[:attributes][:name]).to be_a(String)
      expect(tea[:attributes][:description]).to be_a(String)
      expect(tea[:attributes][:temperature]).to be_an(Integer)
      expect(tea[:attributes][:brew_time]).to be_an(Integer)
    end
  end

  it 'shows one tea' do
    create_list(:tea, 3)

    get '/api/v1/tea', params: {
      tea_id: Tea.first.id
    }

    expect(response).to be_successful

    tea = JSON.parse(response.body, symbolize_names: true)

    expect(tea).to be_a(Hash)
    expect(tea).to have_key(:data)
    expect(tea[:data]).to have_key(:id)
    expect(tea[:data][:id]).to be_a(String)
    expect(tea[:data]).to have_key(:type)
    expect(tea[:data][:type]).to eq('tea')
    expect(tea[:data]).to have_key(:attributes)
    expect(tea[:data][:attributes]).to have_key(:name)
    expect(tea[:data][:attributes][:name]).to be_a(String)
    expect(tea[:data][:attributes]).to have_key(:description)
    expect(tea[:data][:attributes][:description]).to be_a(String)
    expect(tea[:data][:attributes]).to have_key(:temperature)
    expect(tea[:data][:attributes][:temperature]).to be_an(Integer)
    expect(tea[:data][:attributes]).to have_key(:brew_time)
    expect(tea[:data][:attributes][:brew_time]).to be_an(Integer)
  end

  describe 'Error Handling' do
    it 'sends an error if no ID is provided' do
      get '/api/v1/tea'

      expect(response).to be_successful

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_an(Array)
      expect(error[:errors].first).to be_a(Hash)
      expect(error[:errors].first).to have_key(:status)
      expect(error[:errors].first[:status]).to eq('Bad Request')
      expect(error[:errors].first).to have_key(:message)
      expect(error[:errors].first[:message]).to eq('Tea ID required')
      expect(error[:errors].first).to have_key(:code)
      expect(error[:errors].first[:code]).to eq(400)
    end
  end
end