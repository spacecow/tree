class Role < ActiveRecord::Base
  belongs_to :article
  belongs_to :project
end
