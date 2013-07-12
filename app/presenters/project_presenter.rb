class ProjectPresenter < BasePresenter
  presents :project

  def article_form(article, project_id)
    output = nil
    h.present article do |presenter|
      output = presenter.form(project_id)
    end
    output
  end

  # ============= ARTICLES ======================

  def listing(sing,c=[])
    if project.send(sing.to_s.pluralize).present?
      c[0] = (c[0] == '#f5f5dc' ? '#f0f8ff' : '#f5f5dc')
      h.content_tag(:div, class:sing.to_s.pluralize, style:"background: #{c[0]}") do
        h.content_tag(:h2) do
          h.pl(sing)
        end +
        h.content_tag(:ul, class:sing.to_s.pluralize) do
          h.render partial:"articles/article", collection:project.send(sing.to_s.pluralize), locals:{article_type:sing}
        end
      end
    end || "".html_safe
  end
  def characters(c=[]) listing(:character,c) end
  def events(c=[]) listing(:event,c) end
  def places(c=[]) listing(:place,c) end
  def articles
    h.content_tag :div, class:'articles' do
      c = ['#f5f5dc']
      characters(c)+events(c)+places(c)
    end if project.articles.present?
  end

  # =============================================


  def projects
    h.content_tag :div, class:'projects' do
      h.render Project.all
    end
  end

  def title
    h.content_tag :div, class:'title' do
      h.link_to project.title, project
    end
  end
end
