require 'spec_helper'

describe 'Articles, delete relation' do
  let(:spawn){ create(:character)}
  let(:violator){ create(:character)}
  let(:delete_relation){ lambda{ click_link 'Delete'}}
  before do
    create(:enemy, article:spawn, relative:violator)
    signin
  end

  context "main: article" do
    before{ visit article_path(spawn)}

    it 'deletes a relations from db' do
      delete_relation.should change(Relation,:count).by(-1)
    end 

    context 'delete' do
      before{ delete_relation.call }
      specify{ current_path.should eq article_path(spawn)} 
      specify{ page.should have_content 'Relation deleted' }
    end
  end

  context "main: relative" do
    before{ visit article_path(violator)}

    it 'deletes a relations from db' do
      delete_relation.should change(Relation,:count).by(-1)
    end 

    context 'delete' do
      before{ delete_relation.call }
      #specify{ current_path.should eq article_path(violator)} 
      specify{ page.should have_content 'Relation deleted' }
    end
  end
end
