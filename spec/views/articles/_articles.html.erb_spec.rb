require 'spec_helper'

describe 'articles/_articles.html.erb' do
  let(:presenter){ stub(:presenter).as_null_object }
  before do
    view.should_receive(:present).with(Article).and_yield presenter
  end

  it "is has a wrapper" do
    render 'articles/articles'
    p rendered
    rendered.should have_selector 'ul.articles'
  end

  it "displays the articles" do
    presenter.should_receive(:articles).once
    render 'articles/articles'
  end
end
