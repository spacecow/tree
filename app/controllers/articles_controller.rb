class ArticlesController < ApplicationController
  before_filter :init_article, only: :create
  load_and_authorize_resource

  def create
    if @article.save
      redirect_to articles_url
    else
      render :new
    end
  end

  private

    def init_article
      if params[:type] == 'Character'
        @article = Character.new(params[:article])
      end
    end
end
