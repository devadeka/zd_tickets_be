class ArticlesController < ApplicationController
  PER_PAGE = 10
  API_URL = "https://support.zendesk.com/api/v2/help_center/en-us/articles"
  def index
    page = (params[:page] || 1).to_i
    Rails.cache.fetch(['zd_faqs', page], expires_in: 3.minutes) do
      zd_resp = HTTParty.get("#{API_URL}?page=#{page}")
      body = JSON.parse(zd_resp.body)
      page_count = body['page_count']
      articles = body['articles'].map{ |article| article.slice('id', 'title', 'body') }
      response = {page: page, page_count: page_count, articles: articles}
      render json: response
    end
  end
end
