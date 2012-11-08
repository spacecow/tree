require 'spec_helper'

describe 'relations/_enemy.html.erb' do
  let(:spawn){ create(:character, name:'Spawn')}
  let(:violator){ create(:character, name:'Violator')}
  let(:enemy){ create(:enemy, article:spawn, relative:violator)}

  context "enemy" do
    before{ render partial:'relations/enemy', locals:{enemy:enemy, main:spawn}}

    describe 'li.relation.enemy' do
      subject{ Capybara.string(rendered).find('li.relation.enemy')}
      it{ should have_selector 'div.name', text:'Violator' }
    end
  end # enemy

  context "inverse enemy" do
    before{ render partial:'relations/enemy', locals:{enemy:enemy, main:violator}}

    describe 'li.relation.enemy' do
      subject{ Capybara.string(rendered).find('li.relation.enemy')}
      it{ should have_selector 'div.name', text:'Spawn' }
    end
  end # inverse enemy
end
