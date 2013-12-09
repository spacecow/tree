class Victim < Relation
  class << self
    def inverse_type; 'Killed by' end
  end
end
