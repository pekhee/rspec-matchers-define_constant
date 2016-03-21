module RSpec
  module Matchers
    module DefineConstant
      # Gem identity information.
      module Identity
        def self.name
          "rspec-matchers-define_constant"
        end

        def self.label
          "RSpec::Matchers::DefineConstant"
        end

        def self.version
          "0.1.1"
        end

        def self.version_label
          "#{label} #{version}"
        end
      end
    end
  end
end
