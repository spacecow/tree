require 'spec_helper'

describe 'Articles, update' do
  let(:spawn){ create(:character, name:'Spawn')}
  before do
    signin
    visit edit_article_path(spawn)
    fill_in 'Name', with:'Violator'
    select 'Event', from:'Type'
  end
  let(:update){ lambda{ click_button 'Update Character'}}

  it 'saves updated project to db' do
    update.should change(Article,:count).by(0)
  end

  context 'update' do
    before{ update.call }
    subject{ Article.last }
    its(:name){ should eq 'Violator' }
    its(:type){ should eq 'Event' }
  end
end
