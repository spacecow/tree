class Relation < ActiveRecord::Base
  belongs_to :article
  belongs_to :relative, class_name:'Article'

  attr_accessible :relative_id

  #validates :relative_id, presence:true

  def name; relative.name end
end
