require 'spec_helper'

describe 'articles/show.html.erb' do
  let(:spawn){ create :character, name:'Spawn' }
  let(:violator){ create(:character, name:'Violator')}
  before{ create(:enemy, article:spawn, relative:violator)}

  context "base layout" do
    before do
      controller.stub(:current_user){ create(:user)}
      assign(:article,spawn)
      assign(:relation,Relation.new)
      assign(:history,History.new)
      view.stub(:pl){ nil }
      render
    end

    subject{ Capybara.string(rendered)}
    it{ should have_selector('h1', text:'Spawn: Character') }

    describe 'span.actions' do
      subject{ Capybara.string(rendered).find('span.actions')}
      it{ should have_xpath("//a", text:'Edit') }
    end

    describe 'div.article' do
      describe "form#new_relation" do
        subject{ Capybara.string(rendered).find("div.article form#new_relation")}
        it{ should have_field 'Relative', with:nil}
        it{ should have_select 'Type' } #, options:['EnemyFriendParticipantParticipant inHusbandWifeVictimKilled by'], selected:nil }
        it{ should have_button 'Create Relation' }

        describe "select" do
          subject{ Capybara.string(rendered).find("div.article form#new_relation select")}
          it{ should have_selector 'option', count:10 }
        end
      end # from#new_relation
    end # div.article
  end

  context "enemy relation" do
    before do
      controller.stub(:current_user){ nil }
      assign(:article,spawn)
      assign(:relation,Relation.new)
      assign(:history,History.new)
      view.stub(:pl){ t(:enemy,count:2) }
      render
    end

    describe 'div.article' do
      subject{ Capybara.string(rendered).find('div.article') }
      describe 'div.relations' do
        subject{ Capybara.string(rendered).find('div.article div.relations')}
        it{ should have_content 'Enemies' }
        it{ should have_content 'Violator' }
      end
    end
  end # enemy relation

  context "inverse enemy relation" do
    before do
      controller.stub(:current_user){ nil }
      assign(:article,violator)
      assign(:relation,Relation.new)
      assign(:history,History.new)
      view.stub(:pl){ t(:enemy,count:2) }
      render
    end

    describe 'div.article' do
      describe 'div.relations' do
        subject{ Capybara.string(rendered).find('div.article div.relations')}
        it{ should have_content 'Enemies' }
        it{ should have_content 'Spawn' }
      end # div.relations
    end # div.article
  end # inverse enemy relation
end
