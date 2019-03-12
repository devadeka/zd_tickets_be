class ArticlesController < ApplicationController
  PER_PAGE = 10

  def index
    page = (params[:page] || 1).to_i
    page_count = (Article.count.to_f/PER_PAGE).round
    articles = Article.all.paginate(page: page, per_page: PER_PAGE)
    response = {page: page, page_count: page_count, articles: articles}
    render json: response
  end
end
