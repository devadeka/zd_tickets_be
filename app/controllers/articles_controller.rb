# Controller for /articles routes, index adds metrics to list of articles
class ArticlesController < ApplicationController
  def index
    page = (params[:page] || 1).to_i

    response = Rails.cache.fetch(['zd_faqs', page], expires_in: 1.hour) do
      begin
        @faqs = ZDHelpCenter::Client.request_faqs_by_page(page)
      rescue ZDHelpCenter::APIError => e
        render json: 'Data not found', status: :not_found and return
      end

      { page: page, page_count: page_count, articles: articles }
    end

    render json: response
  end

  private
  def page_count
    @faqs['page_count']
  end

  def articles
    @faqs['articles'].map do |article|
      article.slice('id', 'title', 'body')
    end
  end
end
