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
  params = {
    "title" => Faker::Lorem.sentence,
    "body" => Faker::Lorem.paragraph
  }
  upserted_article = Article.upsert_by_external_id(last_article.external_id, params)
  p Article.last
end