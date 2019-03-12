require 'rails_helper'

RSpec.describe 'Articles API', type: :request do 
  let!(:articles) { create_list(:article, 10) }

  describe 'GET /articles' do
    before { get '/articles' }

    it 'returns articles' do
      @json = JSON.parse(response.body)
      expect(@json).not_to be_empty
      expect(@json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end