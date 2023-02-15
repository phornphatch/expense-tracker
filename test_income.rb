require 'minitest/autorun'
require 'date'

require './income'

class TestIncome < Minitest::Test
  def test_to_json_should_return_income_in_json_format
    expected = '{"type":"salary","amount":100,"date":"2023-01-30T00:00:00+00:00"}'
    income = Income.new 'salary', 100, DateTime.new(2023, 1, 30)
    assert_equal expected, income.to_json
  end
end
