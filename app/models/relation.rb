class Relation < ActiveRecord::Base
  belongs_to :article
  belongs_to :relative, class_name:'Article'
  has_many :histories, as: :historable

  attr_accessible :relative_id

  validates :relative_id, presence:true
  validates :article_id, presence:true
  validates :type, presence:true

  TYPES = %w(Enemy Friend Participant)

  def article_name; article.name end
  def image_url(version,main)
    main.id==article.id ? relative.image_url(version) : article.image_url(version)
  end
  def inverse_name(main)
    main.id==article.id ? relative.name : article.name
  end
  def relative_name; relative.name end
  def title(main); "#{main.name} - #{Kernel.const_get(type).type(main.id==relative.id)}: #{inverse_name(main)}" end

  class << self
    def inverse_type; to_s end
    def type(inverse)
      inverse ? inverse_type : to_s 
    end
    def type_options
      TYPES.map{|e| "<option>#{e}</option>"}.join.html_safe
    end
  end
end
