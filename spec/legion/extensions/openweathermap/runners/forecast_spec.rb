# frozen_string_literal: true

RSpec.describe Legion::Extensions::Openweathermap::Runners::Forecast do
  let(:client) { Legion::Extensions::Openweathermap::Client.new(api_key: 'test-api-key') }

  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:test_connection) do
    Faraday.new(url: 'https://api.openweathermap.org/data/2.5') do |conn|
      conn.request :json
      conn.response :json, content_type: /\bjson$/
      conn.adapter :test, stubs
    end
  end

  before { allow(client).to receive(:connection).and_return(test_connection) }

  describe '#five_day_forecast' do
    it 'returns 5-day forecast for a city' do
      stubs.get('/forecast') do
        [200, { 'Content-Type' => 'application/json' },
         { 'city' => { 'name' => 'Berlin' }, 'list' => [{ 'dt' => 1_700_000_000, 'main' => { 'temp' => 10.0 } }] }]
      end
      result = client.five_day_forecast(city: 'Berlin')
      expect(result[:forecast]['city']['name']).to eq('Berlin')
      expect(result[:forecast]['list']).to be_an(Array)
    end

    it 'returns forecast key in result' do
      stubs.get('/forecast') do
        [200, { 'Content-Type' => 'application/json' },
         { 'city' => { 'name' => 'Tokyo' }, 'list' => [] }]
      end
      result = client.five_day_forecast(city: 'Tokyo')
      expect(result).to have_key(:forecast)
    end
  end

  describe '#hourly_forecast' do
    it 'returns hourly forecast with default cnt' do
      stubs.get('/forecast') do
        [200, { 'Content-Type' => 'application/json' },
         { 'city' => { 'name' => 'New York' }, 'list' => Array.new(8) { |i| { 'dt' => 1_700_000_000 + (i * 3600) } } }]
      end
      result = client.hourly_forecast(city: 'New York')
      expect(result[:forecast]['list'].length).to eq(8)
    end

    it 'returns hourly forecast with custom cnt' do
      stubs.get('/forecast') do
        [200, { 'Content-Type' => 'application/json' },
         { 'city' => { 'name' => 'Chicago' }, 'list' => Array.new(4) { |i| { 'dt' => 1_700_000_000 + (i * 3600) } } }]
      end
      result = client.hourly_forecast(city: 'Chicago', cnt: 4)
      expect(result[:forecast]['city']['name']).to eq('Chicago')
      expect(result[:forecast]['list'].length).to eq(4)
    end

    it 'returns forecast key in result' do
      stubs.get('/forecast') do
        [200, { 'Content-Type' => 'application/json' },
         { 'city' => { 'name' => 'Seattle' }, 'list' => [] }]
      end
      result = client.hourly_forecast(city: 'Seattle', cnt: 2)
      expect(result).to have_key(:forecast)
    end
  end
end
