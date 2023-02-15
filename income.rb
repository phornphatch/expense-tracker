require 'json'
require 'date'

class Income
  attr_accessor :type, :amount, :date

  def self.from_hash(hash)
    self.new hash["type"], hash["amount"], DateTime.parse(hash["date"])
  end

  def initialize(type, amount, date)
    @type = type
    @amount = amount
    @date = date
  end

  def to_json(*_args)
    { type: @type, amount: @amount, date: @date }.to_json
  end
end
