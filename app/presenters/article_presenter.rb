class ArticlePresenter < BasePresenter
  presents :article

  def subtitle
    h.content_tag :div, class:'subtitle' do
      edit_link
    end
  end

  def enemies
    h.content_tag(:h2) do
      "Enemies"
    end + 
    h.content_tag(:ul, class:'enemies') do
      h.render partial:'relations/enemy', collection:article.enemies, locals:{main:article}
    end if article.enemies.present?
  end

  def form(project_id=nil)
    h.render 'articles/form', article:article, project_id:project_id if h.can? :new, Article
  end

  def friends
    h.content_tag :div, class:'friends' do
      "Friends: #{h.render partial:'relations/friend', collection:article.friends}".html_safe
    end if article.friends.present?
  end

  def name
    h.content_tag :div, class:'name' do
      h.link_to article.name, h.article_path(article)
    end
  end

  def profile_image
    h.content_tag :div, class:%w(profile image).join(' ') do
      h.image_tag article.image_url(:profile).to_s
    end
  end

  def relations
    h.content_tag :div, class:'relations' do
      enemies+friends  
    end if article.all_relations.present?
  end

  def thumb
    h.content_tag :div, class:%w(thumb image).join(' ') do
      h.image_tag article.image_url(:thumb).to_s
    end
  end
end
