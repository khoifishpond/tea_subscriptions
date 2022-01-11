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
end