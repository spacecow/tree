class RelationPresenter < BasePresenter
  presents :relation

  def actions(main)
    h.content_tag :div, class:'actions' do
      ("(" +
      h.link_to('Relation', h.article_relation_path(relation.article, relation, main_id:main.id)) +
      ")").html_safe
    end
  end

  def form(article)
    h.render 'relations/form', article:article, relation:relation if h.can? :new, Relation
  end

  def history_form
    h.render 'histories/form', history:History.new, article_id:relation.article_id, relation_id:relation.id
  end

  def histories
    h.content_tag :div, class:'histories' do
      h.render relation.histories
    end if relation.histories.present?
  end

  def name(main)
    h.content_tag :div, class:'name' do
      if main.id == relation.article.id
        h.link_to relation.relative_name, h.article_path(relation.relative)
      else
        h.link_to relation.article_name, h.article_path(relation.article)
      end
    end  
  end

  def thumb(main)
    h.content_tag :div, class:%w(thumb image).join(' ') do
      h.image_tag relation.image_url(:thumb,main).to_s
    end
  end
end
