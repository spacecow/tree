class Inhabitant < Relation
  class << self
    def inverse_type; 'Inhabit' end
  end
end
