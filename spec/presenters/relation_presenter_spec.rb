require 'spec_helper'

describe RelationPresenter do
  let(:spawn){ create(:character, name:'Spawn')}
  let(:violator){ create(:character, name:'Violator')}
  let(:enemy){ create(:enemy, article:spawn, relative:violator)}
  let(:presenter){ RelationPresenter.new(enemy,view)}

  describe '#actions' do
    describe 'div.actions' do
      context 'spawn as main' do
        subject{ Capybara.string(presenter.send(:actions,spawn)).find('div.actions') }
        it{ should have_content '(Relation)' }
        it{ should have_xpath "//a[@href='#{article_relation_path(spawn,enemy,main_id:spawn.id)}']", text:'Relation' }
      end # spawn as main

      context 'violator as main' do
        subject{ Capybara.string(presenter.send(:actions,violator)).find('div.actions') }
        it{ should have_content '(Relation)' }
        it{ should have_xpath "//a[@href='#{article_relation_path(spawn,enemy,main_id:violator.id)}']", text:'Relation' }
      end # violator as main
    end
  end

  describe '#histories' do
    context 'without histories' do
      it{ presenter.histories.should be_nil }
    end #without histories

    context 'with histories' do
      before{ enemy.histories << create(:history)}

      describe 'div.histories' do
        subject{ Capybara.string(presenter.histories).find('div.histories')}
        it{ should have_selector 'div.history', count:1 }
      end
    end # with histories
  end # #histories

  describe '#name' do
    describe 'div.name' do
      context 'spawn as main' do
        subject{ Capybara.string(presenter.send(:name,spawn)).find('div.name') }
        it{ should have_xpath "//a[@href='#{article_path(violator)}']", text:'Violator' }
      end # spawn as main

      context 'violator as main' do
        subject{ Capybara.string(presenter.send(:name,violator)).find('div.name') }
        it{ should have_xpath "//a[@href='#{article_path(spawn)}']", text:'Spawn' }
      end # spawn as main
    end
  end
end
