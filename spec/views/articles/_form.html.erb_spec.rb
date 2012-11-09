require 'spec_helper'

describe 'articles/_form.html.erb' do
  context "base layout" do
    before{ render 'articles/form', article:Article.new, project_id:1 }

    describe "form#new_article" do
      subject{ Capybara.string(rendered).find('form#new_article')}
      it{ should have_field 'Name', with:nil }
      it{ should have_select('Type', options:['Character', 'Event'], selected:nil)}
      it{ should have_field 'Image', with:nil }
      it{ should have_button('Create Article') }
    end
  end # base layout

  context "project selected" do
    before{ render 'articles/form', article:Article.new, project_id:1 }
    describe "form#new_article" do
      subject{ Capybara.string(rendered).find('form#new_article')}
      it{ should_not have_select('Project') }
    end
  end

  context "project not selected" do
    before do
      create(:project, title:'Spawn')
      render 'articles/form', article:Article.new, project_id:nil
    end

    describe "form#new_article" do
      subject{ Capybara.string(rendered).find('form#new_article')}
      it{ should have_select('Project', options:['Spawn']) }
    end
  end
end
