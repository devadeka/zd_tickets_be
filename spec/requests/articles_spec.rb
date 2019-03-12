require 'rails_helper'

RSpec.describe 'Articles API', type: :request do
  let!(:articles) { create_list(:article, 27) }
  let(:first_article_id) { articles.first['external_id'] }
  let(:last_article_id) { articles.last['external_id'] }

  describe 'GET /articles' do
    context 'when no page specified' do
      before { get '/articles' }

      it 'returns articles' do
        @json = JSON.parse(response.body)
        @articles = @json['articles']
        expect(@articles).not_to be_empty
        expect(@articles.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the expected articles in page' do
        @json = JSON.parse(response.body)
        @articles = @json['articles']
        expect(@articles.first['external_id']).to eq(first_article_id)
      end

      it 'returns the correct page' do
        @json = JSON.parse(response.body)
        expect(@json['page']).to eq(1)
      end

      it 'returns the correct page_count' do
        @json = JSON.parse(response.body)
        expect(@json['page_count']).to eq(3)
      end
    end

    context 'when first page is specified' do
      let(:page_params) { {page: 1} }

      before { get '/articles', params: page_params }

      it 'returns articles' do
        @json = JSON.parse(response.body)
        @articles = @json['articles']
        expect(@articles).not_to be_empty
        expect(@articles.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the expected articles in page' do
        @json = JSON.parse(response.body)
        @articles = @json['articles']
        expect(@articles.first['external_id']).to eq(first_article_id)
      end

      it 'returns the correct page' do
        @json = JSON.parse(response.body)
        expect(@json['page']).to eq(1)
      end
    end

    context 'when last page is specified' do
      let(:page_params) { {page: 3} }

      before { get '/articles', params: page_params }

      it 'returns articles' do
        @json = JSON.parse(response.body)
        @articles = @json['articles']
        expect(@articles).not_to be_empty
        expect(@articles.size).to eq(7)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the expected articles in page' do
        @json = JSON.parse(response.body)
        @articles = @json['articles']
        expect(@articles.last['external_id']).to eq(last_article_id)
      end

      it 'returns the correct page' do
        @json = JSON.parse(response.body)
        expect(@json['page']).to eq(3)
      end
    end
  end
end