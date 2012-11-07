class Relation < ActiveRecord::Base
  belongs_to :article
  belongs_to :relative, class_name:'Article'
  has_many :histories

  attr_accessible :relative_id

  validates :relative_id, presence:true
  validates :article_id, presence:true
  validates :type, presence:true

  def article_name; article.name end
  def inverse_name(main); main.id==article.id ? relative.name : article.name end
  def relative_name; relative.name end
  def title(main); "#{main.name} - #{type}: #{inverse_name(main)}" end
end
