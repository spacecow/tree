class ProjectPresenter < BasePresenter
  presents :project

  def article_form(article, project_id)
    output = nil
    h.present article do |presenter|
      output = presenter.form(project_id)
    end
    output
  end 

  def articles
    h.content_tag :div, class:'articles' do
      characters+events
    end if project.articles.present?
  end

  def characters
    h.content_tag(:h2) do
      'Characters'
    end +
    h.content_tag(:ul, class:'characters') do
      h.render partial:'articles/character', collection:project.characters
    end if project.characters.present?
  end

  def events
    h.content_tag :div, class:'events' do
      "Events: #{h.render partial:'articles/event', collection:project.events}".html_safe
    end if project.events.present?
  end

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
