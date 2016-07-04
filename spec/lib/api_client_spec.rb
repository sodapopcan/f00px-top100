require 'rails_helper'

class FakeResponse
  attr_reader :body

  def initialize(body)
    @body = body
  end
end

describe ApiClient do
  let(:base_path) { 'https://500px.com/api/v1' }
  let(:client) { ApiClient.new(base_path) }
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

  before do
    json = '{"photo":{"name":"Crazy Lobster","user_id":68,"user":{"id":68,"name":"Philip J. Fry"}}}'
    path = [base_path, '/photos'].join('/')
    allow(Excon).to receive(:get).with(path, {}).and_return(FakeResponse.new(json))
  end

  it "should return a hash from a parsed JSON response" do
    response = client.get('/photos')
    expect(response).to eq(photo_data)
  end
end
