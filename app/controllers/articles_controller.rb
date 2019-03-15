# Controller for /articles routes, index adds metrics to list of articles
class ArticlesController < ApplicationController
  def index
    page = (params[:page] || 1).to_i

    Rails.cache.fetch(['zd_faqs', page], expires_in: 3.minutes) do
      begin
        faqs = ZDHelpCenter::Client.request_faqs_by_page(page)
      rescue ZDHelpCenter::APIError => e
        render json: 'Data not found', status: :not_found and return
      end
    end

    page_count = faqs['page_count']
    articles = faqs['articles'].map do |article|
      article.slice('id', 'title', 'body')
    end

    response = { page: page, page_count: page_count, articles: articles }
    render json: response
  end
end
