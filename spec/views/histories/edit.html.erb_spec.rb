require 'spec_helper'

describe 'histories/edit.html.erb' do
  let(:historable){ mock_model Article }
  let(:history){ mock_model History }
  before do
    view.stub(:pl){ t(:history, count:1) }
    assign(:historable,historable)
    assign(:history,history)
    render
  end

  describe "title" do
    subject{ Capybara.string(rendered).find('h1') }
    its(:text){ should eq 'Edit History' }
  end

  describe "form section" do
    subject{ Capybara.string(rendered).find('div.form')}
    it{ should_not have_selector 'h2' }
    it{ should have_selector "form#edit_history_#{history.id}" }
  end
end
