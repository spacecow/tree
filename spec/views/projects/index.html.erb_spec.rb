require 'spec_helper'

describe 'projects/index.html.erb' do
  context "no user logged in" do
    before{ controller.stub(:current_user){ nil }}
    context "without projects" do
      before{ render }

      describe 'div#bottom_links' do
        before{ view.stub(:pl){ t(:project,count:1) }}
        subject{ Capybara.string(rendered).find('div#bottom_links') }
        it{ should_not have_content 'New Project' }
      end
    end # without projects

    context "with projects" do
      before do
        create(:project)
        render
      end

      subject{ Capybara.string(rendered) }
      it{ should have_selector 'div.projects', count:1 }

      describe 'div.projects' do
        subject{ Capybara.string(rendered).find('div.projects')}
        it{ should have_selector 'div.project', count:1 }
      end
    end
  end # no user logged in

  context "member logged in" do
    before do
      controller.stub(:current_user){ create(:user) } # log in user!
      view.stub(:pl){ t(:project,count:1) }
      render
    end

    describe 'div#bottom_links' do
      subject{ Capybara.string(rendered).find('div#bottom_links') }
      it{ should have_xpath "//a[@href='#{new_project_path}']", text:'New Project' }
    end
  end # member logged in
end
