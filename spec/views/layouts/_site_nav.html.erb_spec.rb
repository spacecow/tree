require 'spec_helper'

describe 'layouts/_site_nav.html.erb' do
  before do
    view.stub(:pl){ t(:project, count:2) }
    render partial:'layouts/site_nav'
  end

  describe 'div#site_nav' do
    subject{ Capybara.string(rendered).find('div#site_nav')}
    it{ should have_xpath "//a[@href='#{projects_path}']", text:'Projects' }
  end
end
