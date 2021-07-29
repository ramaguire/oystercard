require 'oystercard.rb'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:limit) { Oystercard::LIMIT }
  let(:station) { double :station }
  let(:entry_station) { double :station }
    let(:exit_station) { double :station }

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do
    it 'adds money to the card balance' do
      expect(card.top_up(limit)).to eq (limit)
    end

    it 'can top up the balance' do
      expect{ card.top_up limit }.to change{ card.balance }.by limit
    end

    it 'prevents topping up balance if it would go over the limit' do
      card.top_up(limit)
      expect { card.top_up limit }.to raise_error "Top up would exceed limit of #{limit}."
    end
  end

  # it 'can deduct the balance' do
  #   expect{ card.deduct 1 }.to change{ card.balance }.by -1
  # end

  it 'starts not in journey' do
    expect(card.journey?).to eq false
  end

  describe '#touch_in' do

    it 'starts journey when user touches in' do
      card.top_up(limit)
      card.touch_in(station)
      expect(card.journey?).to eq true
    end

    it 'prevents user touching in if balance is less than £1' do
      expect{ card.touch_in(station) }.to raise_error 'Not enough funds to travel'
    end

    it 'remembers the entry station after touch in' do
      card.top_up(limit)
      expect { card.touch_in(station) }.to change {card.entry_station}.to station
    end
  end

  describe '#touch_out' do
    it 'ends journey when user touches out' do
      card.top_up(limit)
      card.touch_in(station)
      card.touch_out(station)
      expect(card.journey?).to eq false
    end

    it 'deducts minimum fare when user touches out' do
      minimum_fare = Oystercard::MINIMUM_FARE
      expect { card.touch_out(station) }.to change {card.balance}.by -minimum_fare
    end

    it 'forgets the entry station after touch out' do
      card.top_up(limit)
      card.touch_in(station)
      expect { card.touch_out(station) }.to change {card.entry_station}.to nil
    end

    it 'remembers exit station after touch out' do
      card.top_up(limit)
      card.touch_in(station)
      expect(card.touch_out(station)).to eq station
    end
  end

  it 'starts with an empty list of journeys' do
    expect(card.journeys).to be_empty
  end

  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'stores a journey' do
    card.top_up(limit)
    card.touch_in(entry_station)
    card.touch_out(exit_station)
    expect(subject.journeys).to include journey
  end

end
