class Participant < Relation
  class << self
    def inverse_type; 'Participant in' end
  end
end
