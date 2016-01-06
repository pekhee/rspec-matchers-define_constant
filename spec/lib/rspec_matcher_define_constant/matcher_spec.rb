require "spec_helper"

describe "RSpecMatcherDefineConstant" do
  context "constant being defined" do
    subject do
      proc { Object.const_set "Stuff", :probe }
    end

    it "accepts" do
      expect(&subject).to define_constant "Stuff"
    end

    context "with specified type" do
      context "and is not a class" do
        it "accepts correct type" do
          expect(&subject).to define_constant("Stuff").of_type Symbol
        end

        it "rejects wrong type" do
          expect(&subject).not_to define_constant("Stuff").of_type Fixnum
        end
      end

      context "and is a class" do
        subject do
          proc { Object.const_set "Stuff", Symbol }
        end

        it "accepts correct type" do
          expect(&subject).to define_constant("Stuff").of_type Symbol
        end

        it "rejects wrong type" do
          expect(&subject).not_to define_constant("Stuff").of_type Fixnum
        end
      end
    end

    context "but block raises" do
      subject do
        proc do
          Object.const_set "Stuff", :probe
          fail
        end
      end

      it "rejects and removes constant" do
        matcher = define_constant "Stuff"

        begin
          matcher.matches? subject
        rescue
          expect(true).to be_truthy # make sure this line runs
        end

        expect(Object.const_defined? "Stuff").to be_falsy
      end
    end
  end

  context "constant NOT being defined" do
    subject do
      proc { :probe }
    end

    it "rejects" do
      expect(&subject).not_to define_constant "Stuff"
    end
  end
end
