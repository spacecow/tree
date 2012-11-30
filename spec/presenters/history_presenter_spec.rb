require 'spec_helper'

describe HistoryPresenter do
  context "new history" do
    let(:history){ mock_model(History).as_new_record }
    let(:presenter){ HistoryPresenter.new(history,view)}
    
    describe '#form' do
      before do
        view.stub(:pl){ t(:history,count:1)}
      end
      let(:rendered){ Capybara.string(presenter.form(1,'Article'))}

      describe "form section" do
        describe "header" do
          subject{ rendered.find('div.form h2') }
          its(:text){ should eq 'Add History' }
        end

        describe "form" do
          subject{ rendered.find("div.form")}

          describe "Content" do
            subject{ rendered.find("#history_content")}
            its(:value){ should be_nil }
          end

          describe "Issue" do
            subject{ rendered.find("#history_issue")}
            its(:value){ should be_nil }
          end

          describe "Page" do
            subject{ rendered.find("#history_page")}
            its(:value){ should be_nil }
          end

          it{ should have_button 'Create History' }
        end # form
      end # form section
    end # #form
  end # new history

  context "saved history" do
    let(:history){ mock_model(History) }
    let(:presenter){ HistoryPresenter.new(history,view)}

    describe '#form' do
      before do
      end
      let(:rendered){ Capybara.string(presenter.form(1,'Article'))}
      
      describe "form section" do
        subject{ rendered.find('div.form')}
        it{ should_not have_selector 'h2' } 

        describe "form" do
          subject{ rendered.find("div.form")}

          describe "Content" do
            before{ history.stub(:content){ 'Oh?' }}
            subject{ rendered.find("#history_content")}
            its(:value){ should eq 'Oh?' }
          end

          describe "Issue" do
            before{ history.stub(:issue){ 1 }}
            subject{ rendered.find("#history_issue")}
            its(:value){ should eq '1' }
          end

          describe "Page" do
            before{ history.stub(:page){ 2 }}
            subject{ rendered.find("#history_page")}
            its(:value){ should eq '2' }
          end

          it{ should have_button 'Update History' }
        end # form
      end # form section
    end # #form

    describe '#reference' do
      before do
        history.stub(:historable_id){666}
        history.stub(:historable_type){'Article'}
      end

      describe 'span.reference' do
        context "article reference" do
          subject{ Capybara.string(presenter.reference).span(:reference).find('a')}
          specify{ subject[:href].should eq edit_history_path(history, historable_id:666, historable_type:'Article')}
        end

        it "relation reference"

        context "issue and page" do
          before do
            history.stub(:issue){ 2 }
            history.stub(:page){ 1 }
          end
          subject{ Capybara.string(presenter.reference).span(:reference)}
          its(:text){ should eq '[no.2 p.1]' }

          describe 'a' do
            subject{ Capybara.string(presenter.reference).span(:reference).find('a')}
            its(:text){ should eq 'no.2 p.1' }
          end
        end #issue and page

        context "issue, no page" do
          before{ history.stub(:issue){ 2 }}
          subject{ Capybara.string(presenter.reference).span(:reference)}
          its(:text){ should eq '[no.2]' }

          describe 'a' do
            subject{ Capybara.string(presenter.reference).span(:reference).find('a')}
            its(:text){ should eq 'no.2' }
          end
        end #issue, no page

        context "page, no issue" do
          before{ history.stub(:page){ 1 }}
          subject{ Capybara.string(presenter.reference).span(:reference)}
          its(:text){ should eq '[p.1]' }

          describe 'a' do
            subject{ Capybara.string(presenter.reference).span(:reference).find('a')}
            its(:text){ should eq 'p.1' }
          end
        end # page, no issue

        context "no page, no issue" do
          subject{ Capybara.string(presenter.reference).span(:reference)}
          its(:text){ should eq '[Edit]' }

          describe 'a' do
            subject{ Capybara.string(presenter.reference).span(:reference).find('a')}
            its(:text){ should eq 'Edit' }
          end
        end #no page, no issue
      end #span.reference
    end # #reference

    describe '#content' do
      describe 'span.conten' do
        before{ history.stub(:content){'sworn enemies'}}
        subject{ Capybara.string(presenter.content).span(:content)}
        its(:text){ should eq 'sworn enemies' }
      end
    end
  end
end
