require 'spec_helper'
require_relative '../isbn/check_digit_calculator'

RSpec.describe Isbn::CheckDigitCalculator do
  describe ".call" do
    let(:isbn) { double(without_check_digit_digits: number.digits) }

    subject { described_class.call(isbn: isbn) }

    context "when it receives a Isbn object with a at least 12 length number" do
      let(:number) { 123456789012 }

      it "retrieves the calculated check digit" do
        expect(subject).to eq 8
      end
    end
  end
end

