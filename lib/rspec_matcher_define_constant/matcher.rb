# runs block, checks if it defines constant, removes defined constant
RSpec::Matchers.define :define_constant do |expected|
  attr_accessor :message, :actual

  match do |actual|
    self.actual = actual
    validate_input

    begin
      decision
    # rubocop:disable Lint/RescueException
    rescue Exception # it's fine, we're reraising exception
      # rubocop:enable Lint/RescueException
      remove_expected
      raise
    end
  end

  chain :of_type, :type

  failure_message do
    "expected that block defines #{expected} but #{message}"
  end

  supports_block_expectations

  private

  def validate_input
    return :ok if actual.is_a? Proc
    fail ArgumentError, "define constant needs a proc"
  end

  def decision
    return @decision unless @decision.nil?
    @decision = catch(:decision) { passes? }
    remove_expected

    @decision
  end

  def passes?
    expected_shouldnt_exist
    actual.call
    expected_should_exist

    expected_should_have_correct_type

    throw :decision, true
  end

  def expected_exists?
    Object.const_defined? expected
  end

  def expected_shouldnt_exist
    return true unless expected_exists?

    dont_remove_expected
    self.message = "#{expected} was already defined"
    throw :decision, false
  end

  def expected_should_exist
    return true if expected_exists?

    self.message = "#{expected} did not get defined"
    throw :decision, false
  end

  def expected_should_have_correct_type
    return true if type.nil?

    const = Object.const_get(expected)
    const = const.class unless [Class, Module].include? const.class

    return true if const <= type

    self.message = "#{expected} is not of type #{type} its ancestors are #{const.ancestors}"
    throw :decision, false
  end

  def remove_expected
    return nil unless remove_expected? && expected_exists?
    Object.send(:remove_const, expected)
  end

  def remove_expected?
    return true if @remove_expected.nil?
    @remove_expected
  end

  def dont_remove_expected
    @remove_expected = false
  end
end
