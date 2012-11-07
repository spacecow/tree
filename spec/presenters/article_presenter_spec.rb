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
        it{ should have_selector 'div.enemies' }
        it{ should have_selector 'div.friends' }
        it{ should have_content 'Enemies:' }
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

      describe 'div.enemies' do
        subject{ Capybara.string(presenter.relations).find('div.enemies')}
        it{ should have_content 'Enemies:' }
        it{ should have_selector 'div.relation.enemy', count:1 }
      end
    end

    context 'with enemies' do
      before{ create(:enemy, article:spawn, relative:violator)}

      describe 'div.enemies' do
        subject{ Capybara.string(presenter.relations).find('div.enemies')}
        it{ should have_content 'Enemies:' }
        it{ should have_selector 'div.relation.enemy', count:1 }
      end
    end
  end
end
