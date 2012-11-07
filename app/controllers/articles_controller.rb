class ArticlesController < ApplicationController
  load_and_authorize_resource except: :create

  def show
    @relation = Relation.new
  end

  def create
    @project = params[:project_id] && Project.find(params[:project_id])
    authorize! :show, @project
    type = params[:article].delete(:type)
    @article = Article.new(params[:article])
    @article.type = type

    if @article.save
      @article.projects << @project
      redirect_to articles_url
    else
      render :new
    end
  end

  def update
    @article.type = params[:article].delete(:type)
    if @article.update_attributes(params[:article])
      redirect_to article_path(@article)
    end
  end
end
