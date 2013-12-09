require 'spec_helper'

describe 'Article' do
  before do
    visit test_articles_path
  end

  it{ page.text.should match /hej/ }
end
