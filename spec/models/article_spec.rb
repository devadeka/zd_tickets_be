require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should validate_presence_of(:external_id) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  context 'upsert_by_external_id' do
    let!(:articles) { create_list(:article, 27) }
    let(:first_article) { articles.first }
    let(:params) { {
      "title" => Faker::Lorem.sentence,
      "body" => Faker::Lorem.paragraph
    } }

    it 'updates existing article if external_id is present' do 
      updated_article =
        Article.upsert_by_external_id(first_article.external_id, params)

      expect(Article.count).to eq(27)
      expect(updated_article.external_id).to eq(first_article.external_id)
      expect(updated_article.title).to eq(params['title'])
      expect(updated_article.body).to eq(params['body'])
    end

    it 'creates new article if external_id is not present' do
      updated_article =
        Article.upsert_by_external_id(first_article.external_id+1, params)

      expect(Article.count).to eq(28)
      expect(updated_article.external_id).to eq(first_article.external_id+1)
      expect(updated_article.title).to eq(params['title'])
      expect(updated_article.body).to eq(params['body'])
    end
  end
end
