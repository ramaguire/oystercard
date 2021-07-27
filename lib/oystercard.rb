class Oystercard

  attr_reader :balance, :LIMIT, :in_journey, :MINIMUM_FARE, :entry_station
  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station

  end

  def top_up(money)
    fail "Top up would exceed limit of #{LIMIT}." if (@balance + money > 90)
    @balance += money
  end

  def journey?
    if @entry_station
      true
    else
      false
    end
  end

  def touch_in(station)
    fail 'Not enough funds to travel' unless balance >= MINIMUM_FARE
    @entry_station = (station)
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private

    def deduct(fare)
      @balance -= fare
    end

end
