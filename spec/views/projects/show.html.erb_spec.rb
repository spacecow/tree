require 'spec_helper'

describe 'projects/show.html.erb' do
  let(:project){ create(:project, title:'Spawn')}
  before{ assign(:project, project)}

  context "without characters" do
    before{ render }

    subject{ Capybara.string(rendered)}
    it{ should have_selector 'h1', text:'Spawn' }

    describe 'div.project' do
      subject{ Capybara.string(rendered).find('div.project')}
      it{ should_not have_selector 'div.characters.articles' }
    end
  end # without characters

  context "with characters" do
    before do
      character = Character.create!(name:'whatever')
      project.articles << character
      render
    end

    describe 'div.project' do
      subject{ Capybara.string(rendered).find('div.project')}
      it{ should have_selector 'div.characters.articles', count:1 }

      describe 'div.characters.articles' do
        subject{ Capybara.string(rendered).find('div.project div.characters.articles')}
        it{ should have_content 'Characters:' }
        it{ should have_selector 'div.character.article', count:1 }
      end
    end
  end
end
