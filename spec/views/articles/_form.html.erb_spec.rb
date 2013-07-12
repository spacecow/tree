require 'spec_helper'

describe 'articles/_form.html.erb' do
  let(:article){ Article.new }
  let(:rendering){ Capybara.string rendered }
  let(:project){ create :project, title:'Spawn' }
  subject{ rendering.find('form#new_article')}

  context "project chosen" do
    before{ render 'articles/form', article:article, project_id:project.id }

    it{ should have_field 'Name', with:nil }
    it{ should have_field 'Image', with:nil }
    it{ should have_button('Create Article') }
    it{ should_not have_select('Project') } #project already chosen

    describe "Type" do
      subject{ rendering.find('select') }
      it{ subject.text.should eq %w(Character Event Place).join }
    end
  end # project chosen

  context "project not chosen" do
    before do
      project
      render 'articles/form', article:article, project_id:nil
    end

    describe "Project" do
      subject{ rendering.find 'select#project_id' }
      it{ subject.text.should eq 'Spawn' }
    end
  end # project not chosen
end
