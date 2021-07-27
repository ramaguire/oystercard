require 'oystercard.rb'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:limit) { Oystercard::LIMIT }
  let(:station) { double :station }

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do
    it 'adds money to the card balance' do
      expect(card.top_up(10)).to eq (10)
    end

    it 'can top up the balance' do
      expect{ card.top_up 1 }.to change{ card.balance }.by 1
    end

    it 'prevents topping up balance if it would go over the limit' do
      card.top_up(limit)
      expect { card.top_up 1 }.to raise_error "Top up would exceed limit of #{limit}."
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
      card.touch_out
      expect(card.journey?).to eq false
    end

    it 'deduces minimum fare when user touches out' do
      minimum_fare = Oystercard::MINIMUM_FARE
      expect { card.touch_out }.to change {card.balance}.by -minimum_fare
    end

    it 'forgets the entry station after touch out' do
      card.top_up(limit)
      card.touch_in(station)
      expect { card.touch_out }.to change {card.entry_station}.to nil
    end
  end

end
