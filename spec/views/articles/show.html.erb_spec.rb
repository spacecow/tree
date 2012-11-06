require 'spec_helper'

describe 'articles/show.html.erb' do
  let(:article){ Character.create!(name:'Spawn')}

  before do
    create(:character, name:'Violator')
    assign(:article,article)
    render
  end

  subject{ Capybara.string(rendered)}
  it{ should have_selector('h1', text:'Character') }

  describe 'div.article' do
    subject{ Capybara.string(rendered).find('div.article') }
    it{ should have_selector('div.name', text:'Spawn') }
    it{ should_not have_selector 'div.relations' }

    describe "form#new_relation" do
      subject{ Capybara.string(rendered).find("div.article form#new_relation")}
      it{ should have_select 'Type', options:['Enemy'], selected:nil }
      it{ should have_select 'Relative', options:['Violator'], selected:nil}
      it{ should have_button 'Create Relation' }
    end
  end
end
