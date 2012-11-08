require 'spec_helper'

describe HistoryPresenter do
  let(:history){ create(:history, content:'sworn enemies')}
  let(:presenter){ HistoryPresenter.new(history,view)}

  describe '#content' do
    subject{ Capybara.string(presenter.content)}
    it{ should have_selector 'div.content', text:'sworn enemies' }
  end # #content

  describe '#issue' do
    context "exists" do
      before{ history.issue = 2 }
      subject{ Capybara.string(presenter.issue)}
      it{ should have_selector 'div.issue', text:'No.2' }
    end
    context "doesn't exists" do
      before{ history.issue = nil }
      it{ presenter.issue.should be_nil }
    end
  end # #content

  describe '#page' do
    context "exists" do
      before{ history.page = 10 }
      subject{ Capybara.string(presenter.page)}
      it{ should have_selector 'div.page', text:'p.10' }
    end
    context "doesn't exists" do
      it{ presenter.page.should be_nil }
    end
  end # #content
end
