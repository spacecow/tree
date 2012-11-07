class Article < ActiveRecord::Base
  has_many :roles
  has_many :projects, through: :roles

  has_many :relations
  has_many :relatives, through: :relations
  has_many :inverse_relations, class_name:'Relation', foreign_key:'relative_id'
  has_many :inverse_relatives, through: :inverse_relations, source: :article

  attr_accessible :name

  validates :name, presence:true
  validates :type, presence:true

  TYPES = %w(Character Event)

  def all_relations; relations + inverse_relations end
  def enemies
    relations.where(type:'Enemy') + inverse_relations.where(type:'Enemy')
  end
  def friends; relations.where(type:'Friend') end
  def title; "#{name}: #{type}" end
end
