require './income'
require './expense'
require './balance_sheet'
require 'json'
require 'date'

data = File.read('./db.json')
parsed_data = JSON.parse(data)
bs = BalanceSheet.new
bs.from_hash(parsed_data)

if ARGV[0] == 'add-income'
  type = ARGV[1]
  amount = ARGV[2].to_i
  date = ARGV[3]
  income = Income.new type, amount, DateTime.parse(date)
  bs.add_income(income)
end

if ARGV[0] == 'add-expense'
  type = ARGV[1]
  amount = ARGV[2].to_i
  date = ARGV[3]
  expense = Expense.new type, amount, DateTime.parse(date)
  bs.add_expense(expense)
end

if ARGV[0] == 'net-income'
  p bs.net_income
end

File.open('db.json', 'w') { |f| f.write(bs.to_json) }
