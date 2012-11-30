require 'spec_helper'

describe HistoriesController, focus:true do
  def send_put(content='')
    put :update, id:history.id, historable_id:history.historable_id, historable_type:history.historable_type, history:{content:content, issue:1, page:2}
  end

  describe "#update" do
    before do
      member = create :user
      session[:userid] = member.id
    end

    let(:history){ create :history }

    context "update" do
      before{ send_put('oh yeah') }

      describe "response" do
        subject{ response }
        it{ should redirect_to character_path(history.historable) }
      end

      describe "flash" do
        subject{ flash }
        its(:notice){ should eq 'History updated' } 
      end

      describe 'updated history' do
        subject{ History.last }
        its(:content){ should eq 'oh yeah' }
        its(:issue){ should eq 1 }
        its(:page){ should eq 2 }
      end
    end #update

    context "error" do
      before{ send_put('') }

      describe "response" do
        subject{ response }
        it{ should render_template :edit } 
      end  
    end
  end
end

# should render :edit
# response.should render_template(:action=> "edit")
