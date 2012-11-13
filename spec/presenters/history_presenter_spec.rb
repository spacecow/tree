require 'spec_helper'

describe HistoryPresenter do
  let(:history){ create(:history, content:'sworn enemies')}
  let(:presenter){ HistoryPresenter.new(history,view)}

  describe '#content' do
    subject{ Capybara.string(presenter.content)}
    it{ should have_selector 'span.content', text:'sworn enemies' }
  end # #content

  describe '#reference' do
    context "issue and page" do
      before do
        history.issue = 2
        history.page = 1
      end
      subject{ Capybara.string(presenter.reference)}
      it{ should have_selector 'span.reference', text:'[no.2 p.1]' }
    end

    context "issue no page" do
      before do
        history.issue = 2
        history.page = nil
      end
      subject{ Capybara.string(presenter.reference)}
      it{ should have_selector 'span.reference', text:'[no.2]' }
    end

    context "page no issue" do
      before do
        history.issue = nil 
        history.page = 1  
      end
      subject{ Capybara.string(presenter.reference)}
      it{ should have_selector 'span.reference', text:'[p.1]' }
    end

    context "no page no issue" do
      before do
        history.issue = nil
        history.page = nil
      end
      it{ presenter.reference.should be_nil }
    end
  end # #content
end
