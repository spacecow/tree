require 'spec_helper'

describe 'Articles, create relation' do
  let(:spawn){ create(:character)}
  let(:violator){ create(:character, name:'Violator')}
  let(:event){ create(:event, name:'Hinckley Incident')}

  context "relation with inversion" do
    before do
      signin
      visit article_path(spawn)
      #select 'Hinckley Incident', from:'Relative'
      fill_in 'Relative', with:event.id
      select 'Participant in', from:'Type'
    end
    let(:create_relation){ lambda{ click_button 'Create Relation'}}

    it 'saves a relation to db', focus:true do
      lambda{ create_relation.call }.should change(Relation,:count).by(1)
    end

    context 'saves' do
      before{ create_relation.call }
      subject{ Relation.last }
      its(:relative_id){ should be spawn.id }
      its(:article_id){ should be event.id }
      its(:type){ should eq 'Participant' }
      it "set correct redirect"
      #specify{ current_path.should eq article_path(article)}
      specify{ page.should have_selector 'div#flash_notice', text:'Relation created' }
    end
  end

  context "relation with no inversion" do
    context "existing relation" do
      before do
        signin
        visit article_path(spawn)
        #select 'Violator', from:'Relative'
        fill_in 'Relative', with:violator.id
        select 'Enemy', from:'Type'
      end
      let(:create_relation){ lambda{ click_button 'Create Relation'}}

      it 'saves a relation to db' do
        lambda{ create_relation.call }.should change(Relation,:count).by(1)
      end

      context 'saves' do
        before{ create_relation.call }
        subject{ Relation.last }
        its(:article_id){ should be spawn.id }
        its(:relative_id){ should be violator.id }
        its(:type){ should eq 'Enemy' }
        specify{ current_path.should eq article_path(spawn)}
        specify{ page.should have_selector 'div#flash_notice', text:'Relation created' }
      end
    end

    context "non-existing relation" do
      before do
        signin
        visit article_path(spawn)
        fill_in 'Relative', with:'<<<Batman:Character>>>'
        select 'Friend', from:'Type'
      end
      let(:create_relation){ lambda{ click_button 'Create Relation'}}

      it 'saves a relation to db' do
        lambda{ create_relation.call }.should change(Relation,:count).by(1)
      end

      context 'saves' do
        before{ create_relation.call }
        subject{ Relation.last }
        its(:article_id){ should be spawn.id }
        its(:relative_id){ should be Article.last.id }
        its(:type){ should eq 'Friend' }
        specify{ current_path.should eq article_path(spawn)}
        specify{ page.should have_selector 'div#flash_notice', text:'Relation created' }
      end
    end

    context "whatever", js:true do
      it "" do
        signin
        visit article_path(spawn)
        fill_in 'Relative token', with:'Spawn'
        p Article.count
        p page.find('div.token-input-dropdown').text
        p page.find('ul.token-input-list').text
        page.driver.render('/home/jsveholm/file.png')
        page.should have_selector 'div.token-input-dropdown'
      end
    end
  end
end
