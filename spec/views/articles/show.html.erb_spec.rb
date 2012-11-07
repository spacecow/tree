require 'spec_helper'

describe 'articles/show.html.erb' do
  let(:spawn){ create(:character, name:'Spawn')}
  let(:violator){ create(:character, name:'Violator')}
  before{ create(:enemy, article:spawn, relative:violator)}


  context "enemy relation" do
    before do
      assign(:article,spawn)
      assign(:relation,Relation.new)
      render
    end

    subject{ Capybara.string(rendered)}
    it{ should have_selector('h1', text:'Spawn: Character') }

    describe 'div.article' do
      subject{ Capybara.string(rendered).find('div.article') }
      it{ should have_content 'Enemies: Violator'}

      describe "form#new_relation" do
        subject{ Capybara.string(rendered).find("div.article form#new_relation")}
        it{ should have_select 'Relative', options:['Violator'], selected:nil}
        it{ should have_select 'Type', options:['Enemy'], selected:nil }
        it{ should have_button 'Create Relation' }
      end # from#new_relation
    end # div.article
  end # enemy relation

  context "inverse enemy relation" do
    before do
      assign(:article,violator)
      assign(:relation,Relation.new)
      render
    end

    describe 'div.article' do
      describe 'div.relations' do
        subject{ Capybara.string(rendered).find('div.article div.relations')}
        it{ should have_content 'Enemies: Spawn'}
      end # div.relations
    end # div.article
  end # inverse enemy relation
end
