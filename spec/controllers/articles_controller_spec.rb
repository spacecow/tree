require 'spec_helper'

describe ArticlesController do
  context "member logged in" do
    before{ session[:userid] = create(:user).id }

    it "can create with a project" do 
      project = create(:project)
      post :create, project_id:project.id, article:{type:'whatever'}
      response.redirect_url.should be_nil
    end

    it "cannot create without a project" do 
      post :create
      response.redirect_url.should eq welcome_url
    end
  end
end
