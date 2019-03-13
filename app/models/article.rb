class Article < ApplicationRecord
  validates_presence_of :external_id, :title, :body

  def self.upsert_by_external_id(external_id, params)
    upserted_article = Article.find_or_initialize_by(external_id: external_id)
    upserted_article.title = params['title']
    upserted_article.body = params['body']
    upserted_article.save
    upserted_article
  end
end
