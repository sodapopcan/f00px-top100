require 'rails_helper'

class FakeResponse
  attr_reader :body

  def initialize(body)
    @body = body
  end
end

describe ApiClient do
  let(:base_path) { 'https://api.500px.com/v1/photos' }
  let(:client) { ApiClient.new(base_path) }
  let(:photo_json) {
    '{"photo":{"name":"Crazy Lobster","user_id":68,"user":{"id":68,"name":"Philip J. Fry"}}}'
  }
  let(:photo_data) {
    {
      photo: {
        name: 'Crazy Lobster',
        user_id: 68,
        user: {
          id: 68,
          name: 'Philip J. Fry'
        }
      }
    }
  }

  it "should return a hash from a parsed JSON response" do
    allow(client.http).to receive(:request).and_return(FakeResponse.new(photo_json))
    response = client.get
    expect(response).to eq(photo_data)
  end

  it "can take default query params" do
    key = '123456'
    c = ApiClient.new(base_path, default_query_params: { consumer_key: key })
    expect(c.send(:q, feature: 'popular')).to eq(feature: 'popular', consumer_key: key)
  end
end
