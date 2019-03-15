require 'rails_helper'

RSpec.describe 'Articles API', type: :request do

  describe 'GET /articles' do
    context 'when no page specified' do
      before { get '/articles' }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the correct page' do
        @json = JSON.parse(response.body)
        expect(@json['page']).to eq(1)
      end
    end

    context 'when first page is specified' do
      let(:page_params) { {page: 1} }

      before { get '/articles', params: page_params }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the correct page' do
        @json = JSON.parse(response.body)
        expect(@json['page']).to eq(1)
      end
    end

    context 'when last page is specified' do
      let(:page_params) { {page: 3} }

      before { get '/articles', params: page_params }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the correct page' do
        @json = JSON.parse(response.body)
        expect(@json['page']).to eq(3)
      end
    end
  end
end