class SessionsController < ApplicationController
  def create
    user = User.create
    session_userid(user.id)
    redirect_to root_url
  end
end
