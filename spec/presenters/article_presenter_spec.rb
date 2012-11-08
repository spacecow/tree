require 'spec_helper'

describe ArticlePresenter do
  let(:spawn){ create(:character)}
  let(:violator){ create(:character)}
  let(:batman){ create(:character)}
  let(:presenter){ ArticlePresenter.new(spawn, view)}
  describe '#relations' do
    context 'without relations' do
      it{ presenter.relations.should be_nil }
    end #without relations

    context 'with enemies&friends' do
      before do
        create(:enemy, article:spawn, relative:violator)
        create(:friend, article:spawn, relative:batman)
      end

      describe 'div.relations' do
        subject{ Capybara.string(presenter.relations).find('div.relations') }
        it{ should have_selector 'h2', text:'Enemies' }
        it{ should have_selector 'ul.enemies' }
        it{ should have_selector 'div.friends' }
        it{ should have_content 'Friends:' }
      end # div.relations
    end # with enemies&friends
  end # #relations

  describe '#enemies' do
    context 'with friends' do
      before{ create(:friend, article:spawn, relative:violator)}
      it{ presenter.enemies.should be_nil }
    end

    context 'with inverse enemy' do
      before{ create(:enemy, article:violator, relative:spawn)}
      subject{ Capybara.string(presenter.relations)}
      it{ should have_selector 'h2', text:'Enemies' }

      describe 'ul.enemies' do
        subject{ Capybara.string(presenter.relations).find('ul.enemies')}
        it{ should have_selector 'li.relation.enemy', count:1 }
      end
    end

    context 'with enemies' do
      before{ create(:enemy, article:spawn, relative:violator)}
      subject{ Capybara.string(presenter.relations)}
      it{ should have_selector 'h2', text:'Enemies' }

      describe 'ul.enemies' do
        subject{ Capybara.string(presenter.relations).find('ul.enemies')}
        it{ should have_selector 'li.relation.enemy', count:1 }
      end
    end
  end
end
