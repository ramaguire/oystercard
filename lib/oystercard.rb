class Oystercard

  attr_reader :balance, :LIMIT, :in_journey
  LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false

  end

  def top_up(money)
    fail "Top up would exceed limit of #{LIMIT}." if (@balance + money > 90)
    @balance += money
  end

  def deduct(fare)
    @balance -= fare
  end

  def journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

end
