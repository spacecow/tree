class RelationsController < ApplicationController
  before_filter :load_article, only: :create
  load_resource :article, except: :create
  authorize_resource :article
  load_and_authorize_resource :relation, through: :article

  def show
    @main = (params[:main_id] && Article.find(params[:main_id])) || @article
    @history = History.new
  end

  def create
    if params[:type] == 'Participant in'
      @relation.type = 'Participant' 
    elsif params[:type] == 'Wife'
      @relation.type = 'Husband' 
    else
      @relation.type = params[:type]
    end
    if @relation.save
      redirect_to article_path(@article), notice:created(:relation)
    end
  end

  def destroy
    @relation.destroy
    redirect_to article_path(@article), notice:deleted(:relation)
  end

  private

    def load_article
      if ['Participant in','Wife'].include? params[:type]
        relative_id = params[:relation].delete(:relative_token)
        params[:relation][:relative_token] = params[:article_id]
        @article = Article.find(relative_id)
      else
        @article = Article.find(params[:article_id])
      end
    end
end
