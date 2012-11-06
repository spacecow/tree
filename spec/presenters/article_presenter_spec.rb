require 'spec_helper'

describe ArticlePresenter do
  let(:spawn){ create(:character)}
  let(:violator){ create(:character)}
  let(:batman){ create(:character)}
  describe '#relations' do
    context 'without relations' do
      let(:presenter){ ArticlePresenter.new(spawn, view)}
      it{ presenter.relations.should be_nil }
    end #without relations

    context 'with enemies&friends' do
      before do
        create(:enemy, article:spawn, relative:violator)
        create(:friend, article:spawn, relative:batman)
      end

      let(:presenter){ ArticlePresenter.new(spawn, view)}

      describe 'div.relations' do
        subject{ Capybara.string(presenter.relations).find('div.relations') }
        it{ should have_selector 'div.enemies' }
        it{ should have_selector 'div.friends' }
        it{ should have_content 'Enemies:' }
        it{ should have_content 'Friends:' }
      end
    end # with relations
  end # #relations

  describe '#enemies' do
    context 'with friends' do
      before{ spawn.relations << create(:friend)}
      let(:presenter){ ArticlePresenter.new(spawn, view)}
      it{ presenter.enemies.should be_nil }
    end

    context 'with enemies' do
      before{ create(:enemy, article:spawn, relative:violator)}
      let(:presenter){ ArticlePresenter.new(spawn, view)}

      describe 'div.enemies' do
        subject{ Capybara.string(presenter.relations).find('div.enemies') }
        it{ should have_content 'Enemies:' }
        it{ should have_selector 'div.relation.enemy', count:1 }
      end
    end
  end
end
