require 'rails_helper'

RSpec.describe 'Subscriptions API' do
  it 'subscribes a customer to a tea subscription' do
    customer = create(:customer)
    tea = create(:tea)

    post '/api/v1/subscribe', params: {
      customer_id: customer.id,
      tea_id: tea.id,
      price: 4.99,
      frequency: 'monthly'
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
      frequency: 2,
      tea_id: tea.id,
      customer_id: customer.id
    )
    
    patch '/api/v1/unsubscribe', params: {
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
        frequency: 2,
        tea_id: tea.id,
        customer_id: customer.id
      )
    end
    customer.subscriptions[1].update(status: 0)

    get '/api/v1/subscriptions', params: {
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
end