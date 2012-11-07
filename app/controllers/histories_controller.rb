class HistoriesController < ApplicationController
  load_and_authorize_resource :article
  load_and_authorize_resource :relation, through: :article
  load_and_authorize_resource :history, through: :relation

  def create
    if @history.save
      redirect_to article_relation_url(@article, @relation), notice:created(:history)
    end
  end
end
