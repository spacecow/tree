class ProjectsController < ApplicationController
  load_and_authorize_resource

  def show
    @article = Article.new
  end

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end
end
