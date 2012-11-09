class Relation < ActiveRecord::Base
  belongs_to :article
  belongs_to :relative, class_name:'Article'
  has_many :histories, as: :historable

  attr_accessible :relative_id

  validates :relative_id, presence:true
  validates :article_id, presence:true
  validates :type, presence:true

  def article_name; article.name end
  def image_url(version,main)
    main.id==article.id ? relative.image_url(version) : article.image_url(version)
  end
  def inverse_name(main)
    main.id==article.id ? relative.name : article.name
  end
  def relative_name; relative.name end
  def title(main); "#{main.name} - #{type}: #{inverse_name(main)}" end
end
