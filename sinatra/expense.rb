require 'json'
require 'date'

class Expense
  attr_accessor :type, :amount, :date, :note

  def self.from_hash(hash)
    self.new hash["type"], hash["amount"], DateTime.parse(hash["date"]), hash["note"]
  end

  def initialize(type, amount, date, note)
    @type = type
    @amount = amount
    @date = date
    @note = note
  end

  def to_json(*_args)
    { type: @type, amount: @amount, date: @date, note: @note }.to_json
  end
end
