class Project < ActiveRecord::Base
  has_many :roles
  has_many :articles, through: :roles

  attr_accessible :title
  validates :title, presence:true

  def characters; articles.where(type:'Character') end
end
