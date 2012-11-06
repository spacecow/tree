class Article < ActiveRecord::Base
  has_many :roles
  has_many :projects, through: :roles

  has_many :relations
  has_many :relatives, through: :relations

  attr_accessible :name, :new_relation_attributes

  validates :name, presence:true
  validates :type, presence:true

  TYPES = %w(Create)

  def enemies; relations.where(type:'Enemy') end
  def friends; relations.where(type:'Friend') end
end
