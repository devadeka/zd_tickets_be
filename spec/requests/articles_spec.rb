require 'rails_helper'

RSpec.describe 'Articles API', type: :request do

  describe 'GET /articles' do
    context 'when no page specified' do
      before { get '/articles' }

      it 'returns articles' do
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the expected articles in page' do
      end

      it 'returns the correct page' do
        @json = JSON.parse(response.body)
        expect(@json['page']).to eq(1)
      end

      it 'returns the correct page_count' do
      end
    end

    context 'when first page is specified' do
      let(:page_params) { {page: 1} }

      before { get '/articles', params: page_params }

      it 'returns articles' do
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the expected articles in page' do
      end

      it 'returns the correct page' do
      end
    end

    context 'when last page is specified' do
      let(:page_params) { {page: 3} }

      before { get '/articles', params: page_params }

      it 'returns articles' do
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the expected articles in page' do
      end

      it 'returns the correct page' do
      end
    end
  end
end