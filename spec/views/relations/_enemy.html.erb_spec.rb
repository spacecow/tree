require 'spec_helper'

describe 'relations/_enemy.html.erb' do
  before do
    spawn = create(:character)
    violator = create(:character, name:'Violator')
    enemy = create(:enemy, article:spawn, relative:violator)
    render partial:'relations/enemy', locals:{enemy:enemy}
  end

  describe 'div.relation.enemy' do
    subject{ Capybara.string(rendered).find('div.relation.enemy')}

    describe 'div.name' do
      subject{ Capybara.string(rendered).find('div.relation.enemy div.name')}
      it{ should have_content 'Violator' }
    end
  end
end
