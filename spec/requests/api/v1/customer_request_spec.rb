require 'rails_helper'

describe 'Cutomers API' do
  it 'sends a list of customers' do
    create_list(:customer, 3)

    get api_v1_customers_path

    expect(response).to be_successful

    customers = JSON.parse(response.body, symbolize_names: true)

    expect(customers).to be_a(Hash)
    expect(customers[:data]).to be_an(Array)
    customers[:data].each do |customer|
      expect(customer[:id]).to be_a(String)
      expect(customer[:type]).to eq('customer')
      expect(customer[:attributes]).to be_a(Hash)
      expect(customer[:attributes][:first_name]).to be_a(String)
      expect(customer[:attributes][:last_name]).to be_a(String)
      expect(customer[:attributes][:email]).to be_a(String)
      expect(customer[:attributes][:address]).to be_a(String)
    end
  end

  it 'shows one customer' do
    customers = create_list(:customer, 3)

    get api_v1_customer_path(customers.first.id)

    expect(response).to be_successful

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(customer).to be_a(Hash)
    expect(customer).to have_key(:data)
    expect(customer[:data]).to have_key(:id)
    expect(customer[:data][:id]).to be_a(String)
    expect(customer[:data]).to have_key(:type)
    expect(customer[:data][:type]).to eq('customer')
    expect(customer[:data]).to have_key(:attributes)
    expect(customer[:data][:attributes]).to have_key(:first_name)
    expect(customer[:data][:attributes][:first_name]).to be_a(String)
    expect(customer[:data][:attributes]).to have_key(:last_name)
    expect(customer[:data][:attributes][:last_name]).to be_a(String)
    expect(customer[:data][:attributes]).to have_key(:email)
    expect(customer[:data][:attributes][:email]).to be_a(String)
    expect(customer[:data][:attributes]).to have_key(:address)
    expect(customer[:data][:attributes][:address]).to be_a(String)
  end

  describe 'Error Handling' do
    it 'sends an error if the ID does not exist' do
      get api_v1_customer_path(100)

      expect(response).to be_successful

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_an(Array)
      expect(error[:errors].first).to be_a(Hash)
      expect(error[:errors].first).to have_key(:status)
      expect(error[:errors].first[:status]).to eq('Bad Request')
      expect(error[:errors].first).to have_key(:message)
      expect(error[:errors].first[:message]).to eq('Customer ID does not exist')
      expect(error[:errors].first).to have_key(:code)
      expect(error[:errors].first[:code]).to eq(400)
    end
  end
end