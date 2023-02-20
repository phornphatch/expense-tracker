require 'json'

class BalanceSheet
  def initialize
    @incomes = []
    @expenses = []
  end

  def total_income
    @incomes.sum(0) { |income| income.amount }
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

  private def sum_by_type(type, transactions)
    transactions.sum(0) do |transaction|
      return transaction.amount if transaction.type == type
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
