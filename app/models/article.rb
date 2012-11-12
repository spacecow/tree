class Article < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  has_many :projects, through: :roles

  has_many :relations
  has_many :relatives, through: :relations
  has_many :inverse_relations, class_name:'Relation', foreign_key:'relative_id'
  has_many :inverse_relatives, through: :inverse_relations, source: :article

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessible :name, :description, :image, :crop_x, :crop_y, :crop_w, :crop_h

  mount_uploader :image, ImageUploader

  validates :name, presence:true
  validates :type, presence:true

  after_update :crop_image

  TYPES = %w(Character Event)

  def all_relations; relations + inverse_relations end
  def crop_image
    image.recreate_versions! if crop_x.present?
  end
  def enemies
    relations.where(type:'Enemy') + inverse_relations.where(type:'Enemy')
  end
  def friends; relations.where(type:'Friend') end
  def participants; relations.where(type:'Participant') end
  def participant_ins; inverse_relations.where(type:'Participant') end
  def title; "#{name}: #{type}" end
end
