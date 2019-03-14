# Controller for /articles routes, index adds metrics to list of articles
class ArticlesController < ApplicationController
  def index
    page = (params[:page] || 1).to_i
    faqs = ZDHelpCenter::V2::Client.request_faqs_by_page(page)
    page_count = faqs['page_count']
    articles = faqs['articles'].map do |article|
      article.slice('id', 'title', 'body')
    end
    response = { page: page, page_count: page_count, articles: articles }
    render json: response
  end
end
