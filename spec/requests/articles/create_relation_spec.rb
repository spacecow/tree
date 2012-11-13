require 'spec_helper'

describe 'Articles, create relation' do
  let(:article){ create(:character)}
  let!(:enemy){ create(:character, name:'Violator')}
  let!(:event){ create(:event, name:'Hinckley Incident')}

  context "relation with inversion" do
    before do
      signin
      visit article_path(article)
      select 'Hinckley Incident', from:'Relative'
      select 'Participant in', from:'Type'
    end
    let(:create_relation){ lambda{ click_button 'Create Relation'}}

    it 'saves a relation to db' do
      lambda{ create_relation.call }.should change(Relation,:count).by(1)
    end

    context 'saves' do
      before{ create_relation.call }
      subject{ Relation.last }
      its(:relative_id){ should be article.id }
      its(:article_id){ should be event.id }
      its(:type){ should eq 'Participant' }
      it "set correct redirect"
      #specify{ current_path.should eq article_path(article)}
      specify{ page.should have_selector 'div#flash_notice', text:'Relation created' }
    end
  end

  context "relation with no inversion" do
    before do
      signin
      visit article_path(article)
      select 'Violator', from:'Relative'
      select 'Enemy', from:'Type'
    end
    let(:create_relation){ lambda{ click_button 'Create Relation'}}

    it 'saves a relation to db' do
      lambda{ create_relation.call }.should change(Relation,:count).by(1)
    end

    context 'saves' do
      before{ create_relation.call }
      subject{ Relation.last }
      its(:article_id){ should be article.id }
      its(:relative_id){ should be enemy.id }
      its(:type){ should eq 'Enemy' }
      specify{ current_path.should eq article_path(article)}
      specify{ page.should have_selector 'div#flash_notice', text:'Relation created' }
    end
  end
end
