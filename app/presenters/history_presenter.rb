class HistoryPresenter < BasePresenter
  presents :history

  def content
    h.content_tag :span, class:'content' do
      history.content
    end
  end

  def form(id, type)
    h.content_tag(:div, class:'form') do
      ((history.new_record? ?  h.minititle(h.add(:history)) : '') +
      h.render('histories/form', history:history, historable_id:id, historable_type:type)).html_safe
    end
  end

  def reference
    h.content_tag :span, class:'reference' do
      ("["+
      h.link_to(
        if history.page and history.issue
          issue+" "+page
        elsif history.issue
          issue
        elsif history.page
          page
        else
          'Edit'
        end,
        h.edit_history_path(history, historable_id:history.historable_id, historable_type:history.historable_type)) +
      "]").html_safe
    end
  end

  private
  
    def issue; "no."+history.issue.to_s end
    def page; "p."+history.page.to_s end
end
