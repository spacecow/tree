class HistoryPresenter < BasePresenter
  presents :history

  def content
    h.content_tag :span, class:'content' do
      history.content
    end
  end

  def reference
    h.content_tag :span, class:'reference' do
      if history.page and history.issue
        "[no.#{history.issue.to_s} p.#{history.page.to_s}]"
      elsif history.issue
        "[no.#{history.issue.to_s}]"
      else
        "[p.#{history.page.to_s}]"
      end
    end unless history.page.nil? and history.issue.nil?
  end
end
