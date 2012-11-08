class History < ActiveRecord::Base
  belongs_to :relation
  attr_accessible :content, :issue, :page

  validates :content, presence:true

  def article; relation.article end
end
