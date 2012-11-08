require 'spec_helper'

describe ProjectPresenter do
  let(:project){ create(:project)}
  let(:presenter){ ProjectPresenter.new(project,view)}

  describe "#articles" do
    context "without articles" do
      specify{ presenter.articles.should be_nil }
    end

    context "with characters&events" do
      before do
        project.articles << create(:character)
        project.articles << create(:event)
      end

      describe 'div.articles' do
        subject{ Capybara.string(presenter.articles).find('div.articles')}
        it{ should have_selector 'h2', text:'Characters' }
        it{ should have_selector 'ul.characters'}
        it{ should have_content 'Events:' }
        it{ should have_selector 'div.events'}
      end # div.articles
    end # with characters&events
  end # #articles

  describe "#characters" do
    context 'with events' do
      before{ project.articles << create(:event)}
      specify{ presenter.characters.should be_nil }
    end # with events 

    context 'with characters' do
      before{ project.articles << create(:character)}
      subject{ Capybara.string(presenter.characters)}
      it{ should have_selector 'h2', text:'Characters' }

      describe 'ul.characters' do
        subject{ Capybara.string(presenter.characters).find('ul.characters')}
        it{ should have_selector 'li.article.character', count:1 }
      end # div.characters
    end # with characters 
  end
end
