require 'station'
require 'journey'

class Oystercard

  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journeys
  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station
    @exit_station
    @journeys = {}

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
    @journeys[:entry_station] = (station)
    p @journeys
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = station
    @journeys[:exit_station] = (station)
  end

  private

    def deduct(fare)
      @balance -= fare
    end

end
