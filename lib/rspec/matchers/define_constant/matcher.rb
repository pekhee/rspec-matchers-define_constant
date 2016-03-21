module RSpec
  module Matchers
    module DefineConstant
      # runs block, checks if it defines constant, removes defined constant
      class Matcher
        include RSpec::Matcher
        register_as :define_constant
        attr_accessor :type

        def match
          validate_input
          expected_shouldnt_exist
          actual.call
          expected_should_exist
          expected_should_have_correct_type

          true
        end

        def description
          "define constant"
        end

        def supports_block_expectations?
          true
        end

        def of_type type
          self.type = type and self
        end

        private

        def validate_input
          actual.is_a? Proc or raise ArgumentError, "define constant needs a proc"
        end

        def expected_exists?
          Object.const_defined? expected
        end

        def expected_shouldnt_exist
          return true unless expected_exists?

          dont_remove_expected
          reject_expectation "#{expected} was already defined"
        end

        def expected_should_exist
          expected_exists? or reject_expectation "#{expected} did not get defined"
        end

        def expected_should_have_correct_type
          return true if type.nil?

          const = Object.const_get(expected)
          const = const.class unless [Class, Module].include? const.class

          return true if const <= type

          reject_expectation "#{expected} is not of type #{type} its ancestors are #{const.ancestors}"
        end

        def remove_expected
          return nil unless remove_expected? && expected_exists?
          Object.send(:remove_const, expected)
        end
        alias_method :clean_up, :remove_expected

        def remove_expected?
          return true if @remove_expected.nil?
          @remove_expected
        end

        def dont_remove_expected
          @remove_expected = false
        end
      end
    end
  end
end
