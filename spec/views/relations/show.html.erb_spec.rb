require 'spec_helper'

describe 'relations/show.html.erb' do
  let(:spawn){ create(:character, name:'Spawn')}
  let(:violator){ create(:character, name:'Violator')}
  let(:enemy){ create(:enemy, article:spawn, relative:violator)}
  before{ assign(:relation, enemy) }

  context "base layout" do
    before do
      assign(:main, spawn)
      assign(:history, History.new)
    end

    context "user not logged in" do
      before do
        controller.stub(:current_user){ nil }
        render
      end
      subject{ Capybara.string(rendered)}
      it{ should_not have_selector 'form#new_history' }
    end

    context "member logged in" do
      before do
        view.stub(:pl){ nil }
        controller.stub(:current_user){ create(:user)}
        render
      end
      subject{ Capybara.string(rendered)}
      it{ should have_selector 'form#new_history' }
    end
  end

  context "direct relation" do
    before do
      controller.stub(:current_user){ nil }
      enemy.histories << create(:history)
      assign(:main, spawn)
      assign(:history, History.new)
      render
    end

    subject{ Capybara.string(rendered)}
    it{ should have_selector 'h1', text:'Spawn - Enemy: Violator' }
    describe 'div.relation' do
      subject{ Capybara.string(rendered).find('div.relation')}
      it{ should have_selector 'div.histories' }
    end
  end # direct relation

  context "inverse relation" do
    before do
      controller.stub(:current_user){ nil }
      assign(:main, violator)
      assign(:history, History.new)
      render
    end

    subject{ Capybara.string(rendered)}
    it{ should have_selector 'h1', text:'Violator - Enemy: Spawn' }
  end # inverse relation
end
