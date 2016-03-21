require "rspec/matchers/define_constant/identity"
require "rspec/matcher"
require "rspec/matchers/define_constant/matcher"

module RSpec
  module Matchers
    # Makes sure block defines a constant and removes the constant after block is
    # done.
    module DefineConstant
    end
  end
end
