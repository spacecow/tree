class Project < ActiveRecord::Base
  has_many :roles
  has_many :articles, through: :roles

  attr_accessible :title
  validates :title, presence:true

  def characters; articles.where(type:'Character') end
  def events; articles.where(type:'Event') end

  class << self
    def options
      Project.all.map{|e| "<option value='#{e.id}'>#{e.title}</option>"}.join.html_safe
    end
  end
end
