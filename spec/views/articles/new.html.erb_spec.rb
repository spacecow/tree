require 'spec_helper'

describe 'articles/new.html.erb' do
  before do
    assign(:article, Article.new)
    render
  end

  describe 'form#new_article' do
    subject{ Capybara.string(rendered) }
    it{ should have_field('Name', with:nil) }
    it{ should have_button('Create Article') }
    it{ should have_select('Type', options:['Character'], selected:nil) }
  end
end
