require 'spec_helper'

describe 'projects/show.html.erb' do
  let(:project){ create(:project, title:'Spawn')}

  before do
    project.articles << create(:character)
    assign(:project, project)
    render
  end

  subject{ Capybara.string(rendered)}
  it{ should have_selector 'h1', text:'Spawn' }

  describe 'div.project' do
    subject{ Capybara.string(rendered).find('div.project')}
    it{ should have_selector 'div.articles' }

    #describe "form#new_article" do
    #  subject{ Capybara.string(rendered).find('div.project form#new_article')}
    #  it{ should have_select 'Article' }
    #end
  end
end
