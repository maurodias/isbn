require "spec_helper"
require_relative "../isbn"
require_relative "../isbn/number"

RSpec.describe Isbn::Number do
  subject { described_class.new(number: number) }

  let(:check_digit_calculator_double) { double(call: 4) }

  before { subject.check_digit_calculator = check_digit_calculator_double }

  describe "#valid?" do
    context "when number is not 12 or 13 length" do
      let(:number) { 123456 }

      it { expect(subject).not_to be_valid }
    end

    context "when number is 12 length and was not validated still" do
      let(:number) { 123456789012 }

      it { expect(subject).not_to be_valid }
    end

    context "when number is 13 length" do
      context "when check digit is wrong" do
        let(:number) { 9780143007231 }

        it { expect(subject).not_to be_valid }
      end

      context "when check digit is correct" do
        let(:number) { 9780143007234 }

        it { expect(subject).to be_valid }
      end
    end
  end

  describe "#validate_number!" do
    context "when number is not 12 or 13 length" do
      let(:number) { 123456 }

      it { expect { subject.validate_number! }.to raise_error Isbn::InvalidLengthException }
    end

    context "when number is 12 or 13 lenght" do
      let(:expected_number) { "1234567890124" }

      context "when number is 12 length" do
        let(:number) { 123456789012 }

        it { expect(subject.validate_number!).to eq expected_number }
        it { expect { subject.validate_number! }.to change { subject.number }.from(number).to(expected_number) }
      end

      context "when number is 13 length" do
        context "when number is not valid" do
          let(:number) { 1234567890121 }

          it { expect(subject.validate_number!).to eq expected_number }
          it { expect { subject.validate_number! }.to change { subject.number }.from(number).to(expected_number) }
          it { expect { subject.validate_number! }.to change { subject.valid? }.from(false).to(true) }

          context "when number comes as string" do
            let(:number) { "1234567890121" }

            it { expect { subject.validate_number! }.to change { subject.number }.from(number).to(expected_number) }
          end
        end

        context "when number is already valid" do
          let(:number) { 1234567890124 }

          it { expect(subject.validate_number!).to eq expected_number }
          it { expect { subject.validate_number! }.to change { subject.number }.from(number).to(expected_number) }
          it { expect { subject.validate_number! }.not_to change { subject.valid? } }
        end
      end
    end
  end
end
