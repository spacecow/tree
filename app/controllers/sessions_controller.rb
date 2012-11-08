class SessionsController < ApplicationController
  def create
    user = User.create
    session_userid(user.id)
    redirect_to root_url
  end

  def destroy
    session_userid(nil)
    redirect_to root_url, notice:notify(:logged_out)
  end
end
