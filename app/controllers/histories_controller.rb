class HistoriesController < ApplicationController
  load_and_authorize_resource :article
  before_filter :load_history
  load_and_authorize_resource :relation, through: :article
  load_and_authorize_resource :history, through: :relation

  def create
    if @history.save
      if params[:relation_id]
        redirect_to article_relation_url(@article, @relation), notice:created(:history)
      else
        redirect_to article_url(@article), notice:created(:history)
      end
    end
  end

  private

    def load_history
      unless params[:relation_id] 
        @history = @article.histories.build(params[:history])
        authorize! :create, @history
      end
    end
end
