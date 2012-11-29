class ArticlePresenter < BasePresenter
  presents :article


  def form(project_id=nil)
    h.render 'articles/form', article:article, project_id:project_id if h.can? :new, Article
  end


  def histories
    h.content_tag :div, class:'histories' do
      h.render article.histories
    end if article.histories.present?
  end

  def history_form
    h.render 'histories/form', history:History.new, article_id:article.id, relation_id:nil if h.can? :new, History
  end



  def name
    h.content_tag :div, class:'name' do
      h.link_to article.name, h.article_path(article)
    end
  end


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

  # ============= RELATIONS ======================

  def listing(sing,c=[])
    if article.send(sing.to_s.pluralize).present?
      c[0] = (c[0] == '#f5f5dc' ? '#f0f8ff' : '#f5f5dc')
      h.content_tag(:div, class:sing.to_s.pluralize, style:"background: #{c[0]}") do
        h.content_tag(:h2) do
          h.pl(sing)
        end +
        h.content_tag(:ul, class:sing.to_s.pluralize) do
          h.render partial:"relations/relation", collection:article.send(sing.to_s.pluralize), locals:{main:article, relation_type:sing}
        end
      end
    else
      ""
    end.html_safe
  end
  def enemies(c=[]) listing(:enemy,c) end
  def friends(c=[]) listing(:friend,c) end
  def husbands(c=[]) listing(:husband,c) end
  def killed_bies(c=[]) listing(:killed_by,c) end
  def participants(c=[]) listing(:participant,c) end
  def participant_ins(c=[]) listing(:participant_in,c) end
  def victims(c=[]) listing(:victim,c) end
  def wifes(c=[]) listing(:wife,c) end
  def relations
    h.content_tag :div, class:'relations' do
      c = ['#f5f5dc'] 
      husbands(c)+wifes(c)+enemies(c)+friends(c)+participants(c)+participant_ins(c)+victims(c)+killed_bies(c)
    end.html_safe if article.all_relations.present?
  end

  # ==============================================

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
