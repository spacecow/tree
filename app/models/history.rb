class History < ActiveRecord::Base
  belongs_to :relation
  attr_accessible :content, :issue, :page

  def article; relation.article end
end
