require 'spec_helper'

describe 'articles/_character.html.erb' do
  let!(:character){ Character.create!(name:'Spawn')}
  before{ render partial:'articles/character', locals:{character:character}}

  describe 'div.article.character' do
    subject{ Capybara.string(rendered).find('div.article.character')}
    it{ should have_xpath "//a[@href='#{article_path(character)}']", text:'Spawn' } 
  end
end
