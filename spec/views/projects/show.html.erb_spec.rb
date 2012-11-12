require 'spec_helper'

describe 'projects/show.html.erb' do
  let(:project){ create(:project, title:'Spawn')}

  before do
    controller.stub(:current_user){ create(:user)}
    view.stub(:pl){ nil }
    project.articles << create(:character)
    assign(:project, project)
    assign(:article, Article.new)
    render
  end

  subject{ Capybara.string(rendered)}
  it{ should have_selector 'h1', text:'Spawn' }

  describe 'div.project' do
    subject{ Capybara.string(rendered).find('div.project')}
    it{ should have_selector 'div.articles' }
    it{ should have_selector 'h2', text:'New Article' }
    it{ should have_selector 'form#new_article' }
  end
end
