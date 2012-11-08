require 'spec_helper'

describe 'articles/_form.html.erb' do
  before{ render 'articles/form', article:Article.new, project_id:1 }

  describe "form#new_article" do
    subject{ Capybara.string(rendered).find('form#new_article')}
    it{ should have_field 'Name', with:nil }
    it{ should have_select('Type', options:['Character', 'Event'], selected:nil)}
    it{ should have_field 'Image', with:nil }
    it{ should have_button('Create Article') }

    it{ should_not have_select('Project') }
    it "should have select Project"
  end
end
