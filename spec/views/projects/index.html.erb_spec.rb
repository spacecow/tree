require 'spec_helper'

describe 'projects/index.html.erb' do
  context "no user logged in" do
    before do
      controller.stub(:current_user){ nil }
      view.stub(:pl){ t(:project,count:1) }
      render
    end

    subject{ Capybara.string(rendered) }
    it{ should_not have_selector 'div#bottom_links' }
  end # no user logged in

  context "member logged in" do
    before do
      controller.stub(:current_user){ nil } # log in user!
      view.stub(:pl){ t(:project,count:1) }
      render
    end

    describe 'div#bottom_links' do
      subject{ Capybara.string(rendered).find('div#bottom_links') }
      it{ should have_xpath '//a', text:'New Project' }
    end
  end # member logged in
end
