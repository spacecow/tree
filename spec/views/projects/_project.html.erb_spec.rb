require 'spec_helper'

describe 'projects/_project.html.erb' do
  let(:project){ create(:project, title:'Spawn')}
  before{ render project }

  describe 'div.project' do
    subject{ Capybara.string(rendered).find('div.project')}

    describe 'div.title' do
      subject{ Capybara.string(rendered).find('div.project div.title')}
      it{ should have_xpath "//a[@href='#{project_path(project)}']", text:'Spawn' }
    end
  end
end
