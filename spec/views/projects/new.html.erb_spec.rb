require 'spec_helper'

describe 'projects/new.html.erb' do
  before do
    controller.stub(:current_user){ create(:user) }
    assign(:project, Project.new)
    render
  end

  describe 'form#new_project' do
    subject{ Capybara.string(rendered).find('form#new_project')}
    it{ should have_field('Title', with:nil) }
    it{ should have_button('Create Project') }
  end
end
