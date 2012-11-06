class RelationPresenter < BasePresenter
  presents :relation

  def name
    h.content_tag :div, class:'name' do
      relation.name
    end  
  end
end
