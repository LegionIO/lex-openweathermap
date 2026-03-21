# frozen_string_literal: true

RSpec.describe Legion::Extensions::Openweathermap::Runners::Weather do
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

  describe '#current_weather' do
    it 'returns weather data for a city' do
      stubs.get('/weather') do
        [200, { 'Content-Type' => 'application/json' },
         { 'name' => 'London', 'main' => { 'temp' => 15.2, 'humidity' => 72 } }]
      end
      result = client.current_weather(city: 'London')
      expect(result[:weather]['name']).to eq('London')
      expect(result[:weather]['main']['temp']).to eq(15.2)
    end

    it 'returns weather data for lat/lon coordinates' do
      stubs.get('/weather') do
        [200, { 'Content-Type' => 'application/json' },
         { 'name' => 'Minneapolis', 'main' => { 'temp' => -5.0 } }]
      end
      result = client.current_weather(lat: 44.98, lon: -93.27)
      expect(result[:weather]['name']).to eq('Minneapolis')
    end

    it 'returns weather key in result' do
      stubs.get('/weather') do
        [200, { 'Content-Type' => 'application/json' },
         { 'name' => 'Paris' }]
      end
      result = client.current_weather(city: 'Paris')
      expect(result).to have_key(:weather)
    end
  end

  describe '#current_weather_by_id' do
    it 'returns weather data for a city id' do
      stubs.get('/weather') do
        [200, { 'Content-Type' => 'application/json' },
         { 'id' => 2_643_743, 'name' => 'London', 'main' => { 'temp' => 14.0 } }]
      end
      result = client.current_weather_by_id(city_id: 2_643_743)
      expect(result[:weather]['id']).to eq(2_643_743)
      expect(result[:weather]['name']).to eq('London')
    end
  end
end
