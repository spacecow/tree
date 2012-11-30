class ArticlesController < ApplicationController
  load_and_authorize_resource except: :create

  def show
    @relation = Relation.new
    @history = History.new
  end

  def index
    respond_to do |f|
      f.json { render json: @articles.token(params[:q])}
    end
  end

  def create
    @project = params[:project_id] && Project.find(params[:project_id])
    authorize! :show, @project
    type = params[:article].delete(:type)
    @article = Article.new(params[:article])
    @article.type = type

    if @article.save
        @article.projects << @project
      if params[:article][:image].present?
        render :crop
      else
        redirect_to articles_url
      end
    else
      if request.referer =~ /articles\/new/
        render :new
      else
        render template:'projects/show' 
      end
    end
  end

  def update
    @article.type = params[:article].delete(:type) if params[:article] && params[:article][:type].present?
    if @article.update_attributes(params[:article])
      if params[:article][:image].present?
        render :crop
      else
        redirect_to article_path(@article)
      end
    else
      # error handling
    end
  end
end
