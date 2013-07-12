require 'spec_helper'

describe 'Relations, layout' do
  let(:spawn){ create(:character, name:'Spawn')}
  let(:violator){ create(:character, name:'Violator')}
  let!(:enemy){ create(:enemy, article:spawn, relative:violator)}

  context "direct relation" do
    before{ visit article_path(spawn)}

    context 'link to relation' do
      before{ find('div.relations').click_link('Relation')}
      specify{ page.should have_selector 'h1', text:'Spawn - Enemy: Violator' }
    end
  end

  context "inverse relation" do
    before{ visit article_path(violator)}

    context 'link to relation' do
      before{ find('div.relations').click_link('Relation')}
      specify{ page.should have_selector 'h1', text:'Violator - Enemy: Spawn' }
    end
  end
end
