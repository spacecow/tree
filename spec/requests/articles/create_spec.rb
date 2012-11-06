require 'spec_helper'

describe 'Articles, create' do
  before do
    signin
    visit new_article_path
    fill_in 'Name', with:'Spawn'
  end
  let(:create){ lambda{ click_button 'Create Article'}}

  it 'saves project to db' do
    create.should change(Article,:count).by(1)
  end

  context 'saves' do
    before{ create.call }
    subject{ Article.last }
    its(:name){ should eq 'Spawn' }
    its(:type){ should eq 'Character' }
  end # saves

  context 'error' do
    it 'name cannot be left blank' do
      fill_in 'Name', with:''
      create.call
      find('div.name span.error').should have_content 'can\'t be blank'
    end
  end # error
end
