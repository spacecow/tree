require 'spec_helper'

describe 'relations/_enemy.html.erb' do
  let(:spawn){ create(:character, name:'Spawn')}
  let(:violator){ create(:character, name:'Violator')}
  let(:enemy){ create(:enemy, article:spawn, relative:violator)}

  context "enemy" do
    before{ render partial:'relations/relation', locals:{relation:enemy, main:spawn, relation_type: :enemy}}

    describe 'li.relation.enemy' do
      subject{ Capybara.string(rendered).find('li.relation.enemy')}
      it{ should have_selector 'div.head span.name', text:'Violator' }
    end
  end # enemy

  context "inverse enemy" do
    before{ render partial:'relations/relation', locals:{relation:enemy, main:violator, relation_type: :enemy}}

    describe 'li.relation.enemy' do
      subject{ Capybara.string(rendered).find('li.relation.enemy')}
      it{ should have_selector 'div.head span.name', text:'Spawn' }
    end
  end # inverse enemy
end
