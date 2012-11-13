require 'spec_helper'

describe 'Article' do
  let(:spawn){ create(:character) }
  before do
    signin
    visit article_path(spawn)
    fill_in 'Content', with:'cool guy'
    fill_in 'Issue', with:1
    fill_in 'Page', with:9
  end
  let(:create_history){ lambda{ click_button 'Create History' }}

  it "saves histories to db" do
    lambda{ create_history.call }.should change(History,:count).by(1)
  end

  context "create history" do
    before{ create_history.call }
    subject{ History.last }
    its(:historable_id){ should be spawn.id }
    its(:content){ should eq 'cool guy' }
    its(:issue){ should be 1 }
    its(:page){ should be 9 }
    specify{ page.should have_content 'History created' }
    specify{ current_path.should eq article_path(spawn)}  
  end
end
