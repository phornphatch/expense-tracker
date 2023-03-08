require 'json'

class BalanceSheet
  def initialize
    @incomes = []
    @expenses = []
  end

  def total_income
    @incomes.sum(0) { |income| income.amount }
  end

  def total_expense
    @expenses.sum(0) { |expense| expense.amount }
  end

  def total_SSF
    sum_by_type('SSF', @expenses)
  end

  def total_witholding_tax
    sum_by_type('Tax', @expenses)
  end

  def net_income
    total_income - total_SSF - total_witholding_tax
  end

  def total_bonus
    sum_by_type('Bonus', @incomes)
  end

  def group_income
    result = {}
    @incomes.group_by { |i| i.date.iso8601 }.each do |date, i|
      income_by_date = {
        salary: 0,
        bonus: 0,
        allowance: 0,
        others: 0,
      }
      income_by_date[:salary] += sum_by_type('Salary', i)
      income_by_date[:bonus] += sum_by_type('Bonus', i)
      income_by_date[:allowance] += sum_by_type('Allowance', i)
      income_by_date[:others] += sum_by_type('Others', i)
      income_by_date[:note] = i[0].note

      result[date] = income_by_date
    end
    result
  end

  def group_expense
    result = {}
    @expenses.group_by { |e| e.date.iso8601 }.each do |date, e|
      expense_by_date = {
        SSF: 0,
        Tax: 0,
        others: 0,
      }
      expense_by_date[:SSF] += sum_by_type('SSF', e)
      expense_by_date[:Tax] += sum_by_type('Tax', e)
      expense_by_date[:others] += sum_by_type('Others', e)
      expense_by_date[:note] = e[0].note

      result[date] = expense_by_date
    end
    result
  end

  private def sum_by_type(type, transactions)
    transactions.sum(0) do |transaction|
      return transaction.amount if transaction.type.downcase == type.downcase
      0
    end
  end

  def add_income(income)
    @incomes << income
  end

  def add_expense(expense)
    @expenses << expense
  end

  def from_hash(json_data)
    @incomes = json_data['incomes'].map { |i| Income.from_hash(i) } if json_data['incomes']
    @expenses = json_data['expenses'].map { |e| Expense.from_hash(e) } if json_data['expenses']
  end

  def delete(type)
    @expenses = [] if type == 'expense'
    @incomes = [] if type == 'income'
  end

  def to_json(*_args)
    {
      incomes: @incomes,
      expenses: @expenses
    }.to_json
  end
end
