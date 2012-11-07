require 'spec_helper'

describe 'articles/edit.html.erb' do
  let(:spawn){ create(:character, name:'Spawn')}
  before do
    assign(:article, spawn)
    render
  end

  describe 'form#edit_article' do
    subject{ Capybara.string(rendered).find("form#edit_article") }
    it{ should have_field('Name', with:'Spawn') }
    it{ should have_select('Type', options:['Character', 'Event'], selected:'Character') }
    it{ should have_button('Update Article') }
  end
end
