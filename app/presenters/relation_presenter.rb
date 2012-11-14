class RelationPresenter < BasePresenter
  presents :relation

  def actions(main)
    h.content_tag :span, class:'actions' do
      ("(" +
      relation_link(main) +
      " " +
      delete_relation_link +
      ")").html_safe
    end
  end

  def body
    h.content_tag :body, class:'head' do
      histories
    end if relation.histories.present?
  end

  def delete_relation_link
    h.link_to(h.t(:delete), h.article_relation_path(relation.article, relation), method: :delete)
  end

  def form(article)
    h.render 'relations/form', article:article, relation:relation if h.can? :new, Relation
  end

  def head(main)
    h.content_tag :div, class:'head' do
      name(main)+actions(main)
    end
  end

  def history_form
    h.render 'histories/form', history:History.new, article_id:relation.article_id, relation_id:relation.id if h.can? :new, History
  end

  def histories
    h.content_tag :div, class:'histories' do
      h.render relation.histories
    end if relation.histories.present?
  end

  def name(main)
    h.content_tag :span, class:'name' do
      if main.id == relation.article.id
        h.link_to relation.relative_name, h.article_path(relation.relative)
      else
        h.link_to relation.article_name, h.article_path(relation.article)
      end
    end  
  end

  def relation_link(main)
    h.link_to(h.t(:relation,count:1), h.article_relation_path(relation.article, relation, main_id:main.id))
  end

  def thumb(main)
    h.content_tag :div, class:%w(thumb image).join(' ') do
      h.image_tag relation.image_url(:thumb,main).to_s
    end
  end
end
