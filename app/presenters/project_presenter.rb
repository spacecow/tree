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

  def listing(sing)
    h.content_tag(:h2) do
      h.pl(sing)
    end +
    h.content_tag(:ul, class:sing.to_s.pluralize) do
      h.render partial:"articles/#{sing}", collection:project.send(sing.to_s.pluralize)
    end if project.send(sing.to_s.pluralize).present?
  end

  def characters; listing(:character) end
  def events; listing(:event) end

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
