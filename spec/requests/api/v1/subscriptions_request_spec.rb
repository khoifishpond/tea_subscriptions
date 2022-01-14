require 'rails_helper'

RSpec.describe 'Subscriptions API' do
  it 'subscribes a customer to a tea subscription' do
    customer = create(:customer)
    tea = create(:tea)

    post "/api/v1/customers/#{customer.id}/subscriptions/#{tea.id}", params: {
      customer_id: customer.id,
      tea_id: tea.id,
      price: 4.99,
      frequency: 'bi-weekly'
    }

    expect(response).to be_successful

    subscription = JSON.parse(response.body, symbolize_names: true)

    expect(subscription).to be_a(Hash)
    expect(subscription).to have_key(:data)
    expect(subscription[:data]).to be_a(Hash)
    expect(subscription[:data]).to have_key(:id)
    expect(subscription[:data][:id]).to be_a(String)
    expect(subscription[:data]).to have_key(:type)
    expect(subscription[:data][:type]).to eq('subscription')
    expect(subscription[:data]).to have_key(:attributes)
    expect(subscription[:data][:attributes]).to have_key(:title)
    expect(subscription[:data][:attributes][:title]).to be_a(String)
    expect(subscription[:data][:attributes]).to have_key(:price)
    expect(subscription[:data][:attributes][:price]).to be_a(Float)
    expect(subscription[:data][:attributes]).to have_key(:status)
    expect(subscription[:data][:attributes][:status]).to eq('active').or eq('cancelled')
    expect(subscription[:data][:attributes]).to have_key(:frequency)
    expect(subscription[:data][:attributes][:frequency]).to be_a(String)
    expect(subscription[:data][:attributes]).to have_key(:tea_id)
    expect(subscription[:data][:attributes][:tea_id]).to be_an(Integer)
    expect(subscription[:data][:attributes]).to have_key(:customer_id)
    expect(subscription[:data][:attributes][:customer_id]).to be_an(Integer)
  end

  it 'unsubscribes a customer from a subscription' do
    customer = create(:customer)
    tea = create(:tea)
    subscription = Subscription.create(
      title: tea.name,
      price: 4.99,
      frequency: 'bi-weekly',
      tea_id: tea.id,
      customer_id: customer.id
    )
    
    patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}", params: {
      subscription_id: subscription.id
    }
    updated_sub = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(updated_sub[:data][:attributes][:status]).to eq('cancelled')
  end
  
  it 'can list all subscriptions by a customer' do
    customer = create(:customer)
    teas = create_list(:tea, 3)
    teas.each do |tea|
      Subscription.create(
        title: tea.name,
        price: 4.99,
        frequency: 'bi-weekly',
        tea_id: tea.id,
        customer_id: customer.id
      )
    end
    customer.subscriptions[1].update(status: 0)

    get "/api/v1/customers/#{customer.id}/subscriptions", params: {
      customer_id: customer.id
    }

    expect(response).to be_successful
    
    subscriptions = JSON.parse(response.body, symbolize_names: true)
    
    expect(subscriptions).to be_a(Hash)
    expect(subscriptions).to have_key(:data)
    expect(subscriptions[:data]).to be_an(Array)
    expect(subscriptions[:data].size).to eq(3)
    subscriptions[:data].each do |subscription|
      expect(subscription).to be_a(Hash)
      expect(subscription).to have_key(:id)
      expect(subscription[:id]).to be_a(String)
      expect(subscription).to have_key(:type)
      expect(subscription[:type]).to eq('subscription')
      expect(subscription).to have_key(:attributes)
      expect(subscription[:attributes]).to be_a(Hash)
      expect(subscription[:attributes]).to have_key(:title)
      expect(subscription[:attributes][:title]).to be_a(String)
      expect(subscription[:attributes]).to have_key(:price)
      expect(subscription[:attributes][:price]).to be_a(Float)
      expect(subscription[:attributes]).to have_key(:status)
      expect(subscription[:attributes][:status]).to eq('active').or eq('cancelled')
      expect(subscription[:attributes]).to have_key(:frequency)
      expect(subscription[:attributes][:frequency]).to be_a(String)
      expect(subscription[:attributes]).to have_key(:tea_id)
      expect(subscription[:attributes][:tea_id]).to be_an(Integer)
      expect(subscription[:attributes]).to have_key(:customer_id)
      expect(subscription[:attributes][:customer_id]).to be_an(Integer)
    end
  end

  it 'shows a subscription' do
    customer = create(:customer)
    tea = create(:tea)
    subscription = Subscription.create(
      title: tea.name,
      price: 4.99,
      frequency: 'bi-weekly',
      tea_id: tea.id,
      customer_id: customer.id
    )

    get "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}", params: {
      subscription_id: subscription.id
    }

    expect(response).to be_successful

    subscription = JSON.parse(response.body, symbolize_names: true)

    expect(subscription).to be_a(Hash)
  end

  describe 'Error Handling' do
    it 'sends an error if a subscription is already cancelled' do
      customer = create(:customer)
      tea = create(:tea)
      subscription = Subscription.create(
        title: tea.name,
        price: 4.99,
        frequency: 'bi-weekly',
        tea_id: tea.id,
        customer_id: customer.id
      )
      customer.subscriptions.update(status: 0)
      
      patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}", params: {
        subscription_id: subscription.id
      }

      expect(response).to be_successful

      error = JSON.parse(response.body, symbolize_names: true)
      
      expect(error).to be_a(Hash)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_an(Array)
      expect(error[:errors].first).to be_a(Hash)
      expect(error[:errors].first).to have_key(:status)
      expect(error[:errors].first[:status]).to eq('Bad Request')
      expect(error[:errors].first).to have_key(:message)
      expect(error[:errors].first[:message]).to eq('Subscription already cancelled')
      expect(error[:errors].first).to have_key(:code)
      expect(error[:errors].first[:code]).to eq(400)
    end

    it 'sends an error if no ID is provided to show a subscription' do
      customer = create(:customer)
      tea = create(:tea)
      subscription = Subscription.create(
        title: tea.name,
        price: 4.99,
        frequency: 'bi-weekly',
        tea_id: tea.id,
        customer_id: customer.id
      )
      get "/api/v1/customers/#{customer.id}/subscriptions/99999", params: {
        subscription_id: 99999
      }
  
      expect(response).to be_successful
  
      error = JSON.parse(response.body, symbolize_names: true)
      expect(error).to be_a(Hash)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_an(Array)
      expect(error[:errors].first).to be_a(Hash)
      expect(error[:errors].first).to have_key(:status)
      expect(error[:errors].first[:status]).to eq('Bad Request')
      expect(error[:errors].first).to have_key(:message)
      expect(error[:errors].first[:message]).to eq('Customer or Subscription does not exist')
      expect(error[:errors].first).to have_key(:code)
      expect(error[:errors].first[:code]).to eq(400)
    end

    it 'sends an error if no ID is provided to unsubscribe' do
      customer = create(:customer)
      subscription = Subscription.create(
        title: 'Tea Name',
        price: 4.99,
        frequency: 'bi-weekly',
        tea_id: 2,
        customer_id: customer.id
      )
      patch "/api/v1/customers/#{customer.id}/subscriptions/2"
  
      expect(response).to be_successful
  
      error = JSON.parse(response.body, symbolize_names: true)
  
      expect(error).to be_a(Hash)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_an(Array)
      expect(error[:errors].first).to be_a(Hash)
      expect(error[:errors].first).to have_key(:status)
      expect(error[:errors].first[:status]).to eq('Bad Request')
      expect(error[:errors].first).to have_key(:message)
      expect(error[:errors].first[:message]).to eq('Subscription does not exist')
      expect(error[:errors].first).to have_key(:code)
      expect(error[:errors].first[:code]).to eq(400)
    end

    it 'sends an error if no ID is provided to subscribe' do
      customer = create(:customer)
      # tea = create(:tea)
      post "/api/v1/customers/#{customer.id}/subscriptions/2"
  
      expect(response).to be_successful
  
      error = JSON.parse(response.body, symbolize_names: true)
  
      expect(error).to be_a(Hash)
      expect(error).to have_key(:errors)
      expect(error[:errors]).to be_an(Array)
      expect(error[:errors].first).to be_a(Hash)
      expect(error[:errors].first).to have_key(:status)
      expect(error[:errors].first[:status]).to eq('Bad Request')
      expect(error[:errors].first).to have_key(:message)
      expect(error[:errors].first[:message]).to eq('Customer or Tea ID does not exist')
      expect(error[:errors].first).to have_key(:code)
      expect(error[:errors].first[:code]).to eq(400)
    end
  end
end