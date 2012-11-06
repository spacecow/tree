class Role < ActiveRecord::Base
  belongs_to :article
  belongs_to :project

  attr_accessible :article_id, :project_id
end
