require 'spec_helper'

describe 'histories/_form.html.erb' do
  let(:spawn){ create(:character)}
  let(:violator){ create(:character)}
  let(:enemy){ create(:enemy, article:spawn, relative:violator)}
  before{ view.stub(:pl){ t(:history,count:1) }}

  context 'base layout' do
    before do
      render 'histories/form', history:History.new, article_id:enemy.article_id, relation_id:enemy.id
    end

    subject{ Capybara.string(rendered)}
    it{ should have_selector 'h2', text:'Add History' }
    
    describe 'form#new_history' do
      subject{ Capybara.string(rendered).find('form#new_history')}
      it{ should have_field('Content', with:nil)}
      it{ should have_field('Issue', with:nil)}
      it{ should have_field('Page', with:nil)}
      it{ should have_button 'Create History' }
    end
  end

  context 'layout for relation' do
    before do
      render 'histories/form', history:History.new, article_id:enemy.article_id, relation_id:enemy.id
    end
  end

  context 'layout for article' do
    before do
      render 'histories/form', history:History.new, article_id:spawn.id, relation_id:nil
    end

    it do rendered.should_not be_nil end
  end
end
