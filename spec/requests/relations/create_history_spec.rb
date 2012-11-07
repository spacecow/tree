require 'spec_helper'

describe 'Relation' do
  let(:spawn){ create(:character) }
  let(:violator){ create(:character) }
  let(:enemy){ create(:enemy, article:spawn, relative:violator)}
  before do
    signin
    visit article_relation_path(spawn,enemy)
    fill_in 'Content', with:'sworn enemies'
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
    its(:relation_id){ should be enemy.id }
    its(:content){ should eq 'sworn enemies' }
    its(:issue){ should be 1 }
    its(:page){ should be 9 }
    specify{ page.should have_content 'History created' }
    specify{ current_path.should eq article_relation_path(spawn,enemy)}  
  end
end
