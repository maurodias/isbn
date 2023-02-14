require 'forwardable'
require_relative '../isbn'

class Isbn::CheckDigitCalculator
  def self.call(isbn:)
    new(isbn: isbn).call
  end

  def initialize(isbn:)
    @isbn = isbn
  end

  def call
    return 0 if calculated_digit == 10

    calculated_digit
  end

  private

  extend Forwardable

  attr_reader :isbn

  def_delegators :isbn, :without_check_digit_digits

  def calculated_digit
    @calculated_digit ||= 10 - (digits_per_factor_sum % 10)
  end

  def digits_per_factor_sum
    without_check_digit_digits.to_enum.with_index.sum do |digit, index|
      factor = index.even? ? 3 : 1
      factor * digit
    end
  end
end
