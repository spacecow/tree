class HistoryPresenter < BasePresenter
  presents :history

  def content
    h.content_tag :div, class:'content' do
      history.content
    end
  end

  def issue
    h.content_tag :div, class:'issue' do
      "No.#{history.issue.to_s}"
    end
  end

  def page
    h.content_tag :div, class:'page' do
      "pp.#{history.page.to_s}"
    end
  end
end
