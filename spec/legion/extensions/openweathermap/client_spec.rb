# frozen_string_literal: true

RSpec.describe Legion::Extensions::Openweathermap::Client do
  subject(:client) { described_class.new(api_key: 'test-api-key') }

  describe '#initialize' do
    it 'stores api_key in opts' do
      expect(client.opts[:api_key]).to eq('test-api-key')
    end

    it 'defaults units to metric' do
      expect(client.opts[:units]).to eq('metric')
    end

    it 'accepts custom units' do
      c = described_class.new(api_key: 'key', units: 'imperial')
      expect(c.opts[:units]).to eq('imperial')
    end
  end

  describe '#settings' do
    it 'returns a hash with options key' do
      expect(client.settings).to eq({ options: client.opts })
    end
  end

  describe '#connection' do
    it 'returns a Faraday connection' do
      expect(client.connection).to be_a(Faraday::Connection)
    end
  end
end
