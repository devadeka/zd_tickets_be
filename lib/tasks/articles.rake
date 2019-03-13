require 'faker'

desc 'shows total number of articles'
task view_articles: :environment do
  p Article.count
end

desc 'shows first article'
task view_first_article: :environment do
  p Article.first
end

desc 'upserts last article'
task upsert_last_article: :environment do
  last_article = Article.last
  p last_article
  upserted_article = Article.find_or_initialize_by(external_id: last_article.external_id)
  upserted_article.title = Faker::Lorem.sentence
  upserted_article.body = Faker::Lorem.paragraph
  upserted_article.save
  p Article.last
end