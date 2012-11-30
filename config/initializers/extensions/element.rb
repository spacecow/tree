require 'capybara' 

module Capybara
  module Node
    class Simple
      # ============= TAG ============
      def tag(tag,s)
        if s.instance_of? Symbol
          find("#{tag}.#{s}")
        end
      end
      TAGS = %w(span)
      TAGS.each do |t|
        define_method(t){|s| tag(t,s)}
      end
      # ==============================
    end
  end
end
