require 'spec_helper'

describe "Projects" do
  describe "create" do
    before do
      signin
      visit new_project_path
      fill_in 'Title', with:'Spawn'
    end
    let(:create){ lambda{ click_button 'Create Project'}}

    it 'saves project to db' do
      create.should change(Project,:count).by(1)
    end

    context 'saves' do
      before{ create.call }
      subject{ Project.last }
      its(:title){ should eq 'Spawn' }
    end

    context 'error' do
      it 'title cannot be left blank' do
        fill_in 'Title', with:''
        create.call
        find('div.title span.error').should have_content 'can\'t be blank'
      end
    end
  end
end
