class Relation < ActiveRecord::Base
  belongs_to :article
  belongs_to :relative, class_name:'Article'
  has_many :histories, as: :historable

  attr_reader :relative_token
  attr_accessible :relative_token

  validates :relative_id, presence:true
  validates :article_id, presence:true
  validates :type, presence:true

  TYPES = {'Enemy'       => 'Enemy',
           'Friend'      => 'Friend',
           'Participant' => 'Participant in',
           'Husband'     => 'Wife',
           'Victim'      => 'Killed by',
           'Inhabitant'  => 'Inhabit'}

  def article_name; article.name end
  def image_url(version,main)
    main.id==article.id ? relative.image_url(version) : article.image_url(version)
  end
  def inverse_name(main)
    main.id==article.id ? relative.name : article.name
  end
  def relative_name; relative.name end
  def relative_token=(token)
    self.relative_id = Article.id_from_token(token)
  end
  def title(main); "#{main.name} - #{Kernel.const_get(type).type(main.id==relative.id)}: #{inverse_name(main)}" end

  class << self
    def inverse_type; to_s end
    def type(inverse)
      inverse ? inverse_type : to_s
    end
    def type_options
      types.map{|e| "<option>#{e}</option>"}.join.html_safe
    end
    def types
      TYPES.to_a.flatten.uniq
    end
  end
end
