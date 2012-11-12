require 'spec_helper'

describe 'articles/_event.html.erb' do
  let!(:event){ Character.create!(name:'Hinckley')}
  before{ render partial:'articles/event', locals:{event:event}}

  describe 'li.article.event' do
    describe 'div.name' do
      subject{ Capybara.string(rendered).find('li.article.event div.name')}
      it{ should have_xpath "//a[@href='#{article_path(event)}']", text:'Hinckley' } 
    end
  end
end
