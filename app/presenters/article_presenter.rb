class ArticlePresenter < BasePresenter
  presents :article

  def enemies; listing(:enemy) end

  def form(project_id=nil)
    h.render 'articles/form', article:article, project_id:project_id if h.can? :new, Article
  end

  def friends; listing(:friend) end

  def listing(sing)
    ((h.content_tag(:h2) do
      h.pl(sing)
    end +
    h.content_tag(:ul, class:sing.to_s.pluralize) do
      h.render partial:"relations/#{sing}", collection:article.send(sing.to_s.pluralize), locals:{main:article}
    end if article.send(sing.to_s.pluralize).present?) || "").html_safe
  end

  def name
    h.content_tag :div, class:'name' do
      h.link_to article.name, h.article_path(article)
    end
  end

  def participants; listing(:participant) end
  def participant_ins; listing(:participant_in) end

  def profile_image
    h.content_tag :div, class:%w(profile image).join(' ') do
      h.image_tag article.image_url(:profile) if article.image_url(:profile)
    end
  end

  def relation_form(relation)
    output = nil
    h.present relation do |presenter|
      output = presenter.form(article)
    end
    output
  end

  def relations
    h.content_tag :div, class:'relations' do
      #enemies+friends+participants
      #p participants.class
      #p enemies.class
      #participants.safe_concat(enemies)
      enemies+friends+participants+participant_ins
    end.html_safe if article.all_relations.present?
  end

  def subtitle
    h.content_tag :div, class:'subtitle' do
      edit_link
    end
  end

  def thumb
    h.content_tag :div, class:%w(thumb image).join(' ') do
      h.image_tag article.image_url(:thumb) if article.image_url(:thumb)
    end
  end
end
