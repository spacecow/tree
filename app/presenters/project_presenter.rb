class ProjectPresenter < BasePresenter
  presents :project

  def characters
    h.content_tag :div, class:%w(articles characters).join(' ') do
      "Characters: #{h.render partial:'articles/character', collection:project.articles}".html_safe
    end if project.characters.present?
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
