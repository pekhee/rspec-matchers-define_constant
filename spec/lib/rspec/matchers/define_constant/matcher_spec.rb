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
          raise
        end
      end

      it "rejects and removes constant" do
        matcher = define_constant "Stuff"

        begin
          matcher.matches? subject
        rescue
          expect(true).to be_truthy # make sure this line runs
        end

        expect(Object.const_defined?("Stuff")).to be_falsy
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

  context "constant previously defined" do
    subject do
      proc { :probe }
    end

    let(:const_name) { "SQDCTW" }

    before(:each) { Object.const_set const_name, :probe }
    after(:each)  { Object.send :remove_const, const_name }

    it "rejects" do
      expect(&subject).not_to define_constant const_name
    end

    it "won't remove const" do
      define_constant(const_name).matches? subject
      expect(Object.const_defined?(const_name)).to be_truthy
    end
  end

  context "without a proc" do
    subject { :probe }

    it "raises argument error" do
      matcher = define_constant "Stuff"

      expect do
        matcher.matches? subject
      end.to raise_error ArgumentError
    end
  end
end
