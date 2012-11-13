require 'spec_helper'

describe 'articles/_article.html.erb' do
  let!(:event){ Character.create!(name:'Hinckley')}
  before{ render partial:'articles/article', locals:{article:event, article_type: :event}}

  describe 'li.article.event' do
    describe 'div.name' do
      subject{ Capybara.string(rendered).find('li.article.event div.name')}
      it{ should have_xpath "//a[@href='#{article_path(event)}']", text:'Hinckley' } 
    end
  end
end
