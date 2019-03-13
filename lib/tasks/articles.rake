desc 'testing rake tasks'
task view_articles: :environment do
  p Article.count
end

desc 'says hi'
task view_first_article: :environment do
  p Article.first
end