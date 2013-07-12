require 'spec_helper'
describe ArticlesController do
  context "member logged in" do
    before{ session[:userid] = create(:user).id }

    context "delete" do
      let(:character){ create :character }
      let(:project){ character.projects.first }
      let(:delete_article){ delete :destroy, id:character.id }
      before{ delete_article }

      describe Article do
        subject{ Article }
        its(:count){ should be 0 }
      end

      describe 'response' do
        subject{ response }
        it{ should redirect_to project_url(project) }
      end
    end

    context "project exists" do
      let(:project){ create(:project) }

      context "article is valid" do
        before do
          post :create, project_id:project.id, article:{type:'some type', name:'yeah'}
        end

        describe 'response' do
          subject{ response }
          it{ should redirect_to project_url(project) }
        end
      end

      context "article is invalid" do
        before do
          post :create, project_id:project.id, article:{type:'some type'}
        end

        describe Article do
          subject{ Article }
          its(:count){ should be 0 }
        end

        describe 'response' do
          subject{ response }
          it{ should render_template 'projects/show' }
        end

        describe 'associated project' do
          subject{ Project.last }
          its(:articles){ should be_empty }
        end
      end
    end

    context "project does not exist" do
      before{ post :create }

      describe 'response' do
        subject{ response }
        it{ should redirect_to welcome_url }
      end
    end
  end
end
