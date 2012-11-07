require 'spec_helper'

describe 'relations/show.html.erb' do
  let(:spawn){ create(:character, name:'Spawn')}
  let(:violator){ create(:character, name:'Violator')}
  let(:enemy){ create(:enemy, article:spawn, relative:violator)}

  context "direct relation" do
    before do
      enemy.histories << create(:history)
      assign(:relation, enemy)
      assign(:main, spawn)
      render
    end

    subject{ Capybara.string(rendered)}
    it{ should have_selector 'h1', text:'Spawn - Enemy: Violator' }

    describe 'div.relation' do
      subject{ Capybara.string(rendered).find('div.relation')}
      it{ should have_selector 'div.histories' }
    end

    describe 'form#new_history' do
      subject{ Capybara.string(rendered).find('form#new_history')}
      it{ should have_field('Content', with:nil)}
      it{ should have_field('Issue', with:nil)}
      it{ should have_field('Page', with:nil)}
      it{ should have_button 'Create History' }
    end
  end # direct relation

  context "inverse relation" do
    before do
      assign(:relation, enemy)
      assign(:main, violator)
      render
    end

    subject{ Capybara.string(rendered)}
    it{ should have_selector 'h1', text:'Violator - Enemy: Spawn' }
  end # inverse relation
end
