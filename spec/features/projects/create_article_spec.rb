require 'spec_helper'

describe 'Projects, show' do
  let(:project){ create(:project)}

  before do
    signin
    visit project_path(project)
  end

  context 'create article' do
    before do
      fill_in 'Name', with:'Spawn'
      select 'Character', from:'Type'
    end
    let(:create_article){ lambda{ click_button 'Create Article'}}
  
    it "saves an article to db" do
      create_article.should change(Article,:count).by(1)
    end
    it "saves a role to db" do
      create_article.should change(Role,:count).by(1)
    end

    context 'saves article' do
      before{ create_article.call }
      subject{ Article.last }
      its(:name){ should eq 'Spawn' }
      its(:type){ should eq 'Character' }
    end # saves article

    context 'saves roles' do
      before{ create_article.call }
      subject{ Role.last }
      its(:project_id){ should be project.id }
      its(:article_id){ should be Article.last.id }
    end # saves roles

    context 'error' do
      it 'name cannot be left blank' do
        fill_in 'Name', with:''
        create_article.call
        find('div.name span.error').should have_content 'can\'t be blank'
      end
    end # error
  end
end
