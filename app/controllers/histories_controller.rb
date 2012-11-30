class HistoriesController < ApplicationController
  before_filter :load_historable
  load_and_authorize_resource :history, through: :historable

  def create
    if @history.save
      flash[:notice] = created(:history)
      if @historable.kind_of? Article
        redirect_to article_path(@historable)
      elsif @historable.kind_of? Relation
        redirect_to article_relation_path(@historable.article, @historable)
      end
    end
  end

  def update
    if @history.update_attributes params[:history]
      redirect_to @history.historable, notice:updated(:history) 
    else
      render :edit
    end
  end

  private

    def load_historable
      @historable = Kernel.const_get(params[:historable_type]).find(params[:historable_id])
    end
end
