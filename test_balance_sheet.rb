require 'date'
require 'minitest/autorun'

require './income'
require './expense'
require './balance_sheet'

class TestBalanceSheet < Minitest::Test
  def setup
    @balance_sheet = BalanceSheet.new
    income = Income.new 'salary', 100, DateTime.new(2023, 1, 30)
    income2 = Income.new 'salary', 100, DateTime.new(2023, 1, 30)
    income3 = Income.new 'Bonus', 100, DateTime.new(2023, 1, 30)
    @balance_sheet.add_income(income)
    @balance_sheet.add_income(income2)
    @balance_sheet.add_income(income3)
    expense = Expense.new 'SSF', 50, DateTime.new(2023, 1, 30)
    expense2 = Expense.new 'Tax', 30, DateTime.new(2023, 1, 30)
    @balance_sheet.add_expense(expense)
    @balance_sheet.add_expense(expense2)
  end

  def test_total_income_should_sum_the_correct_number
    assert_equal 300, @balance_sheet.total_income
  end

  def test_total_SSF_should_sum_only_SSF_expense
    assert_equal 50, @balance_sheet.total_SSF
  end

  def test_total_withholding_tax_should_sum_only_withholding_tax_expense
    assert_equal 30, @balance_sheet.total_witholding_tax
  end

  def test_net_income_should_correctly_compute_net_income
    assert_equal 220, @balance_sheet.net_income
  end

  def test_total_bonus_should_sum_only_bonus_income
    assert_equal 100, @balance_sheet.total_bonus
  end

  def test_to_json_should_return_balance_sheet_in_json_format
    expected = '{"incomes":[{"type":"salary","amount":100,"date":"2023-01-30T00:00:00+00:00"},{"type":"salary","amount":100,"date":"2023-01-30T00:00:00+00:00"},{"type":"Bonus","amount":100,"date":"2023-01-30T00:00:00+00:00"}],"expenses":[{"type":"SSF","amount":50,"date":"2023-01-30T00:00:00+00:00"},{"type":"Tax","amount":30,"date":"2023-01-30T00:00:00+00:00"}]}'
    assert_equal expected, @balance_sheet.to_json
  end
end
