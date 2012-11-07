require 'spec_helper'

describe HistoryPresenter do
  let(:history){ create(:history, content:'sworn enemies')}
  let(:presenter){ HistoryPresenter.new(history,view)}

  describe '#content' do
    subject{ Capybara.string(presenter.content)}
    it{ should have_selector 'div.content', text:'sworn enemies' }
  end # #content
end
