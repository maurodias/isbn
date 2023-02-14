require_relative '../isbn/invalid_length_exception'
require_relative '../isbn/check_digit_calculator'

class Isbn::Number
  attr_reader :number
  attr_writer :check_digit_calculator

  WITHOUT_CHECK_DIGIT_LENGTH = 12
  WITH_CHECK_DIGIT_LENGTH = 13

  def initialize(number:)
    @number = number
    @check_digit_calculator = check_digit_calculator
  end

  def valid?
    allowed_length? && valid_check_digit?
  end

  def validate_number!
    raise Isbn::InvalidLengthException unless allowed_length?

    self.number = valid_number
  end

  private

  attr_writer :number

  DEFAULT_CHECK_DIGIT_CALCULATOR = Isbn::CheckDigitCalculator
  CHECK_DIGIT_POSITION = 12

  def ordered_digits
    number.to_i.digits.reverse
  end

  def length
    ordered_digits.size
  end

  def without_digit?
    length == WITHOUT_CHECK_DIGIT_LENGTH
  end

  def without_check_digit_digits
    ordered_digits[0..11]
  end

  def check_digit
    check_digit_calculator.call(isbn: self)
  end

  def valid_check_digit?
    check_digit.to_s == ordered_digits[CHECK_DIGIT_POSITION].to_s
  end

  def valid_number
    [*without_check_digit_digits, check_digit].join
  end

  def allowed_length?
    [WITHOUT_CHECK_DIGIT_LENGTH,  WITH_CHECK_DIGIT_LENGTH].include? length
  end

  def check_digit_calculator
    @check_digit_calculator ||= DEFAULT_CHECK_DIGIT_CALCULATOR
  end
end
