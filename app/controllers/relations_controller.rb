class RelationsController < ApplicationController
  load_and_authorize_resource :article
  load_and_authorize_resource :relation, through: :article

  def show
    @main = (params[:main_id] && Article.find(params[:main_id])) || @article
  end

  def create
    @relation.type = params[:type]
    if @relation.save
      redirect_to article_path(@article), notice:created(:relation)
    end
  end
end
