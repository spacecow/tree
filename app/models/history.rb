class History < ActiveRecord::Base
  belongs_to :historable, polymorphic:true
  attr_accessible :content, :issue, :page

  validates :content, presence:true
  validates :historable, presence:true

  def article; relation.article end
end
