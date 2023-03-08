require 'sinatra'
require 'json'
require './balance_sheet'
require './income'
require 'date'

bs = nil
configure do
  data = File.read('./db.json')
  parsed_data = JSON.parse(data)
  bs = BalanceSheet.new
  bs.from_hash(parsed_data)
end

get '/' do
  erb :index, locals: { x: bs }
end

post '/income' do
  if params['income-salary'].to_i > 0
    type = 'salary'
    amount = params['income-salary'].to_i
    income = Income.new type, amount, DateTime.now, params['note']
    bs.add_income(income)
  end

  if params['income-bonus'].to_i > 0
    type = 'bonus'
    amount = params['income-bonus'].to_i
    income = Income.new type, amount, DateTime.now, params['note']
    bs.add_income(income)
  end

  if params['income-allowance'].to_i > 0
    type = 'allowance'
    amount = params['income-allowance'].to_i
    income = Income.new type, amount, DateTime.now, params['note']
    bs.add_income(income)
  end

  if params['income-others'].to_i > 0
    type = 'others'
    amount = params['income-others'].to_i
    income = Income.new type, amount, DateTime.now, params['note']
    bs.add_income(income)
  end

  File.open('db.json', 'w') { |f| f.write(bs.to_json) }

  redirect to('/')
end

delete '/income' do
  bs.delete('income')
  File.open('db.json', 'w') { |f| f.write(bs.to_json) }

  redirect to('/')
end

post '/expense' do
  if params['expense-ssf'].to_i > 0
    type = 'SSF'
    amount = params['expense-ssf'].to_i
    expense = Expense.new type, amount, DateTime.now, params['note']
    bs.add_expense(expense)
  end

  if params['expense-tax'].to_i > 0
    type = 'Tax'
    amount = params['expense-tax'].to_i
    expense = Expense.new type, amount, DateTime.now, params['note']
    bs.add_expense(expense)
  end

  if params['expense-others'].to_i > 0
    type = 'others'
    amount = params['expense-others'].to_i
    expense = Expense.new type, amount, DateTime.now, params['note']
    bs.add_expense(expense)
  end

  File.open('db.json', 'w') { |f| f.write(bs.to_json) }

  redirect to('/')
end

delete '/expense' do
  bs.delete('expense')
  File.open('db.json', 'W') { |f| f.write(bs.to_json) }
end
