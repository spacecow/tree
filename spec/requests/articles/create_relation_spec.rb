require 'spec_helper'

describe 'Articles, create relation' do
  let(:article){ create(:character)}
  let!(:enemy){ create(:character, name:'Violator')}

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
  end
end
