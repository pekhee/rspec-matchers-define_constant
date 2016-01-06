require "spec_helper"

RSpec.describe "a block that defines a constant" do
  subject do
    proc do
      Object.const_set "Stuff", 1
    end
  end

  it "defines Stuff" do
    expect { subject.call }.to define_constant "Stuff"
    # Stuff is not defined here.
  end
end
