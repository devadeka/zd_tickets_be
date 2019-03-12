class ArticlesController < ApplicationController
  def index
    @articles = Article.all.paginate(page: params[:page], per_page: 10)
    render json: @articles
  end
end
