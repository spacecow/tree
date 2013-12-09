class Project < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  has_many :articles, through: :roles

  attr_accessible :title
  validates :title, presence:true

  def characters; articles.where(type:'Character') end
  def concepts; articles.where(type:'Concept') end
  def events; articles.where(type:'Event') end
  def organizations; articles.where(type:'Organization') end
  def places; articles.where(type:'Place') end

  class << self
    def options
      Project.all.map{|e| "<option value='#{e.id}'>#{e.title}</option>"}.join.html_safe
    end
  end
end
