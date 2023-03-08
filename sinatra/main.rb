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

bs.net_income if ARGV[0] == 'net-income'

if ARGV[0] == 'delete-all'
  type = ARGV[1]
  if type.nil?
    p 'please specify type ex. delete-all income'
    exit 1
  end
  
  unless %w[income expense].include?(type)
    p 'please specify valid type (income or expense)'
    exit 1
  end
  
  bs.delete(type)
  p 'done'
end

File.open('db.json', 'w') { |f| f.write(bs.to_json) }
