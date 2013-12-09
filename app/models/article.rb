class Article < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  has_many :projects, through: :roles

  has_many :relations
  has_many :relatives, through: :relations
  has_many :inverse_relations, class_name:'Relation', foreign_key:'relative_id'
  has_many :inverse_relatives, through: :inverse_relations, source: :article

  has_many :histories, as: :historable

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessible :name, :description, :image, :crop_x, :crop_y, :crop_w, :crop_h

  mount_uploader :image, ImageUploader

  validates :name, presence:true
  validates :type, presence:true
  #validates :projects, presence:true

  after_update :crop_image

  TYPES = %w(Character Event Place Concept Organization)

  def all_relations; relations + inverse_relations end
  def crop_image
    image.recreate_versions! if crop_x.present?
  end

  Relation.types.each do |relation|
    define_method relation.downcase.gsub(/ /,'_').pluralize do
      if Relation::TYPES[relation] == relation
        relations.where(type:relation) + inverse_relations.where(type:relation)
      elsif Relation::TYPES[relation]
        relations.where(type:relation)
      else
        key = Relation::TYPES.select{|k,v| v == relation}.keys.first
        inverse_relations.where(type:key)
      end
    end
  end

  def title; "#{name}: #{type}" end

  class << self
    def id_from_token(token)
      token.gsub!(/<<<(.+?):(.+?)>>>/) do
        article = new(name:$1)
        article.type = $2
        article.save
        article.id
      end
      token
    end
    def token(query)
      articles = where("name like ?", "%#{query}%")
      if articles.empty?
        [{id: "<<<#{query}>>>", name: "New \"#{query}\""}]
      else
        articles
      end
    end
  end
end
