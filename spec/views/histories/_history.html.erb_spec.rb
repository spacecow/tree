require 'spec_helper'

describe 'histories/_history.html.erb' do
  let!(:history){ create(:history, content:'sworn enemies', issue:1, page:9)}
  before{ render history }
  describe 'div.history' do
    subject{ Capybara.string(rendered).find('span.history')}
    it{ should have_content 'sworn enemies [no.1 p.9]' }
  end
end
