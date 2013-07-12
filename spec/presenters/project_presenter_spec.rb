require 'spec_helper'

describe ProjectPresenter do
  let(:project){ create(:project)}
  let(:presenter){ ProjectPresenter.new(project,view)}

  describe "#articles" do
    context "without articles" do
      specify{ presenter.articles.should be_empty }
    end

    context "with characters&events" do
      before do
        project.articles << create(:character)
        project.articles << create(:event)
        view.stub(:pl){ nil }
      end

      describe 'div.articles' do
        subject{ Capybara.string(presenter.articles).find('div.articles')}
        #it{ should have_selector 'h2', text:'Characters' }
        it{ should have_selector 'ul.characters'}
        #it{ should have_selector 'h2', text:'Events' }
        it{ should have_selector 'ul.events'}
      end # div.articles
    end # with characters&events
  end # #articles

  describe "#characters" do
    context 'with events' do
      before{ project.articles << create(:event)}
      specify{ presenter.characters.should be_empty }
    end # with events

    context 'with characters' do
      before do
        project.articles << create(:character)
        view.stub(:pl){ t(:character,count:2) }
      end
      subject{ Capybara.string(presenter.characters)}
      it{ should have_selector 'h2', text:'Characters' }

      describe 'ul.characters' do
        subject{ Capybara.string(presenter.characters).find('ul.characters')}
        it{ should have_selector 'li.article.character', count:1 }
      end # div.characters
    end # with characters
  end

  describe "#events" do
    context 'with characters' do
      before{ project.articles << create(:character)}
      specify{ presenter.events.should be_nil }
    end # with characters

    context 'with events' do
      before do
        project.articles << create(:event)
        view.stub(:pl){ t(:event,count:2) }
      end
      subject{ Capybara.string(presenter.events)}
      it{ should have_selector 'h2', text:'Events' }

      describe 'ul.events' do
        subject{ Capybara.string(presenter.events).find('ul.events')}
        it{ should have_selector 'li.article.event', count:1 }
      end # div.events
    end # with events
  end
end
