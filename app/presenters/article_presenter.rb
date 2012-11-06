class ArticlePresenter < BasePresenter
  presents :article

  def name
    h.content_tag :div, class:'name' do
      h.link_to article.name, h.article_path(article)
    end
  end

  def enemies
    h.content_tag :div, class:'enemies' do
      "Enemies: #{h.render partial:'relations/enemy', collection:article.enemies}".html_safe
    end if article.enemies.present?
  end
  def friends
    h.content_tag :div, class:'friends' do
      "Friends: #{h.render partial:'relations/friend', collection:article.friends}".html_safe
    end if article.friends.present?
  end

  def relations
    h.content_tag :div, class:'relations' do
      enemies+friends  
    end if article.relations.present?
  end
end
