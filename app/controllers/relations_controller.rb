class RelationsController < ApplicationController
  load_and_authorize_resource :article
  load_and_authorize_resource :relation, through: :article

  def create
    @relation.type = params[:type]
    if @relation.save
      redirect_to root_path
    end
  end
end
